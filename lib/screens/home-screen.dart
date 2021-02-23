import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1/db/auth.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[100],
      child:RaisedButton(
        onPressed:()=>
        context.read<Auth>().singOut(), 
        child: Text("LOG OUT"),),
    );
  }
}