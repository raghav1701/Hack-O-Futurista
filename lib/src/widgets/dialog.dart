import 'package:flutter/material.dart';

void showConfirmDialog({
  required BuildContext context,
  required String title,
  required String content,
  Widget? child,
  String? declineText,
  String? acceptText,
  required void Function() onAccept,
  void Function()? onDecline,
  TextStyle? titleTextStyle,
  TextStyle? contentTextStyle,
  TextStyle? actionTextStyle,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title, style: titleTextStyle),
        content: child ?? Text(content, style: contentTextStyle),
        actions: [
          TextButton(
            onPressed: onDecline ?? () => Navigator.of(context).pop(),
            child: Text(declineText ?? 'Cancel', style: actionTextStyle),
          ),
          TextButton(
            onPressed: onAccept,
            child: Text(acceptText ?? 'Confirm', style: actionTextStyle),
          ),
        ],
      );
    },
  );
}
