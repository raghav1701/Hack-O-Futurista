import 'package:flutter/material.dart';

class ParkLoading extends StatelessWidget {
  const ParkLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(width: 8.0),
          Text('Fetching...'),
        ],
      ),
    );
  }
}
