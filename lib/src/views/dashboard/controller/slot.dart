import 'package:bugbusters/application.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void navigateBookSlot(BuildContext context, String tid, String pid,
    List<int> slot, bool viewOnly) async {
  try {
    var doc = await FirebaseFirestore.instance
        .collection(Collections.managers)
        .doc(pid)
        .get();
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return BookSlot(
        map: doc.data()!['map'],
        viewOnly: viewOnly,
        initialSlot: slot,
        onSubmit: (context, progressDialog, slot) {
          showConfirmDialog(
            context: context,
            title: 'Book Slot',
            content: 'Selected Slot is ${alphabets[slot[1]]}${slot[0]}',
            onAccept: () async {
              Navigator.of(context).pop();
              await progressDialog.show();
              await FirebaseFunctionService()
                  .bookSlot(tid: tid, parkId: pid, slot: slot);
              await progressDialog.hide();
              Navigator.of(context).pop();
            },
          );
        },
      );
    }));
  } catch (e) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$e')));
  }
}
