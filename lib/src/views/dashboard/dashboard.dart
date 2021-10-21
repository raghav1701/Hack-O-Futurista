import 'package:bugbusters/src/views/dashboard/history.dart';
import 'package:bugbusters/src/views/dashboard/myvehicle.dart';
import 'package:bugbusters/src/views/dashboard/parking.dart';
import 'package:flutter/material.dart';
import 'parking.dart';
import 'myvehicle.dart';
import 'history.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedpage = 0;
  PageController pageController = PageController();

  void onTapped(int index) {
    setState(() {
      selectedpage = index;
    });
    pageController.animateToPage(index,
        duration: Duration(
          milliseconds: 100,
        ),
        curve: Curves.bounceIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Vehicle Parking"),
      ),
      body: PageView(
        controller: pageController,
        children: [
          Myvehicle(),
          Parking(),
          History(),
          Container(
            color: Colors.white,
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.time_to_leave),
            label: 'My Vehicle',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.map_rounded), label: 'Parking'),
          BottomNavigationBarItem(
              icon: Icon(Icons.lock_clock), label: 'History'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_rounded),
              label: 'Wallet'),
        ],
        currentIndex: selectedpage,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: onTapped,
      ),
    );
  }
}
