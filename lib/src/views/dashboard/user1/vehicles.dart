import 'package:bugbusters/application.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class MyVehicles extends StatelessWidget {
  const MyVehicles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var uid = FirebaseAuthService.user?.uid;
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection(Collections.vehicles)
          .where('uid', isEqualTo: uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.vehicleRegister);
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Vehicle'),
            ),
          );
        }
        var data = snapshot.data!.docs;
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: ExpansionTile(
                title: Text(data[index]['vid']),
                subtitle: Text(
                    'Date Added: ${convertTimestampToReadable(data[index]['dateAdded'])}'),
                children: [
                  Container(
                    height: 200,
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                    child: SfBarcodeGenerator(value: data[index]['vid']),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                    child: Text('Scan above code at some parking.'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
