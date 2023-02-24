import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CurrentUser extends ChangeNotifier {
  String? _email;
  String? _phone;
  String? _name;
  User? _user = FirebaseAuth.instance.currentUser!;

  String get email => _email!;
  String get phone => _phone!;
  String get name => _name!;
  User get user => _user!;

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

  set user(User value) {
    _user = value;
    notifyListeners();
  }

  set reset(String value) {
    _email = null;
    _phone = null;
    _name = null;
    notifyListeners();
  }
}
