import 'package:bugbusters/application.dart';
import 'package:flutter/material.dart';

import 'oauth.dart';

enum ButtonType {
  signup,
  login,
  google,
  tnc,
}

void handleButtons(BuildContext context, ButtonType btn, ProgressDialog progressDialog) {
    if (btn == ButtonType.signup) {
      Navigator.of(context).pushNamed(Routes.signup);
    } else if (btn == ButtonType.login) {
      Navigator.of(context).pushNamed(Routes.signin);
    } else if (btn == ButtonType.google) {
      handleGoogleLogin(context, progressDialog);
    } else if (btn == ButtonType.tnc) {
      Navigator.of(context).pushNamed(Routes.tnc);
    }
  }
