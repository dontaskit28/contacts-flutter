import 'package:contacts/my_auth_service.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

final auth = MyAuthService();

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(
        onPressed: () async {
          if (!mounted) return;
          await auth.logout(context);
        },
        child: const Text("Sign Out"),
      ),
    );
  }
}
