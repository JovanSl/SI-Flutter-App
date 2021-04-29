import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:v1/components/order_list.dart';

  final _firestore = FirebaseFirestore.instance;

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,title: Text('ORDERS'),centerTitle: true,),
          body: Container(
            color: Colors.white,
          child:StreamBuilder(
            stream: _firestore.collection('orders').snapshots(),
            builder:  (context, snapshot) {
              if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final items = snapshot.data.docs;
          List<OrderList> orderLists = [];
          for (var item in items) {
            var b=item.data();
            print(b);
            final time = item.data()['time'];
            final total = item.data()['total'];
            final userId = item.data()['userId'];
            final order=item.data()['order'];
            final orderList = OrderList(
              time: time,
              total: total,
              userId: userId,
              order:order
            );
            orderLists.add(orderList);
          }
          return ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: orderLists,
          );
            }
            ),
        ),
    );
  }
}