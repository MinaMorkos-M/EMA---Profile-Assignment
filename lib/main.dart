import 'package:ema_ass_1/screens/SignIn/signin.dart';
import 'package:ema_ass_1/screens/SignIn/signup.dart';
import 'package:ema_ass_1/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLogin = false;
  _checkLogin() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    bool isLogin = (prefs.get('isLogin') ?? false) as bool;

    setState(() {
      _isLogin = isLogin;
    });

    print('prefs $isLogin');
  }

  @override
  void initState() {
    _checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            alignment: Alignment.centerLeft,
            primary: Colors.black,
          ),
        ),
      ),
      home: !_isLogin ? _signInWidget() : ProfilePage(),
    );
  }

  Widget _signInWidget() {
    return Scaffold(
      backgroundColor: Colors.blue,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SignIn(),
              SignUp(),
            ],
          ),
        ),
      ),
    );
  }
}
