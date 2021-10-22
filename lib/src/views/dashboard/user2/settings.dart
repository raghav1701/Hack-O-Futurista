import 'package:bugbusters/application.dart';
import 'package:bugbusters/src/services/firebase/auth.dart';
import 'package:bugbusters/src/views/dashboard/components/divider.dart';
import 'package:bugbusters/src/views/dashboard/components/load.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MSetting extends StatelessWidget {
  const MSetting({Key? key}) : super(key: key);

  Future<DocumentSnapshot<Map<String, dynamic>>?> getData() async {
    try {
      return await FirebaseFirestore.instance
          .collection(Collections.managers)
          .doc(FirebaseAuthService.user!.uid)
          .get();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
          future: getData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const ParkLoading();
            }
            if (snapshot.data == null || snapshot.data!.data()!.isEmpty) {
              return const Text('Failed to load data.');
            }
            var data = snapshot.data!.data()!;
            return Column(
              children: [
                ListTile(
                  title: const Text('Auto Slot Booking'),
                  trailing: Text('${data['autoSlotBooking']}'),
                ),
                const Separator(),
                ListTile(
                  title: const Text('Initial Hour Charges'),
                  trailing: Text('${data['initialHourCharges']} INR'),
                ),
                const Separator(),
                ListTile(
                  title: const Text('Per Hour Charges'),
                  trailing: Text('${data['perHourCharges']} INR'),
                ),
                const Separator(),
                ListTile(
                  title: const Text('Last Transaction'),
                  trailing:
                      Text(convertTimestampToReadable(data['lastTransaction'])),
                ),
                const Separator(),
                ListTile(
                  title: const Text('View Parking Map'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return const BookSlot(
                        tid: '',
                        pid: '',
                        slot: [-1, -1],
                        viewOnly: true,
                      );
                    }));
                  },
                ),
                const Separator(),
              ],
            );
          }),
    );
  }
}
