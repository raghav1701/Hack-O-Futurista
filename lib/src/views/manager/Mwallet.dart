import 'package:bugbusters/application.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManagerWallet extends StatelessWidget {
  const ManagerWallet({Key? key}) : super(key: key);

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
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuthService.user?.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            dynamic balance = 0.0;
                            if (snapshot.hasData) {
                              balance = snapshot.data!.data()?['balance'];
                            }
                            return Text(
                              'Total Money Collected: $balance',
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
            child: SingleChildScrollView(
              child: ExpansionTile(
                title: const Text('Car details and Payment'),
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (_, index) {
                      return const ListTile(
                        title: Text('sd'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
