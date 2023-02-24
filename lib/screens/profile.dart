import 'package:contacts/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    CurrentUser user = Provider.of<CurrentUser>(context, listen: true);
    return Scaffold(
      body: TextButton(
        onPressed: () async {
          if (!mounted) return;
          await _auth.signOut();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()),
              (route) => false);
        },
        child: const Text("Sign Out"),
      ),
    );
  }
}
