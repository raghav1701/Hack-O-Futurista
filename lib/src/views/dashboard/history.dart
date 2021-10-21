import 'package:bugbusters/application.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  Future<String> getDat() async {
    return await FirebaseAuthService.getUserAccessLevel().then((value) => value.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getDat(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.toString());
          }
          return ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(Routes.welcome, (route) => false);
            },
            child: const Text('Bye'),
          );
        },
      ),
    );
  }
}
