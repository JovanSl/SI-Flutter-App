import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:v1/models/orders.dart';

  final _firestore = FirebaseFirestore.instance;
  void onPressed(){
    List<Orders> _cartItem = [];
     _firestore.collection("orders").get().then((querySnapshot) {
           querySnapshot.docs.forEach((result) {
            Orders order=Orders.fromMap(result.data());
             _cartItem.add(order);
             print(order);
            });
            _cartItem.forEach((result) {
              //print(result.name);
            });
           });
  }

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,title: Text('ORDERS'),centerTitle: true,),
          body: Container(
            color: Colors.white,
          child:Column(children: <Widget>[ElevatedButton(onPressed:(){onPressed();},child: Text('123'),)],),
          ),
        )
        ;}
}