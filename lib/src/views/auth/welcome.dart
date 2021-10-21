import 'package:bugbusters/application.dart';
import 'package:flutter/material.dart';

import 'components/btn.dart';
import 'controller/navigate.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late ProgressDialog progressDialog;

  final image = Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 32.0,
      vertical: authBtnPadding + 24.0,
    ),
    child: Image.asset(
      Assets.welcomePageImage,
      fit: BoxFit.fitWidth,
    ),
  );

  final divider = const Divider(
    indent: authBtnPadding + 32.0,
    endIndent: authBtnPadding + 32.0,
    height: 30.0,
  );

  @override
  void initState() {
    super.initState();
    progressDialog = ProgressDialog(
      context,
      isDismissible: false,
      type: ProgressDialogType.normal,
      customBody: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 24.0,
        ),
        child: Row(
          children: const [
            CircularProgressIndicator(),
            SizedBox(width: 16.0),
            Text('Initialised Signing Process...'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              image,
              const SizedBox(
                height: 8.0,
              ),
              const Text(
                'Smart\nParking',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF0B4AAA),
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              const Text(
                'Join hands to save the\nEnvironment',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16.0,
              ),
              AuthButton(
                buttonText: 'Sign Up',
                onPressed: () {
                  handleButtons(context, ButtonType.signup, progressDialog);
                },
              ),
              AuthButton(
                buttonText: 'Login',
                onPressed: () {
                  handleButtons(context, ButtonType.login, progressDialog);
                },
                fillWithDark: false,
              ),
              divider,
              Builder(
                builder: (context) {
                  return AuthButton(
                    buttonText: 'Continue with Google',
                    onPressed: () {
                      handleButtons(context, ButtonType.google, progressDialog);
                    },
                  );
                }
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Read our '),
                    InteractiveText(
                      'Terms and Conditions',
                      onTap: () {
                        handleButtons(context, ButtonType.tnc, progressDialog);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
