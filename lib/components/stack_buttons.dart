import 'package:flutter/material.dart';
import 'package:v1/screens/home-screen.dart';
import 'circular_button.dart';

class StackButtons extends StatelessWidget {
  StackButtons( this.color ,this.icon,this.onClick, this.transitionValue);
  final IconData icon;
  final Function onClick;
  final Color color;
  final int transitionValue;
  @override
  Widget build(BuildContext context) {
    return Container(child:
                    Transform.translate(
                       offset: Offset.fromDirection(getRadians(270),transitionAnimation.value*transitionValue),
                        child: CircluarButton(
                        color:color,
                        width: 50,
                        height: 50,
                        icon: Icon(icon,color:Colors.white,),
                       onClick:onClick,
                      ),
                    ),
           );
  }
}
