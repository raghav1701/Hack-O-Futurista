import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/load.dart';
import '../components/park_btn.dart';
import '../components/park_item.dart';

class MyParkings extends StatelessWidget {
  const MyParkings({
    Key? key,
    required this.trigger,
    required this.stream,
    this.btnText,
  }) : super(key: key);

  final void Function() trigger;
  final Query<Map<String, dynamic>> stream;
  final String? btnText;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: stream.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const ParkLoading();
        }

        if (snapshot.data!.docs.isEmpty) {
          return ParkVehicleButton(trigger: trigger, text: btnText);
        }
        var data = snapshot.data!.docs;
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ParkItemCard(
              tid: data[index].id,
              pName: data[index]['parkName'],
              pid: data[index]['parking'],
              uid: data[index]['uid'],
              slot: data[index]['slot'],
              amount: data[index]['amount'],
              perHourCharges: data[index]['perHourCharge'],
              status: data[index]['status'],
              timeEntry: data[index]['timeEntry'],
              timeExit: data[index]['timeExit'],
              vid: data[index]['vehicle'],
            );
          },
        );
      },
    );
  }
}
