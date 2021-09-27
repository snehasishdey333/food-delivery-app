import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foody/provider/my_provider.dart';
import 'package:foody/screen/home_page.dart';
import 'package:foody/screen/login_page.dart';
import 'package:foody/screen/signup_page.dart';
import 'package:foody/screen/welcome_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

FirebaseAuth _auth = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.yellow,
          appBarTheme: AppBarTheme(
            color: Colors.yellow,
          ),
        ),
        // home: LoginPage(),
        // home: SignUp(),
        //  home: StreamBuilder(
        //    stream: FirebaseAuth.instance.authStateChanges(),
        //    builder: (index,snapshot),),
        //
        //   home: StreamBuilder(builder: (index,snapshot),),
        home: HomePage(),
      ),
    );
  }
}
