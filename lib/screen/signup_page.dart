import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:foody/screen/login_page.dart';
import 'package:foody/screen/welcome_page.dart';
import 'package:foody/screen/widget/my_text_field.dart';

class SignUp extends StatefulWidget {
//var email = "tony@starkindustries.com"
//bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  RegExp regExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  bool loading = false;
  UserCredential? userCredential;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  //TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  Future sendData() async {
    // await FirebaseFirestore.instance.collection('userData').doc().set({
    //   'firstName': firstName.text,
    //   'lastName': lastName.text,
    //   'email': email.text,
    //   'password': password.text,
    //   'confirmPassword': confirmPassword.text,
    // });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);

      await FirebaseFirestore.instance
          .collection('userData')
          .doc(userCredential.user!.uid)
          .set({
        'firstName': firstName.text.trim(),
        'lastName': lastName.text.trim(),
        'email': email.text.trim(),
        'userid': userCredential.user!.uid,
        'password': password.text.trim(),
        'confirmPassword': confirmPassword.text.trim(),
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
        globalKey.currentState!.showSnackBar(
          SnackBar(
            content: Text('The password provided is too weak.'),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        globalKey.currentState!.showSnackBar(
          SnackBar(
            content: Text('The account already exists for that email.'),
          ),
        );
      }
    } catch (e) {
      //print(e);
      globalKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('e'),
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

  @override
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  void validation() {
    if (firstName.text.trim().isEmpty || firstName.text.trim() == null) {
      globalKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Please enter your first name'),
        ),
      );
      return;
    }
    if (lastName.text.trim().isEmpty || lastName.text.trim() == null) {
      globalKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Please enter your last name'),
        ),
      );
      return;
    }
    // if (userName.text.trim().isEmpty || userName.text.trim() == null) {
    //   globalKey.currentState!.showSnackBar(
    //     SnackBar(
    //       content: Text('Please enter your username'),
    //     ),
    //   );
    //   return;
    // }
    if (email.text.trim().isEmpty || email.text.trim() == null) {
      globalKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Please enter an email id'),
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
    if (password.text.trim().isEmpty || password.text.trim() == null) {
      globalKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Please enter your password'),
        ),
      );
      return;
    } else {
      setState(() {
        loading = true;
      });
      sendData();
    }
    if (confirmPassword.text.trim().isEmpty ||
        confirmPassword.text.trim() == null ||
        confirmPassword.text.trim() != password.text.trim()) {
      globalKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Please confirm your password'),
        ),
      );
      return;
    }
  }

  Widget button({
    @required String? buttonName,
    Color? buttonColor,
    Color? buttonTextColor,
    required Null Function() ontap,
  }) {
    return Container(
      width: 150,
      height: 45,
      child: RaisedButton(
        color: buttonColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.red,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          buttonName!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: buttonTextColor,
          ),
        ),
        onPressed: ontap,
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.yellow,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.red,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          },
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              Container(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyTextField(
                      hintText: 'First Name',
                      controller: firstName,
                      obscureText: false,
                    ),
                    MyTextField(
                      hintText: 'Last Name',
                      controller: lastName,
                      obscureText: false,
                    ),
                    // MyTextField(
                    //   hintText: 'Username',
                    //   controller: userName,
                    //   obscureText: false,
                    // ),
                    MyTextField(
                      hintText: 'Email',
                      obscureText: false,
                      controller: email,
                    ),
                    MyTextField(
                      hintText: 'Password',
                      controller: password,
                      obscureText: true,
                    ),
                    MyTextField(
                      hintText: 'Confirm Password',
                      controller: confirmPassword,
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              loading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        button(
                          buttonName: 'Cancel',
                          buttonColor: Colors.white,
                          buttonTextColor: Colors.red,
                          ontap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WelcomePage(),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        button(
                          ontap: () {
                            validation();
                          },
                          buttonName: 'Register',
                          buttonColor: Colors.red,
                          buttonTextColor: Colors.white,
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

      
//     );
//   }
// }
//class SignUp extends StatelessWidget {
  // Widget button({
  //   @required String? buttonName,
  //   Color? buttonColor,
  //   Color? buttonTextColor,
  // }) {
  //   return Container(
  //     width: 150,
  //     height: 45,
  //     child: RaisedButton(
  //       color: buttonColor,
  //       shape: RoundedRectangleBorder(
  //         side: BorderSide(
  //           color: Colors.blueAccent,
  //           width: 2,
  //         ),
  //         borderRadius: BorderRadius.circular(30),
  //       ),
  //       child: Text(
  //         buttonName!,
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           fontSize: 20,
  //           color: buttonTextColor,
  //         ),
  //       ),
  //       onPressed: () {},
  //     ),
  //   );
  // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.blueAccent,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => WelcomePage(),
//               ),
//             );
//           },
//         ),
//       ),
//       body: SafeArea(
//         child: Container(
//           margin: EdgeInsets.symmetric(
//             horizontal: 40,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text(
//                 'Sign Up',
//                 style: TextStyle(
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blueAccent,
//                 ),
//               ),
//               Container(
//                 height: 300,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     MyTextField(
//                       hintText: 'First Name',
//                       obscureText: false,
//                     ),
//                     MyTextField(
//                       hintText: 'Last Name',
//                       obscureText: false,
//                     ),
//                     MyTextField(
//                       hintText: 'Username',
//                       obscureText: false,
//                     ),
//                     MyTextField(
//                       hintText: 'Email',
//                       obscureText: false,
//                     ),
//                     MyTextField(
//                       hintText: 'Password',
//                       obscureText: true,
//                     ),
//                     MyTextField(
//                       hintText: 'Confirm Password',
//                       obscureText: true,
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   button(
//                     buttonName: 'Cancel',
//                     buttonColor: Colors.white,
//                     buttonTextColor: Colors.blueAccent,
//                   ),
//                   SizedBox(
//                     width: 30,
//                   ),
//                   button(
//                     buttonName: 'Register',
//                     buttonColor: Colors.blueAccent,
//                     buttonTextColor: Colors.white,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
