import 'package:flutter/material.dart';

class MyParkings extends StatelessWidget {
  const MyParkings({
    Key? key,
    required this.trigger,
  }) : super(key: key);

  final void Function() trigger;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton.icon(
            onPressed: trigger,
            icon: const Icon(Icons.add),
            label: const Text('Park Vehicle'),
          )
        ],
      ),
    );
  }
}
