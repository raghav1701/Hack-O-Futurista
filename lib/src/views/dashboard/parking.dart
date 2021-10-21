import 'package:flutter/material.dart';

class MyParkings extends StatelessWidget {
  const MyParkings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Park Vehicle'),
          )
        ],
      ),
    );
  }
}
