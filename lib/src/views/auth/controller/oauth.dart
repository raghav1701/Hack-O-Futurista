import 'package:bugbusters/application.dart';
import 'package:flutter/material.dart';

Future<void> handleGoogleLogin(BuildContext context, ProgressDialog progressDialog) async {
  await FirebaseAuthService(
    onStart: () async {
      await progressDialog.show();
    },
    onFinish: (user, claims) async {
      await progressDialog.hide();
      if (user != null) {
        await sharedPreferences.saveAccessLevel(claims?['accessLevel'] as int);
        Navigator.of(context).pushReplacementNamed(Routes.dashboard);
      }
    },
    onError: (code, message) async {
      await progressDialog.hide();
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('$message')));
    },
  ).googleOAuth();
}
