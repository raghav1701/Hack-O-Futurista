import 'package:flutter/material.dart';

class ParkVehicleButton extends StatelessWidget {
  const ParkVehicleButton({
    Key? key,
    required this.trigger,
    this.text,
  }) : super(key: key);

  final void Function() trigger;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton.icon(
            onPressed: trigger,
            icon: const Icon(Icons.add),
            label: Text(text ?? 'Park Vehicle'),
          ),
        ],
      ),
    );
  }
}
