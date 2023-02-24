import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      debugPrintStack(label: e.toString());
      return null;
    }
  }

  found(CollectionReference colRef, String phone) async {
    QuerySnapshot snap = await colRef.where('phone', isEqualTo: phone).get();
    if (snap.docs.isEmpty) {
      return null;
    }
    return snap.docs[0];
  }

  Future<User?> signUp(String email, String password, String phone,
      CurrentUser currentUser) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('allContacts').doc(phone).set(
        {
          'phone': phone,
          'email': email,
          'name': email.split('@')[0],
          'tags': [],
          'contacts': []
        },
        SetOptions(merge: true),
      );

      currentUser.email = email;
      currentUser.phone = phone;
      currentUser.name = email.split('@')[0];

      final User? user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      debugPrintStack(label: e.toString());
      return null;
    }
  }

  User? getCurrentUser() {
    final User? user = _firebaseAuth.currentUser;
    return user;
  }

  void setData(CurrentUser currentUser, BuildContext context) async {
    _firebaseAuth.authStateChanges().listen((User? user) async {
      if (user == null) {
        currentUser.reset = "";
      } else {
        var number = await FirebaseFirestore.instance
            .collection('allContacts')
            .where('email', isEqualTo: user.email)
            .get();
        currentUser.email = user.email!;
        currentUser.phone = number.docs[0].id;
        currentUser.name = user.email!.split('@')[0];
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    });
  }

  logout(BuildContext context) async {
    await _firebaseAuth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
