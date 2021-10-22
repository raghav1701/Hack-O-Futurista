import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

/*
  Constants
*/
const collections = {
  users: 'users',
  managers: 'managers',
  transactions: 'transactions',
  vehicles: 'vehicles',
};

const userRoles = {
  driver: 1,
  manager: 2,
};

const tempManagers: Array<string> = [
  "manager@mail.com",
  "pvr.mbd@mail.com",
  "wave.mbd@mail.com",
  "vcomplex.ghz@mail.com",
  "testmanager@mail.com",
  "admin@mail.com",
  "bt19cse090@iiitn.ac.in",
];

/*
    Auth Trigger (new user signup)

    for background triggers we must return a value/promise
*/
export const userSignup = functions.auth.user().onCreate(async (user) => {
  if (user.email == null) {
    throw new Error("Invalid Email");
  }

  const level = tempManagers.includes(user.email)
      ? userRoles.manager
      : userRoles.driver;

  if (level == userRoles.driver) {
    await admin.firestore().collection(collections.users).doc(user.uid).set({
      balance: 0,
      lastTransaction: admin.firestore.Timestamp.now(),
    });
  } else {
    await admin.firestore().collection(collections.managers).doc(user.uid).set({
      balance: 0,
      initialHourCharges: 30,
      perHourCharges: 30,
      autoSlotBooking: false,
      lastTransaction: admin.firestore.Timestamp.now(),
      map: [
        "0110330110",
        "4555555553",
        "4551151553",
        "3551151551",
        "3551151551",
        "5551151551",
        "1551151551",
        "1551151551",
        "1551151551",
        "1551151551",
        "5551151551",
        "0660000770"
      ],
    });
  }

  return await admin.auth().setCustomUserClaims(user.uid, {
    accessLevel: level,
  });
});

/*
  Vehicle Enters Parking
*/
export const enterParking = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'only authenticated users can proceed ahead',
    );
  }

  const parkId: string = data.pid;
  const parkName: string = data.pname;
  const vehicleId: string = data.vehicleId;
  const slotRC: Array<number> | undefined = data.slot;

  const userId = await admin.firestore().collection(collections.vehicles)
    .where("vid", "==", vehicleId).get().then(value => {
      return value.docs[0].data()!['uid'] as string;
    });

  const pDoc = await admin.firestore().collection(collections.managers).doc(parkId).get();

  const pDat = pDoc.data()!;
  const pChg: number = pDat['initialHourCharges'];
  const pPhg: number = pDat['perHourCharges'];
  const pMap: Array<string> = pDat['map'];

  if (slotRC != undefined) {
    await admin.firestore().collection(collections.managers).doc(parkId).update({
      map: updateMap(2, slotRC[0], slotRC[1], pMap),
    })
  }

  const tid = await admin.firestore().collection(collections.transactions).add({
    uid: userId,
    parking: parkId,
    parkName: parkName,
    vehicle: vehicleId,
    slot: slotRC ?? [-1, -1],
    timeEntry: admin.firestore.Timestamp.now(),
    timeExit: admin.firestore.Timestamp.now(),
    amount: pChg,
    perHourCharge: pPhg,
    status: slotRC == undefined ? 0 : 1,
  });

  return tid.id;
});

/*
  Book Slot Manually
*/
export const bookSlot = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'only authenticated users can proceed ahead',
    );
  }

  const tid: string = data.tid;
  const parkId: string = data.pid;
  const slotRC: Array<number> = data.slot;

  const pDoc = await admin.firestore().collection(collections.managers).doc(parkId).get();
  const pDat = pDoc.data()!;
  const pMap: Array<string> = pDat['map'];

  await admin.firestore().collection(collections.managers).doc(parkId).update({
    map: updateMap(2, slotRC[0], slotRC[1], pMap),
  })

  await admin.firestore().collection(collections.transactions).doc(tid).update({
    slot: slotRC,
    status: 1,
  });

  return "Booking Complete";
});


/*
  Vehicle Exits Parking
*/
export const exitParking = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'only authenticated users can proceed ahead',
    );
  }

  const parkId: string = data.pid;
  const vehicleId: string = data.vehicleId;

  const userId = await admin.firestore().collection(collections.vehicles)
    .where("vid", "==", vehicleId).get().then(value => {
      return value.docs[0].data()!['uid'] as string;
    });

  const pDoc = await admin.firestore().collection(collections.managers).doc(parkId).get();
  const udoc = await admin.firestore().collection(collections.users).doc(userId).get();
  const tdoc = await admin.firestore().collection(collections.transactions)
    .where("vehicle", "==", vehicleId).where("status", "==", 1).get().then(value => {
      return value.docs[0];
    });

  const pDat = pDoc.data()!;
  const pMap: Array<string> = pDat['map'];
  const slotRC: Array<number> = tdoc.data()!['slot']

  const entry: admin.firestore.Timestamp = tdoc.data()!['timeEntry'];
  const exit = admin.firestore.Timestamp.now();
  const charges = pDat['initialHourCharges'] + Math.ceil((exit.seconds - entry.seconds) / 3600) * pDat['perHourCharges'];

  await admin.firestore().collection(collections.users).doc(userId).update({
    balance: udoc.data()!['balance'] - charges,
    lastTransaction: exit,
  });

  await admin.firestore().collection(collections.managers).doc(parkId).update({
    balance: pDat['balance'] + charges,
    lastTransaction: exit,
    map: updateMap(1, slotRC[0], slotRC[1], pMap),
  })

  await admin.firestore().collection(collections.transactions).doc(tdoc.id).update({
    timeExit: exit,
    amount: charges,
    status: 2,
  });

  return "Transaction Complete";
});

function updateMap(value: number, row: number, col: number, map: string[]): string[] {
  let pmap: Array<string> = [];
  for (let i=0 ; i<map.length ; ++i) {
    if (row != i) {
      pmap.push(map[i]);
    } else {
      const x = map[i].split("");
      x[col] = value.toString();
      const y = x.join("");
      pmap.push(y);
    }
  }
  return pmap;
}
