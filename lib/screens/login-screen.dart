import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:v1/components/round_button.dart';
import 'package:provider/provider.dart';
import 'package:v1/db/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  _validEmail(String validEmail) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(validEmail);
    return emailValid;
  }

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
              Center(
                child: Container(
                  child: Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
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
                  colour: Colors.black,
                  title: 'LogIn',
                  widget: () {
                    if (email == null || password == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.black,
                          content: const Text(
                            'Email or password cannot be empty',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    } else if (_validEmail(email) != true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.black,
                          content: const Text(
                            'Email address is incorrect',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    } else if (password.length < 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.black,
                          content: const Text(
                            'Password must be at least 6 characters long',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    } else {
                      try{
                        context.read<Auth>().singIn(
                          email: email.trim(), password: password.trim());
                           Navigator.pushNamed(context, '/home');
                      }catch (e){
                         ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.black,
                          content: const Text(
                            "User doesn't exist",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                      }
                      
                    }
                  }),
              SizedBox(
                height: 24.0,
              ),
              Center(
                child: Container(
                  child: GestureDetector(
                      child: Text(
                        'Not yet registered?',
                        style: TextStyle(fontSize:15,color: Colors.grey[500]),
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
