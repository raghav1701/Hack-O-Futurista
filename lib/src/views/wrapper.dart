import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/application.dart';

// ignore: use_key_in_widget_constructors
class Wrapper extends StatefulWidget {
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
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.dashboard);
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
