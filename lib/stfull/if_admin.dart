// import 'package:flutter/material.dart';
// import 'package:v1/components/stack_buttons.dart';
// import 'package:v1/db/auth.dart';
// import 'package:v1/screens/home-screen.dart';
// import 'package:provider/provider.dart';

// class IfAdmin extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: dbAuth.userInfo(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           userRole = snapshot.data[0];
//           if (userRole == 'admin') {
//             return Stack(
//               alignment: AlignmentDirectional.bottomStart,
//               children: <Widget>[
//                 IgnorePointer(
//                   ignoring: (animationController.isCompleted) ? false : true,
//                   child: Container(
//                     color: Colors.transparent,
//                     height: 270.0,
//                     width: 50.0,
//                   ),
//                 ),
//                 StackButtons(Colors.yellow[800], Icons.add, () {
//                   Navigator.pop(context);
//                   Navigator.pushNamed(context, '/addItem');
//                 }, 220),
//                 StackButtons(Colors.red, Icons.logout, () {
//                   context.read<Auth>().signOut();
//                 }, 55),
//                 StackButtons(Colors.indigo, Icons.person, () {
//                   Navigator.pushNamed(context, '/profile');
//                 }, 110),
//                 StackButtons(Colors.green, Icons.history_sharp, () {
//                   Navigator.pushNamed(context, '/orders');
//                 }, 165),
//               ],
//             );
//           } else {
//             return Stack(
//                 alignment: AlignmentDirectional.bottomStart,
//                 children: <Widget>[
//                   IgnorePointer(
//                     ignoring: (animationController.isCompleted) ? false : true,
//                     child: Container(
//                       color: Colors.transparent,
//                       height: 270.0,
//                       width: 50.0,
//                     ),
//                   ),
//                   StackButtons(Colors.red, Icons.logout, () {
//                     context.read<Auth>().signOut();
//                   }, 55),
//                   StackButtons(Colors.indigo, Icons.person, () {
//                     Navigator.pushNamed(context, '/profile');
//                   }, 110),
//                   StackButtons(Colors.green, Icons.history_sharp, () {
//                     Navigator.pushNamed(context, '/orders');
//                   }, 165),
//                 ]);
//           }
//         } else {
//           return Container();
//         }
//       },
//     );
//   }
// }
