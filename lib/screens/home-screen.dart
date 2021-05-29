import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:v1/components/item_stream.dart';
import 'package:v1/db/auth.dart';
import 'package:v1/components/appbar_cart_icon.dart';
import 'package:v1/stfull/if_admin_bottom_bar.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
var userRole;
final Auth dbAuth = new Auth(auth);
var b=auth.currentUser.uid;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: IfAdminBottomBar(0),
      appBar: AppBar(
        title: Text(
          'V1',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: <Widget>[appbarCartIcon(context)],
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Stack(children: <Widget>[
              FutureBuilder(
                  future: dbAuth
                      .userInfo(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    } else {
                      userRole = snapshot.data[0];
                      if (userRole != 'admin') {
                        userRole = 'user';
                        return ItemsStream(userRole);
                      }
                      return ItemsStream(userRole);
                    }
                  }),
            ]),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class MessageHandler extends StatefulWidget {
  @override
  _MessageHandlerState createState() => _MessageHandlerState();
}

class _MessageHandlerState extends State<MessageHandler> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('onMessage: $message');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: ListTile(
            title: Text(message['notification']['title']),
            subtitle: Text(message['notification']['body']),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }, onResume: (Map<String, dynamic> message) async {
      print('onResume: $message');
    }, onLaunch: (Map<String, dynamic> message) async {
      print('onLaunch: $message');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
