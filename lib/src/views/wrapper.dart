import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bugbusters/application.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  void initTools() async {
    sharedPreferences = await SharedPreferencesProvider.getInstance();
    sqlDatabase = await SQLDatabase.getInstance();
    Firebase.initializeApp().then((value) {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.of(context).pushReplacementNamed(Routes.welcome);
      } else if (sharedPreferences.accessLevel == 1) {
        Navigator.of(context).pushReplacementNamed(Routes.dashboard);
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.mdashboard);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initTools();
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
