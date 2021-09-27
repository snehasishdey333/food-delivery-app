import 'package:flutter/material.dart';
import 'package:foody/screen/login_page.dart';
import 'package:foody/screen/signup_page.dart';

class WelcomePage extends StatelessWidget {
  Widget button(
      {@required String? name,
      Color? color,
      Color? textColor,
      Null Function()? ontap}) {
    return Container(
      width: 300,
      height: 45,
      child: RaisedButton(
        color: color,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.red,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: ontap,
        child: Text(
          name!,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: Container(
              child: Center(
                child: Image.asset(
                  'images/x.png',
                  height: 200,
                  width: 200,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Text(
                    'Welcome To FOODY',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'Order food from our restaurant and',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'make reservation in real time',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                  button(
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    name: 'Log In',
                    color: Colors.red,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  button(
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUp(),
                        ),
                      );
                    },
                    name: 'Sign Up',
                    color: Colors.white,
                    textColor: Colors.red,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
