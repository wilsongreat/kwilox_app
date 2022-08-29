import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  validatePassword(value) {
    if (value.isEmpty || value.length < 7) {
      return 'Please enter a valid email address';
    }
    return null;
  }
}
