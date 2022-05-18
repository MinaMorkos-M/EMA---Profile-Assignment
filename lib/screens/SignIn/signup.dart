import 'package:ema_ass_1/screens/SignUp/signupwithmail.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[400]!),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Row(children: [
              Expanded(child: Divider(thickness: 2)),
              Text(
                " Sign Up ",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              ),
              Expanded(
                  child: Divider(
                thickness: 2,
              )),
            ]),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: new RawMaterialButton(
                  onPressed: () {
                    print('touched email');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpWithMail()),
                    );
                  },
                  child: new Icon(
                    Icons.mail,
                    color: Colors.white,
                    size: 50.0,
                  ),
                  shape: new CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.redAccent,
                  padding: const EdgeInsets.all(15.0),
                ),
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 14),
              ),
            ],
          )
        ],
      ),
    );
  }
}
