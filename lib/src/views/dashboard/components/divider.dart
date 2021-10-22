import 'package:flutter/material.dart';

class Separator extends Divider {
  const Separator({
    Key? key,
    double? indent,
    double? thickness,
    Color? color,
    double? height,
  }) : super(
          key: key,
          indent: indent ?? 16.0,
          endIndent: indent ?? 16.0,
          thickness: thickness,
          color: color,
          height: height,
        );
}
