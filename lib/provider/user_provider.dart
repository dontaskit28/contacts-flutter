import 'package:flutter/material.dart';

class CurrentUser extends ChangeNotifier {
  String? _email;
  String? _phone;
  String? _name;

  String get email => _email!;
  String get phone => _phone!;
  String get name => _name!;

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set phone(String value) {
    _phone = value;
    notifyListeners();
  }

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  set reset(String value) {
    _email = null;
    _phone = null;
    _name = null;
    notifyListeners();
  }
}
