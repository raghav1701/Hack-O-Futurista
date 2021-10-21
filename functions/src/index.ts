import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

/*
  Constants
*/
const storeCollections = {
  users: 'users',
  transactions: 'transactions',
  vehicles: 'vehicles',
  parking: 'parkings',
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
    await admin.firestore().collection(storeCollections.users).doc(user.uid).set({
      balance: 0,
    });
  } else {
    await admin.firestore().collection(storeCollections.parking).doc(user.uid).set({
      balance: 0,
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

// export const enterParking = functions.https.onCall(async (data, context) => {
//   if (!context.auth) {
//     throw new functions.https.HttpsError(
//       'unauthenticated',
//       'only authenticated can proceed ahead',
//     );
//   }

//   const userId = data.uid as string;
//   const parkingId = context.auth.uid as string;
//   const slot = data.slot;
//   const

//   const tid = await admin.firestore().collection(storeCollections.parking).add({
//     uid: userId,
//     timeEntry: admin.firestore.Timestamp.now(),
//     timeExit: admin.firestore.Timestamp.now(),
//     slot:
//   });
// });

// export const exitParking = functions.https.onCall(async (data, context) => {
//   if (!context.auth) {
//     throw new functions.https.HttpsError(
//       'unauthenticated',
//       'only authenticated can proceed ahead',
//     );
//   }

//   const tid = data.tid;

//   await admin.firestore().collection(storeCollections.parking).add({
//     uid: context.auth.uid,
//     date: admin.firestore.Timestamp.now(),
//     amount:
//   });

//   return
// });
