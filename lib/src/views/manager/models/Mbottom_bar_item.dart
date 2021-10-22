import 'package:flutter/material.dart';

class BottomBarItem {
  final String label;
  final IconData icon;
  final Color color;
  final Widget widget;

  BottomBarItem({
    required this.label,
    required this.icon,
    required this.color,
    required this.widget,
  });
}
