import 'package:bugbusters/application.dart';
import 'package:bugbusters/src/services/firebase/auth.dart';
import 'package:bugbusters/src/views/dashboard/fragments/wallet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'parking.dart';
import 'settings.dart';

import '../models/bottom_bar_item.dart';

class MDashboardScreen extends StatefulWidget {
  const MDashboardScreen({Key? key}) : super(key: key);

  @override
  _MDashboardScreenState createState() => _MDashboardScreenState();
}

class _MDashboardScreenState extends State<MDashboardScreen> {
  int currentPage = 0;

  final _fragments = [
    BottomBarItem(
      label: 'Parking',
      icon: FontAwesomeIcons.parking,
      color: Colors.purple,
      widget: const MParking(),
    ),
    BottomBarItem(
      label: 'Settings',
      icon: FontAwesomeIcons.cog,
      color: Colors.teal,
      widget: const MSetting(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fragments.insert(
        1,
        BottomBarItem(
          label: 'History',
          icon: FontAwesomeIcons.history,
          color: Colors.pink,
          widget: MyParkings(
              btnText: 'Park Vehicle',
              trigger: () {
                setState(() {
                  currentPage = 0;
                });
              },
              stream: FirebaseFirestore.instance
                  .collection(Collections.transactions)
                  .where('parking', isEqualTo: FirebaseAuthService.user!.uid)
                  .where('status', isNotEqualTo: 0))
        ));

    _fragments.insert(
        2,
        BottomBarItem(
          label: 'Wallet',
          icon: FontAwesomeIcons.wallet,
          color: Colors.orange,
          widget: Wallet(
            balanceStream: FirebaseFirestore.instance
                .collection(Collections.managers)
                .doc(FirebaseAuthService.user!.uid),
            transactionStream: FirebaseFirestore.instance
                .collection(Collections.transactions)
                .where('parking', isEqualTo: FirebaseAuthService.user!.uid)
                .where('status', isEqualTo: 2)
                .orderBy('timeExit', descending: true),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppDetails.name),
        actions: [
          PopupMenuButton<String>(onSelected: (value) async {
            await FirebaseAuth.instance.signOut();
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Routes.welcome, (route) => false);
          }, itemBuilder: (context) {
            return [
              const PopupMenuItem(child: Text('Log Out'), value: 'logout'),
            ];
          })
        ],
      ),
      body: _fragments[currentPage].widget,
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentPage,
        items: _fragments.map((v) {
          return SalomonBottomBarItem(
            icon: Icon(v.icon),
            title: Text(v.label),
            selectedColor: v.color,
            unselectedColor: v.color,
          );
        }).toList(),
        onTap: (index) => setState(() => currentPage = index),
      ),
    );
  }
}
