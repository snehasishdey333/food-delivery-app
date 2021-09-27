import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foody/screen/signup_page.dart';
import 'package:foody/screen/welcome_page.dart';
import 'package:foody/screen/widget/my_text_field.dart';

class LoginPage extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//  Widget textField(
  //    {@required String? hintText, IconData? icon, Color? iconColor,}) {
  //  return TextFormField(
  //   decoration: InputDecoration(
  //   prefixIcon: Icon(
  //   icon,
  //  color: iconColor,
  //      ),
  //    hintText: hintText,
  //  hintStyle: TextStyle(
  //  color: Colors.grey[500],
  //      ),
  //    enabledBorder: UnderlineInputBorder(
  //    borderSide: BorderSide(
  //    color: Colors.grey,
  //),
  //      ),
  //  ),
  // );
  //}

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  RegExp regExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  bool loading = false;
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  UserCredential? userCredential;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @required
  Future loginAuth() async {
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        //print('No user found for that email.');
        globalKey.currentState!.showSnackBar(
          SnackBar(
            content: Text('No user found for that email.'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');
        globalKey.currentState!.showSnackBar(
          SnackBar(
            content: Text('Wrong password provided for that user.'),
          ),
        );
        setState(() {
          loading = false;
        });
      }
      setState(() {
        loading = false;
      });
    }
  }

  void validation() {
    if (email.text.trim().isEmpty && password.text.trim().isEmpty) {
      globalKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Please enter your email & password'),
        ),
      );
      return;
    }

    if (email.text.trim().isEmpty) {
      globalKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Email id can not be empty'),
        ),
      );
      return;
    } else if (!regExp.hasMatch(email.text)) {
      globalKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Please enter a valid email id'),
        ),
      );
      return;
    }
    // || password.text.trim() == null
    if (password.text.trim().isEmpty) {
      globalKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Password can not be empty'),
        ),
      );
      return;
    } else {
      setState(() {
        loading = true;
      });
      loginAuth();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WelcomePage()),
              );
            }),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 190.0),
              child: Text(
                'Log In',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
            Column(
              children: [
                MyTextField(
                    controller: email,
                    hintText: 'Email Id',
                    obscureText: false),
                // textField(
                //     hintText: 'Email id / Username',
                //     icon: Icons.person_outline,
                //     iconColor: Colors.lightBlue),
                SizedBox(
                  height: 30,
                ),
                MyTextField(
                    controller: password,
                    hintText: 'Password',
                    obscureText: true),
                // textField(
                //     hintText: 'Password',
                //     icon: Icons.lock_outline,
                //     iconColor: Colors.lightBlue),
              ],
            ),
            loading
                ? CircularProgressIndicator()
                : Container(
                    width: 300,
                    height: 45,
                    child: RaisedButton(
                      onPressed: () {
                        validation();
                      },
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'Log In',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'New user? ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
