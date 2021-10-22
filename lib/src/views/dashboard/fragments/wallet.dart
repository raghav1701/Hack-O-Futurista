import 'package:bugbusters/application.dart';
import 'package:bugbusters/src/views/dashboard/components/divider.dart';
import 'package:bugbusters/src/views/dashboard/components/load.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Wallet extends StatelessWidget {
  const Wallet({
    Key? key,
    required this.balanceStream,
    required this.transactionStream,
    this.isParkingStaff = false,
  }) : super(key: key);

  final DocumentReference<Map<String, dynamic>> balanceStream;
  final Query<Map<String, dynamic>> transactionStream;
  final bool isParkingStaff;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                          stream: balanceStream.snapshots(),
                          builder: (context, snapshot) {
                            dynamic balance = 0.0;
                            if (snapshot.hasData) {
                              balance = snapshot.data!.data()?['balance'];
                            }
                            return Text(
                              'Wallet Balance: $balance',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 24.0,
                              ),
                            );
                          }),
                      const SizedBox(height: 8.0),
                      Text(
                        '${FirebaseAuthService.user?.displayName}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Card(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const ListTile(
                  title: Text('Transactions'),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: transactionStream.snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const ParkLoading();
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text('No Transactions'));
                        }
                        var data = snapshot.data!.docs;
                        return ListView.separated(
                          itemCount: data.length,
                          separatorBuilder: (_, __) => const Separator(),
                          itemBuilder: (_, index) {
                            return ListTile(
                              title: isParkingStaff
                                  ? Text('${data[index]['parkName']}')
                                  : Text('${data[index]['vehicle']}'),
                              trailing: Text(
                                (isParkingStaff ? '+' : '-') +
                                    '${data[index]['amount']}',
                                style: TextStyle(
                                  color: isParkingStaff
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            );
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
