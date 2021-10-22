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
        int level = claims?['accessLevel'] as int;
        await sharedPreferences.saveAccessLevel(level);
        if (level == 1) {
          Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.dashboard, (route) => false);
        } else {
          Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.mdashboard, (route) => false);
        }
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
