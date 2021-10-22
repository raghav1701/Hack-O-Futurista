import 'package:bugbusters/application.dart';
import 'package:bugbusters/src/views/dashboard/controller/slot.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class ParkItemCard extends StatelessWidget {
  const ParkItemCard({
    Key? key,
    required this.uid,
    required this.pid,
    required this.tid,
    required this.vid,
    required this.pName,
    required this.timeEntry,
    required this.timeExit,
    required this.status,
    required this.perHourCharges,
    required this.amount,
    required this.slot,
  }) : super(key: key);

  final String pName;
  final String uid;
  final String tid;
  final List slot;
  final String pid;
  final String vid;
  final Timestamp timeEntry;
  final Timestamp timeExit;
  final int status;
  final dynamic perHourCharges;
  final dynamic amount;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    pName,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(vid),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    'Parked At ${convertTimestampToReadable(timeEntry)}',
                  ),
                ),
                Visibility(
                  visible: status < 2,
                  child: ElevatedButton(
                    onPressed: () async {
                      navigateBookSlot(
                          context, tid, pid, slot.cast<int>(), status == 1);
                    },
                    child: Text(status == 0 ? 'Book Slot' : 'View Map'),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: status == 2,
              child: Text(
                'Parked At ${convertTimestampToReadable(timeExit)}',
              ),
            ),
            Visibility(
              visible: status == 1,
              child: Text(
                'Slot ' +
                    (slot[1] != -1 ? '${alphabets[slot[1]]}${slot[0]}' : ''),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '1 Hour Charges: $perHourCharges INR',
                  ),
                ),
                Visibility(
                  visible: status < 2,
                  child: OutlinedButton(
                    child: const Text('Get Code'),
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          useSafeArea: true,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Vehicle Code'),
                              content: SizedBox(
                                height: 100,
                                child: SfBarcodeGenerator(
                                    value: vid, showValue: true),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Dismiss'),
                                ),
                              ],
                            );
                          });
                    },
                  ),
                ),
              ],
            ),
            Visibility(
              visible: status == 2,
              child: Text(
                'Amount Paid: $amount INR',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
