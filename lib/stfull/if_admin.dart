import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:v1/components/stack_buttons.dart';
import 'package:v1/db/auth.dart';
import 'package:v1/screens/home-screen.dart';
import 'package:provider/provider.dart';

class IfAdmin extends StatefulWidget {
  @override
  _IfAdminState createState() => _IfAdminState();
}

final FirebaseAuth auth = FirebaseAuth.instance;

Auth dbAuth = new Auth(auth);
String userRole;

class _IfAdminState extends State<IfAdmin> {
  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: dbAuth.userRole().then((value) => {userRole = value.toString()}),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (userRole == 'admin') {
            return Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: <Widget>[
                IgnorePointer(
                  ignoring: (animationController.isCompleted) ? false : true,
                  child: Container(
                    color: Colors.transparent,
                    height: 270.0,
                    width: 50.0,
                  ),
                ),
                StackButtons(Colors.yellow[800], Icons.add, () {
                  Navigator.pushNamed(context, '/addItem');
                }, 220),
                StackButtons(Colors.red, Icons.logout, () {
                  context.read<Auth>().signOut();
                }, 55),
                StackButtons(Colors.indigo, Icons.person, () {
                  print("profile");
                }, 110),
                StackButtons(Colors.green, Icons.history_sharp, () {
                 Navigator.pushNamed(context, '/orders');
                  print("order history");
                }, 165),
              ],
            );
          } else {
            return Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: <Widget>[
                  StackButtons(Colors.red, Icons.logout, () {
                    print("logout");
                  }, 55),
                  StackButtons(Colors.indigo, Icons.person, () {
                    print("profile");
                  }, 110),
                  StackButtons(Colors.green, Icons.history_sharp, () {
                    print("order history");
                  }, 165),
                ]);
          }
        } else {
          return CircularProgressIndicator();
        }
      });
}
