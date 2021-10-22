import 'package:bugbusters/application.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'history.dart';
import 'parking.dart';
import 'vehicles.dart';
import 'wallet.dart';

import 'models/bottom_bar_item.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentPage = 0;

  final _fragments = [
    BottomBarItem(
      label: 'Vehicles',
      icon: FontAwesomeIcons.car,
      color: Colors.pink,
      widget: const MyVehicles(),
    ),
    BottomBarItem(
      label: 'History',
      icon: FontAwesomeIcons.history,
      color: Colors.orange,
      widget: const ParkingHistory(),
    ),
    BottomBarItem(
      label: 'Wallet',
      icon: FontAwesomeIcons.wallet,
      color: Colors.teal,
      widget: const PersonalWallet(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fragments.insert(
        0,
        BottomBarItem(
          label: 'Parking',
          icon: FontAwesomeIcons.parking,
          color: Colors.purple,
          widget: MyParkings(
            trigger: parkCarTrigger,
          ),
        ));
  }

  void parkCarTrigger() {
    setState(() {
      currentPage = 1;
    });
    showDialog(
        context: context,
        barrierDismissible: false,
        useSafeArea: true,
        builder: (context) {
          return AlertDialog(
            title: const Text('Select Vehicle'),
            content: const Text('Select a vehicle from the list of vehicles you\'ve added, if not then add a vehicle first then scan the bar code at some parking.'),
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
      floatingActionButton: Visibility(
        visible: currentPage < 2,
        child: FloatingActionButton(
          onPressed: () {
            if (currentPage == 0) {
              parkCarTrigger();
            }
            if (currentPage == 1) {
              Navigator.of(context).pushNamed(Routes.vehicleRegister);
            }
          },
          backgroundColor: _fragments[currentPage].color.withAlpha(132),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
