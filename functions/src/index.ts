import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

/*
  Constants
*/
const userRoles = {
  driver: 1,
  manager: 2,
};

const tempManagers: Array<string> = [
  "manager@mail.com",
  "pvr.mbd@mail.com",
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

  return await admin.auth().setCustomUserClaims(user.uid, {
    accessLevel: tempManagers.includes(user.email)
      ? userRoles.manager
      : userRoles.driver,
  });
});
