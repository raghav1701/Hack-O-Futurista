import 'package:bugbusters/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../controller/parking.dart';

class MParking extends StatefulWidget {
  const MParking({Key? key}) : super(key: key);

  @override
  State<MParking> createState() => _MParkingState();
}

class _MParkingState extends State<MParking> {
  late final ProgressDialog progressDialog;

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
            Text('Submitting Request...'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton.icon(
            onPressed: () async {
              String code = await FlutterBarcodeScanner.scanBarcode(
                  'red', 'Cancel', true, ScanMode.BARCODE);

              if (code != '-1') {
                parkVehicle(code, progressDialog);
              }
            },
            icon: const Icon(FontAwesomeIcons.plus),
            label: const Text('Park Vehicle'),
          ),
          OutlinedButton.icon(
            onPressed: () async {
              String code = await FlutterBarcodeScanner.scanBarcode(
                  'red', 'Cancel', true, ScanMode.BARCODE);

              if (code != '-1') {
                exitParking(code, progressDialog);
              }
            },
            icon: const Icon(FontAwesomeIcons.minus),
            label: const Text('Exit Vehicle  '),
          ),
        ],
      ),
    );
  }
}
