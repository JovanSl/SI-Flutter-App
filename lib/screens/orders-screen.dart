import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:v1/components/order_list.dart';
import 'package:v1/stfull/if_admin.dart';

  final _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final uid=auth.currentUser.uid;
  final userIf=_firestore.collection('orders').where("userId", isEqualTo: uid).snapshots();
  final adminIF=_firestore.collection('orders').snapshots();
  var userRole;
class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return FutureBuilder(
        future:dbAuth.userInfo().then((value) => {userRole=value[0]}),
        builder:(context,snapshot){
          return StreamBuilder<QuerySnapshot>(
            stream: userRole=='admin'?adminIF:userIf,
            builder: (context,snapshot){
            if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final items = snapshot.data.docs;
          List<OrderList> itemsLists = [];
          for (var item in items) {
            final itemId = item.data()['itemId'];
            final time = item.data()['time'];
            final total = item.data()['total'];
            final userId = item.data()['userId'];
            final order = item.data()['order'];
            final itemsList = OrderList(
              itemId: itemId,
              time: time,
              total: total,
              userId: userId,
              order: order.toList(),
            );
            itemsLists.add(itemsList);
          }
           return Scaffold(
             backgroundColor: Colors.white,
             appBar: AppBar(
               title: Text('ORDERS'),
               centerTitle: true,),
              body: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: itemsLists,
          ));
          },);
        });   
}
}