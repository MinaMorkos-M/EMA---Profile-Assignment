import 'package:ema_ass_1/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

// This class handles the Page to edit the Email Section of the User Profile.
class EditEmailFormPage extends StatefulWidget {
  const EditEmailFormPage({Key? key}) : super(key: key);

  @override
  EditEmailFormPageState createState() {
    return EditEmailFormPageState();
  }
}

class EditEmailFormPageState extends State<EditEmailFormPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  var user = UserData.myUser;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void updateUserValue(String email) {
    user.email = email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Text(
                "What's your email?",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 16, 0),
                child: TextFormField(
                  // Handles Form Validation
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email.';
                    }
                    return null;
                  },
                  decoration:
                      const InputDecoration(labelText: 'Your email address'),
                  controller: emailController,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 70),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 330,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate() &&
                          EmailValidator.validate(emailController.text)) {
                        updateUserValue(emailController.text);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
