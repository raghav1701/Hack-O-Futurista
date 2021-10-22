import 'package:flutter/material.dart';

void showConfirmDialog({
  required BuildContext context,
  String? content,
  String? title,
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
    barrierDismissible: false,
    useSafeArea: true,
    builder: (context) {
      return AlertDialog(
        title: title != null ? Text(title, style: titleTextStyle) : null,
        content: child ?? (content != null ? Text(content, style: contentTextStyle) : null),
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
