import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final void Function() onPressed;
  final bool useThemeColor;
  final bool fillWithDark;
  final Color? fillColor;
  final Color? textColor;
  final double horizontalMargin;
  final double verticalMargin;

  const AuthButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.useThemeColor = true,
    this.fillWithDark = true,
    this.fillColor,
    this.textColor,
    this.horizontalMargin = 42.0,
    this.verticalMargin = 4.0,
  })  : assert(useThemeColor || (fillColor != null && textColor != null)),
        super(key: key);

  @override
  Widget build(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalMargin,
        vertical: verticalMargin,
      ),
      child: Row(
        children: [
          Expanded(
            child: RawMaterialButton(
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 16,
                  color: useThemeColor
                      ? fillWithDark
                          ? Colors.white
                          : Colors.black
                      : textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              fillColor: useThemeColor
                  ? fillWithDark
                      ? const Color(0xFF0B4AAA)
                      : const Color(0xFFF0EFEF)
                  : fillColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))
              ),
              elevation: 1.0,
              hoverElevation: 2.0,
              highlightElevation: 4.0,
            ),
          ),
        ],
      ),
    );
  }
}
