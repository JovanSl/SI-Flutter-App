import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:v1/db/auth.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;

Auth dbAuth = new Auth(auth);
String userRole, fullName, address;
  final uid=auth.currentUser.uid;

class _ProfileScreenState extends State<ProfileScreen> {
   var nameTextController = TextEditingController();
   var addressTextController = TextEditingController();
  var state=false;
  void _toggleEdit() {
    setState(() {
      state==false ? state=true:state=true;
    });
  }
  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: dbAuth.userInfo().then((value) =>
          {userRole = value[0], fullName = value[1], address = value[2],nameTextController.text=fullName,addressTextController.text=address}),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            actions: <Widget>[
              state==true?
              IconButton(
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                onPressed: () {
                  context.read<Auth>().editUser(
                    nameTextController.text.trim(),
                    addressTextController.text.trim()
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.black,
                          content: const Text(
                            'Successfully updated',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    _toggleEdit();
                },
              ):
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: (){
                     _toggleEdit();  
                },
                ),
            ],
            title: Text('PROFILE'),
          ),
          body: Center(
            child: SingleChildScrollView(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 130,
                    ),
                    radius: 80,
                  ),
                  SizedBox(height: 50),
                  Text('Full Name:', style: TextStyle(fontSize: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      state == false ? Flexible(
                        child: RichText(
                          text: TextSpan(
                            text: fullName,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Nunito-Bold',
                              fontSize: 35,
                            ),
                          ),
                        ),
                      ) : Flexible(
                  child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter full name',
                  ),
                  controller: nameTextController,
                  textAlign: TextAlign.center,
                   onChanged: (value) {
                      nameTextController.text = value;
                      nameTextController.selection = TextSelection.fromPosition(
                          TextPosition(offset: nameTextController.text.length));
                    },
                  //decoration: null,
                ),
                      ),
                      SizedBox(width:10),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text('Address for delivery:', style: TextStyle(fontSize: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                       state == false ? Flexible(
                         child: Center(
                          child: Container(
                            child: RichText(
                              overflow: TextOverflow.clip,
                              text: TextSpan(
                                text: address,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Nunito-Bold',
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ): Flexible(
                  child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter full name',
                  ),
                  controller: addressTextController,
                  textAlign: TextAlign.center,
                   onChanged: (value) {
                      addressTextController.text = value;
                      addressTextController.selection = TextSelection.fromPosition(
                          TextPosition(offset: addressTextController.text.length));
                    },
                  //decoration: null,
                ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
