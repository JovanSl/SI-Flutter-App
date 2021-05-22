import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:v1/components/round_button.dart';
import 'package:provider/provider.dart';
import 'package:v1/db/auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool showSpinner = false;
  String email, password, adress, fullname;
  bool _showPassword = false;
    _validEmail(String validEmail) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(validEmail);
    return emailValid;
  }
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

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
                  child: Text("REGISTER",style:TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter email adress',
                ),
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
                decoration: InputDecoration(
                  hintText: 'Enter password',
                  prefixIcon: Container(width: 0,),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _togglevisibility();
                    },
                    child: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                ),
                obscureText: !_showPassword,
                textAlign: TextAlign.center,

                onChanged: (value) {
                  password = value;
                },
                //decoration:null,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter full name',
                ),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  fullname = value;
                },
                //decoration: null,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter address ',
                ),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  adress = value;
                },
                //decoration: null,
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  colour: Colors.black,
                  title: 'Register',
                  widget: () {
                    if (email == null || password == null || adress== null || fullname==null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.black,
                          content: const Text(
                            'All fields must contain value',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    } else if (_validEmail(email) != true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.black,
                          content: const Text(
                            'Email address format is incorrect',
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
                        context.read<Auth>().singUp(
                        email: email.trim(),
                        password: password.trim(),
                        fullname: fullname.trim(),
                        adress: adress.trim());
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.black,
                          content: const Text(
                            'Account successfuly created',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                       Navigator.pushNamed(context, '/login');
                      }catch (e){
                        print(e);
                      }                  
                    }
                      
                    
                  },),
                  Center(
                child: Container(
                  child: GestureDetector(
                      child: Text(
                        'Back to LogIn',
                        style: TextStyle(fontSize:15,color: Colors.grey[500]),
                      ),
                      onTap: () => Navigator.pushNamed(context, '/login')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
