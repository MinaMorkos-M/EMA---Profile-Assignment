import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm(
    this.emailTextController,
    this.passwordTextController,
    this.confirmPasswordTextController,
    this.nameTextController,
    this.parentAction,
  );

  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;
  final TextEditingController confirmPasswordTextController;
  final TextEditingController nameTextController;

  final ValueChanged<List<dynamic>> parentAction;

  @override
  State<StatefulWidget> createState() => _SignUpForm();
}

enum GenderEnum { man, woman }
enum levelEnum { one, two, three, four }

class _SignUpForm extends State<SignUpForm>
    with AutomaticKeepAliveClientMixin<SignUpForm> {
  GenderEnum _userGender = GenderEnum.man;
  levelEnum? _userLevel;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(13.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400]!),
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 360,
              child: TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.mail),
                    labelText: 'Email',
                    hintText: 'Type your email'),
                validator: (String? value) {
                  if (value!.trim().isEmpty) {
                    return 'Nickname is required';
                  } else {
                    return null;
                  }
                },
                controller: widget.emailTextController,
              ),
            ),
            Divider(),
            SizedBox(
              width: 360,
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.lock),
                    labelText: 'Password',
                    hintText: 'Type password'),
                validator: (String? value) {
                  if (value!.trim().isEmpty) {
                    return 'Password is required';
                  } else {
                    return null;
                  }
                },
                controller: widget.passwordTextController,
              ),
            ),
            Divider(),
            SizedBox(
              width: 360,
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.lock),
                    labelText: 'Confirm Password',
                    hintText: 'Type password'),
                validator: (String? value) {
                  if (value!.trim().isEmpty) {
                    return 'Password is required';
                  } else {
                    return null;
                  }
                },
                controller: widget.confirmPasswordTextController,
              ),
            ),
            Divider(),
            SizedBox(
              width: 360,
              child: TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.account_circle),
                    labelText: 'Name',
                    hintText: 'Type Name'),
                validator: (String? value) {
                  if (value!.trim().isEmpty) {
                    return 'Nickname is required';
                  } else {
                    return null;
                  }
                },
                controller: widget.nameTextController,
              ),
            ),
            Divider(),
            Row(
              children: [
                Icon(
                  Icons.wc,
                  color: Colors.grey,
                ),
                Radio(
                  value: GenderEnum.man,
                  groupValue: _userGender,
                  onChanged: (GenderEnum? value) {
                    setState(() {
                      _passDataToParent('gender', 'Man');
                      _userGender = value!;
                    });
                  },
                ),
                new GestureDetector(
                  onTap: () {
                    setState(() {
                      _passDataToParent('gender', 'Man');
                      _userGender = GenderEnum.man;
                    });
                  },
                  child: Text('Man'),
                ),
                SizedBox(
                  width: 20,
                ),
                Radio(
                  value: GenderEnum.woman,
                  groupValue: _userGender,
                  onChanged: (GenderEnum? value) {
                    setState(() {
                      _passDataToParent('gender', 'Woman');
                      _userGender = value!;
                    });
                  },
                ),
                new GestureDetector(
                  onTap: () {
                    setState(() {
                      _passDataToParent('gender', 'Woman');
                      _userGender = GenderEnum.woman;
                    });
                  },
                  child: Text('Woman'),
                ),
              ],
            ),
            Divider(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Level",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                Radio(
                  value: GenderEnum.man,
                  groupValue: _userGender,
                  onChanged: null,
                ),
                new GestureDetector(
                  onTap: () {
                    setState(() {
                      _passDataToParent('level', 'one');
                      _userLevel = levelEnum.one;
                    });
                  },
                  child: Text('1'),
                ),
                
                Radio(
                  value: levelEnum.two,
                  groupValue: _userLevel,
                  onChanged: null,
                ),
                new GestureDetector(
                  onTap: () {
                    setState(() {
                      _passDataToParent('level', 'two');
                      _userLevel = levelEnum.two;
                    });
                  },
                  child: Text('2'),
                ),
                //&&&&&&&&&&&&&&&&&&&
                Radio(
                  value: levelEnum.three,
                  groupValue: _userLevel,
                  onChanged: null,
                ),
                new GestureDetector(
                  onTap: () {
                    setState(() {
                      _passDataToParent('level', 'three');
                      _userLevel = levelEnum.three;
                    });
                  },
                  child: Text('3'),
                ),

                Radio(
                  value: levelEnum.four,
                  groupValue: _userLevel,
                  onChanged: null,
                ),
                new GestureDetector(
                  onTap: () {
                    setState(() {
                      _passDataToParent('level', 'four');
                      _userLevel = levelEnum.four;
                    });
                  },
                  child: Text('4'),
                ),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  void _passDataToParent(String key, dynamic value) {
    List<dynamic> addData = <dynamic>[];
    addData.add(key);
    addData.add(value);
    widget.parentAction(addData);
  }

  @override
  bool get wantKeepAlive => true;
}
