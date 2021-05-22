import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:v1/components/circular_button.dart';
import 'package:v1/components/item_stream.dart';
import 'package:v1/stfull/if_admin.dart';
import 'package:v1/components/appbar_cart_icon.dart';

AnimationController animationController;
Animation transitionAnimation;

double getRadians(double degree) {
  double unitRadian = 57.295779513;
  return degree / unitRadian;
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 125));
    transitionAnimation =
        Tween(begin: 0.0, end: 1.0).animate(animationController);
    animationController.addListener(() {
      setState(() {});
    });
    dbAuth.userInfo().then((value) => setState(() {
          userRole = value.toString();
        }));
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('V1',style:TextStyle(color: Colors.white,fontWeight: FontWeight.w900),),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: <Widget>[appbarCartIcon(context)],
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            FutureBuilder
            (future:dbAuth.userInfo().then((value) => {userRole=value[0]}),
            builder: (context,snapshot){
               return  Stack(children:<Widget>[
                  ItemsStream(userRole),
            Positioned(
              right: 30,
              bottom: 30,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  IfAdmin(),
                  CircluarButton(
                    color: Colors.black,
                    width: 50,
                    height: 50,
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onClick: () {
                      if (animationController.isCompleted) {
                        animationController.reverse();
                      } else {
                        animationController.forward();
                      }
                    },
                  ),
                ],
              ),
            ),
                ]);
            }),
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
        onMessage: (Map<String,dynamic>message)async{
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
        },
         onResume: (Map<String,dynamic>message)async{
          print('onResume: $message');
          
        },
         onLaunch: (Map<String,dynamic>message)async{
          print('onLaunch: $message');
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}