import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<Widget> list = [];

class OrderList extends StatelessWidget {
  OrderList(
      {this.itemId,
      this.time,
      this.total,
      this.userId,
      this.order,
      this.email,
      this.address,});
  final String itemId;
  final Timestamp time;
  final int total;
  final String userId;
  final List order;
  final String email;
  final String address;

  @override
  Widget build(BuildContext context) {
    return SingleItem(
      time: time,
      total: total,
      userId: userId,
      order: order,
      email: email,
      address: address,
    );
  }
}

class SingleItem extends StatelessWidget {
  const SingleItem({
    Key key,
    @required this.time,
    @required this.total,
    @required this.userId,
    @required this.order,
    @required this.email,
    @required this.address,
  }) : super(key: key);
  final Timestamp time;
  final int total;
  final String userId;
  final List order;
  final String email;
  final String address;

  nekoIme() {
    list.clear();
    order.forEach((element) {
      list.add(
        Expanded(
            child:
                Text("${element['name']}: X${element['quantity'].toString()}")),
      );
    });

    var date =
        DateTime.fromMicrosecondsSinceEpoch(time.millisecondsSinceEpoch * 1000);
    var formattedDate = DateFormat.yMMMd().format(date);
    list.add(SizedBox(height: 10));
    list.add(Text('$formattedDate ' ' Total price: $total'));
    list.add(Text('$email'));
    list.add(Text('$address'));
    return Container(
      
      child: Column(children: list),
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
          ]),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return nekoIme();
  }
}
