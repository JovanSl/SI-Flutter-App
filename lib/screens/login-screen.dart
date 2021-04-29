import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:v1/components/round_button.dart';
import 'package:provider/provider.dart';
import 'package:v1/db/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Container(
                  color: Colors.grey[50],
                  height: 200.0,
                  child: Text("LOGIN"),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                //decoration: null,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                //decoration:null,
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  colour: Colors.blueAccent,
                  title: 'LogIn',
                  widget: () {
                    context
                        .read<Auth>()
                        .singIn(email: email.trim(), password: password.trim());
                  }),
              SizedBox(
                height: 24.0,
              ),
              Center(
                child: Container(
                  child: GestureDetector(
                      child: Text(
                        'Not yet registered?',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                      onTap: () => Navigator.pushNamed(context, '/register')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
