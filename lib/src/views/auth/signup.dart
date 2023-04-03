import 'package:bugbusters/application.dart';
import 'package:flutter/material.dart';

import 'components/btn.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  late ProgressDialog progressDialog;
  String? name, email, password, error;

  void saveForm() {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    FocusScope.of(context).unfocus();
    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (_) => TnCDialog(
        onDecline: () => Navigator.of(context).pop(),
        onAccept: () {
          Navigator.of(context).pop();
          handleEmailPasswordAuth();
        },
      ),
    );
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
    await service.createUser(email: email!, password: password!, additional: {'name': name!});
  }

  void handleButton() {
    Navigator.of(context).pushReplacementNamed(Routes.signin);
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
            Text('Signing up new user...'),
          ],
        ),
      ),
    );
  }

  final image = Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 44.0,
      vertical: 44.0,
    ),
    child: Image.asset(
      Assets.signupPageImage,
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
                  hintText: 'Name',
                  onSaved: (val) => name = val,
                  validator: validateName,
                ),
                AuthTextFormField(
                  hintText: 'Email',
                  onSaved: (val) => email = val,
                  textInputType: TextInputType.emailAddress,
                  validator: validateEmail,
                ),
                AuthTextFormField(
                  hintText: 'Password',
                  onSaved: (val) => password = val,
                  validator: validatePassword,
                  textInputType: TextInputType.visiblePassword,
                  showText: false,
                ),
                Visibility(
                  visible: error != null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: authBtnPadding,
                      vertical: 8.0
                    ),
                    child: Text('$error', style: ThemeConstants.kErrorMessageTextStyle),
                  ),
                  replacement: const SizedBox(
                    height: 16.0,
                  ),
                ),
                AuthButton(
                  buttonText: 'Sign Up',
                  onPressed: saveForm,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? '),
                    InteractiveText(
                      'Login',
                      onTap: handleButton,
                    ),
                  ],
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
