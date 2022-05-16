import 'dart:async';
import 'dart:io';
import 'package:ema_ass_1/screens/edit_email.dart';
import 'package:ema_ass_1/screens/edit_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../models/user_data.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const genderMenuItems = [
    'Male',
    'Female',
  ];
  static const levelMenuItems = [
    'One',
    'Two',
    'Three',
    'Four',
  ];

  final List<DropdownMenuItem<String>> _genderDropDownMenuItems =
      genderMenuItems
          .map(
            (String value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ),
          )
          .toList();
  final List<DropdownMenuItem<String>> _levelDropDownMenuItems = levelMenuItems
      .map(
        (String value) => DropdownMenuItem(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
  String _botton1SelectedVal = 'One';
  String _botton2SelectedVal = 'Male';

  File? image;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("Failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = UserData.myUser;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 10,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(64, 105, 225, 1),
                ),
              ),
            ),
          ),
          (image != null)
              ? Image.file(
                  image!,
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  "assets/images/profile.png",
                  height: 160,
                  width: 160,
                  fit: BoxFit.cover,
                ),
          const SizedBox(height: 48),
          buildButton(
            title: 'Gallery',
            icon: Icons.image_outlined,
            onClicked: () => pickImage(ImageSource.gallery),
          ),
          const SizedBox(height: 6),
          buildButton(
            title: 'Camera',
            icon: Icons.camera_alt_outlined,
            onClicked: () => pickImage(ImageSource.camera),
          ),
          const SizedBox(height: 24),
          buildUserInfo(user.name, 'Name', EditNameFormPage()),
          buildUserInfo(user.email, 'Email', EditEmailFormPage()),
          ListTile(
            title: const Text(
              'Gender:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: DropdownButton<String>(
              value: _botton2SelectedVal,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(
                    () => _botton2SelectedVal = newValue,
                  );
                }
              },
              items: this._genderDropDownMenuItems,
            ),
          ),
          ListTile(
            title: const Text(
              'Level:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: DropdownButton<String>(
              value: _botton1SelectedVal,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() => _botton1SelectedVal = newValue);
                }
              },
              items: this._levelDropDownMenuItems,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(56),
          primary: Colors.white,
          onPrimary: Colors.black,
          textStyle: TextStyle(fontSize: 20),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 28,
            ),
            const SizedBox(
              width: 16,
            ),
            Text(title),
          ],
        ),
        onPressed: onClicked,
      );

  Widget buildUserInfo(String getValue, String title, Widget editPage) =>
      Padding(
        padding: EdgeInsets.only(bottom: 15, left: 15, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            Container(
              width: 350,
              height: 40,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        navigateSecondPage(editPage);
                      },
                      child: Text(
                        getValue,
                        style: TextStyle(fontSize: 16, height: 1.4),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                    size: 40.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
