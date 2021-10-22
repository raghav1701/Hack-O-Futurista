import 'package:flutter/material.dart';

class MSetting extends StatelessWidget {
  const MSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueAccent[100],
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Icon(Icons.settings),
                  radius: 70.0,
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: "Charge rates",
                      labelText: "Default Payment",
                      labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                      hintStyle: TextStyle(color: Colors.blue)),
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: "Charge rates per hour",
                      labelText: "Extra Payment per hour ",
                      labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                      hintStyle: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
