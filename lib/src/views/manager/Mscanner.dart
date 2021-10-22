import 'package:flutter/material.dart';

class Mscanner extends StatefulWidget {
  const Mscanner({Key? key}) : super(key: key);

  @override
  State<Mscanner> createState() => _MscannerState();
}

class _MscannerState extends State<Mscanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Scanner'),
      ),
      body: Center(
        child: RaisedButton(onPressed: () {}, color: Colors.blue),
      ),
    );
  }
}
