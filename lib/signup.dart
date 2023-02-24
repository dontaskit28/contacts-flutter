// ignore_for_file: non_constant_identifier_names
import 'package:contacts/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_auth_service.dart';

final MyAuthService _authService = MyAuthService();

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  void _register(CurrentUser user) async {
    if (_emailController.text == "" ||
        _passwordController.text == "" ||
        _phoneController.text == "") {
      return;
    }
    final credential = await _authService.signUp(
      _emailController.text,
      _passwordController.text,
      _phoneController.text,
      user,
    );

    if (credential != null) {
      Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
    }

    // await FirebaseChatCore.instance.createUserInFirestore(
    //   types.User(
    //     firstName: _emailController.text.split('@')[0],
    //     id: credential!.uid,
    //     imageUrl: 'https://i.pravatar.cc/300?u=${_emailController.text}',
    //   ),
    // );

    // final User? user = (await _auth.createUserWithEmailAndPassword(
    //         email: _emailController.text, password: _passwordController.text))
    //     .user;

    // if (user != null) {
    //   setState(() {
    //     _sucess = true;
    //     _userEmail = user.email!;
    //   });
    // } else {
    //   setState(() {
    //     _sucess = false;
    //   });
    // }
    // email = _emailController.text;
  }

  @override
  Widget build(BuildContext context) {
    CurrentUser user = Provider.of<CurrentUser>(context, listen: true);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(15, 110, 0, 0),
                child: const Text("SignUp",
                    style:
                        TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 35, left: 20, right: 30),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      )),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 40,
                  child: GestureDetector(
                    onTap: () async {
                      _register(user);
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      shadowColor: Colors.greenAccent,
                      color: Colors.black,
                      elevation: 7,
                      child: const Center(
                        child: Text(
                          'SIGNUP',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Go Back',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
