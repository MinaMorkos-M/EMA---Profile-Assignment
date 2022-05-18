import 'package:ema_ass_1/screens/Database/database_helper.dart';
import 'package:ema_ass_1/screens/SignUp/signupform.dart';
import 'package:ema_ass_1/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpWithMail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpWithMail();
}

class _SignUpWithMail extends State<SignUpWithMail> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();
  final _nameTextController = TextEditingController();

  Map<String, dynamic> _userDataMap = Map<String, dynamic>();

  PageController _pageController = PageController();

  String _nextText = 'Submit';
  Color _nextColor = Colors.green[800]!;

  _updateMyTitle(List<dynamic> data) {
    setState(() {
      _userDataMap[data[0]] = data[1];
    });
  }

  _setIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', true);
  }

  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    _userDataMap['gender'] = 'Man';
    _userDataMap['term'] = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.only(top: 10, bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[400]!),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                              fontSize: 34, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      width: 400,
                      height: 550,
                      child: PageView(
                        controller: _pageController,
                        children: [
                          SignUpForm(
                            _emailTextController,
                            _passwordTextController,
                            _confirmPasswordTextController,
                            _nameTextController,
                            _updateMyTitle,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(12.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Cancel',
                                    style: TextStyle(fontSize: 28),
                                  ),
                                ],
                              ),
                              textColor: Colors.black,
                              color: Colors.white,
                              padding: EdgeInsets.all(10),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(12.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _nextText,
                                    style: TextStyle(fontSize: 28),
                                  ),
                                ],
                              ),
                              textColor: Colors.white,
                              color: _nextColor,
                              padding: EdgeInsets.all(10),
                              onPressed: () {
                                _insert();
                                _setIsLogin();

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfilePage(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Button onPressed methods

  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: _nameTextController.text,
      DatabaseHelper.columnGender: _userDataMap['gender'],
      DatabaseHelper.columnEmail: _emailTextController.text,
      DatabaseHelper.columnPassword: _passwordTextController.text,
      //DatabaseHelper.columnLevel:
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }
}
