import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

import "./const.ts";

admin.initializeApp();

/*
    Auth Trigger (new user signup)

    for background triggers we must return a value/promise
*/
export const userSignup = functions.auth.user().onCreate(async (user) => {
    return await admin.auth().setCustomUserClaims(user.uid, {
        accessLevel: tempManagers.includes(user.email!) ? userRoles.manager : userRoles.driver,
    });
});
