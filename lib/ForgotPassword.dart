import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'ConfirmEmail.dart';

class ForgotPassword extends StatefulWidget {
  static String id = 'forgot-password';
  final String message =
      "An email has just been sent to you, Click the link provided to complete password reset";

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  late String _email;

  _passwordReset() async {
    try {
      _formKey.currentState?.save();
      final user = await _auth.sendPasswordResetEmail(email: _email);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return ConfirmEmail(
            message: widget.message,
            key: _formKey,
          );
        }),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter Your Email',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              TextFormField(
                onSaved: (newEmail) {
                  _email = newEmail!;
                },
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Email',
                  icon: Icon(
                    Icons.mail,
                    color: Colors.grey,
                  ),
                  errorStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.grey),
                  hintStyle: TextStyle(color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Send Email'),
                onPressed: () {
                  _passwordReset();
                  print(_email);
                },
              ),
              TextButton(
                child: Text('Sign In'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
