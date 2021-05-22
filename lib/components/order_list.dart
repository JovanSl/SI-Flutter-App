import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

List<Widget> list = [];

class OrderList extends StatelessWidget {
  OrderList({this.itemId, this.time, this.total, this.userId, this.order});
  final String itemId;
  final Timestamp time;
  final double total;
  final String userId;
  final List order;

  @override
  Widget build(BuildContext context) {
    return SingleItem(time: time, total: total, userId: userId, order: order);
  }
}

class SingleItem extends StatelessWidget {
  const SingleItem({
    Key key,
    @required this.time,
    @required this.total,
    @required this.userId,
    @required this.order,
  }) : super(key: key);

  nekoIme() {
    list.clear();
    order.forEach((element) {
      list.add(
        Expanded(child: Text("${element['name']}: X${element['quantity'].toString()}")),
      );
    });
    list.add(Text('Total price: $total'));
    list.add(SizedBox(height: 10));
    return Container(height:100, child: Column(children: list),
        decoration:BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
            ]) ,padding:EdgeInsets.all(8.0),
            margin: EdgeInsets.all(8.0),);
  }

  final Timestamp time;
  final double total;
  final String userId;
  final List order;
  @override
  Widget build(BuildContext context) {
    return nekoIme();
  }
}