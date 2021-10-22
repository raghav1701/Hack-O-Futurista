String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return 'This is a required field';
  }

  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(pattern);

  return regExp.hasMatch(email) ? null : 'Invalid Email';
}

String? validateName(String? name) {
  if (name == null || name.isEmpty) {
    return 'This is a required field';
  }
  if (name.contains(RegExp(r'[0-9]'))) {
    return 'Numbers not allowed';
  }
  return null;
}

String? validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return 'This is a required field';
  }
  if (password.length < 8) {
    return 'Password should be atleast of 8 characters';
  }
  if (!password.contains(RegExp(r'[0-9]'))) {
    return 'Password should contain atleast one number';
  }
  if (!password.contains(RegExp(r'[A-Z]'))) {
    return 'Password should contain atleast one capital letter';
  }
  if (!password.contains(RegExp(r'[a-z]'))) {
    return 'Password should contain atleast one small letter';
  }
  return null;
}

String? validateVehicleID(String? text) {
  if (text == null || text.isEmpty) {
    return 'This is a required field';
  }
  if (text.length < 8 || text.length > 12 || !text[0].contains(RegExp(r'[A-Z]')) || !text[1].contains(RegExp(r'[A-Z]'))) {
    return 'Invalid Number';
  }
  return null;
}

String? requiredFormField(String? text) {
  if (text == null || text.isEmpty) {
    return 'This is a required field';
  }
  return null;
}
