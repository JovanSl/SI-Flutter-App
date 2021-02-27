import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({this.colour, this.title, @required this.widget});
  final Color colour;
  final String title;
  final Function widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: widget,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
//  Center(
//           child: Container(
//             child: RoundedButton(
//                 widget:()=>
//                 context.read<Auth>().singOut(), 
//                 title:"LOG OUT",
//                 colour: Color(0xFFF44336),
//             ),
//           ),
//         ),