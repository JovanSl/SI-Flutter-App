import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:v1/components/order_list.dart';
import 'home-screen.dart';

  final _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  var userRole='';
class OrdersScreen extends StatelessWidget {
  final uid=auth.currentUser.uid;
  final adminIF=_firestore.collection('orders').orderBy('time').snapshots();
  @override
  Widget build(BuildContext context) {
      return FutureBuilder(
        future:dbAuth.userInfo().then((value) => {userRole=value[0]}),
        builder:(context,snapshot){
          return StreamBuilder<QuerySnapshot>(
            stream: userRole=='admin'?adminIF:_firestore.collection('orders').where("userId", isEqualTo: uid).snapshots(),
            builder: (context,snapshot){
            if (!snapshot.hasData) {
            return Scaffold(
                body: Center(
                child: Text('No orders yet'),
              ),
            );
          }else{
          final items = snapshot.data.docs;
          List<OrderList> itemsLists = [];
          for (var item in items) {
            final itemId = item.data()['itemId'];
            final time = item.data()['time'];
            final total = item.data()['total'];
            final userId = item.data()['userId'];
            final order = item.data()['order'];
            final email=item.data()['userEmail'];
            final address=item.data()['address'];
            final itemsList = OrderList(
              itemId: itemId,
              time: time,
              total: total.round(),
              userId: userId,
              order: order.toList(),
              email: email,
              address:address,
            );
            itemsLists.add(itemsList);
          }
           return Scaffold(
             backgroundColor: Colors.white,
             appBar: AppBar(
               automaticallyImplyLeading: true,
               title: Text('ORDERS'),
               centerTitle: true,),
              body: ListView(
              reverse: false,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: itemsLists,
          ));
          }
          },);
        });   
}
}