import 'package:bugbusters/application.dart';
import 'package:flutter/material.dart';

import 'components/btn.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  late ProgressDialog progressDialog;
  String? email, password, error;

  void saveForm() {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    FocusScope.of(context).unfocus();
    handleEmailPasswordAuth();
  }

  void handleEmailPasswordAuth() async {
    var service = FirebaseAuthService(
      onStart: () async {
        if (mounted) {
          setState(() => error = null);
          await progressDialog.show();
        }
      },
      onFinish: (user, claims) async {
        await progressDialog.hide();
        int level = claims?['accessLevel'] as int;
        await sharedPreferences.saveAccessLevel(level);
        if (level == 1) {
          Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.dashboard, (route) => false);
        } else {
          Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.mdashboard, (route) => false);
        }
      },
      onError: (code, message) async {
        if (mounted) {
          await progressDialog.hide();
          setState(() => error = message);
        }
      },
    );
    await service.loginUser(email: email!, password: password!);
  }

  void handleForgotPassword() {
    //TODO: Forgot Password
  }

  void handleButton() {
    Navigator.of(context).pushReplacementNamed(Routes.signup);
  }

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
            Text('Logging In...'),
          ],
        ),
      ),
    );
  }

  final image = Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 32.0,
      vertical: 64.0,
    ),
    child: Image.asset(
      Assets.loginPageImage,
      fit: BoxFit.fitWidth,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                image,
                AuthTextFormField(
                  hintText: 'Email',
                  onSaved: (val) => email = val,
                  textInputType: TextInputType.emailAddress,
                  validator: validateEmail,
                ),
                AuthTextFormField(
                  hintText: 'Password',
                  onSaved: (val) => password = val,
                  validator: requiredFormField,
                  textInputType: TextInputType.visiblePassword,
                  showText: false,
                ),
                Visibility(
                  visible: error != null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: authBtnPadding,
                      vertical: 8.0,
                    ),
                    child: Text(
                      '$error',
                      style: ThemeConstants.kErrorMessageTextStyle,
                    ),
                  ),
                  replacement: const SizedBox(
                    height: 16.0,
                  ),
                ),
                AuthButton(
                  buttonText: 'Login',
                  onPressed: saveForm,
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account? '),
                    InteractiveText(
                      'Sign Up',
                      onTap: handleButton,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                InteractiveText(
                  'Forgot Password?',
                  onTap: handleForgotPassword,
                ),
                const SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
