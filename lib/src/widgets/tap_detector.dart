import 'package:flutter/material.dart';

class TapDetector extends InkWell {
  TapDetector({
    Key? key,
    required Widget? child,
    GestureTapCallback? onTap,
    GestureTapCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onHighlightChanged,
    Color textColor = const Color(0xFF10B73F),
    FontWeight fontWeight = FontWeight.bold,
  }) : super(
          key: key,
          splashColor: Colors.transparent,
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          child: child,
          onTap: onTap,
          onLongPress: onLongPress,
          onHover: onHover,
          onHighlightChanged: onHighlightChanged,
        );
}
