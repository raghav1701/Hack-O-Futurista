import 'package:bugbusters/application.dart';
import 'package:flutter/material.dart';

class AuthTextFormField extends Padding {
  AuthTextFormField({
    Key? key,
    required String hintText,
    required FormFieldSetter<String>? onSaved,
    required FormFieldValidator<String>? validator,
    TextInputType? textInputType,
    double? horizontalPadding,
    bool showText = true,
  }) : super(
          key: key,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? authBtnPadding,
            vertical: 8.0,
          ),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: hintText,
              errorMaxLines: 3,
            ),
            onSaved: onSaved,
            validator: validator,
            keyboardType: textInputType,
            obscureText: !showText,
          ),
        );
}
