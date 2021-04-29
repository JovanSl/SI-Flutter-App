import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderList extends StatelessWidget {
  OrderList(
      {this.itemId,
      this.time,
      this.total,
      this.userId,
      this.order});
  final String itemId;
  final Timestamp time;
  final double total;
  final String userId;
  final List order;

  @override
  Widget build(BuildContext context) {
    return SingleItem(
            time: time, total: total, userId: userId, order:order);
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

  final Timestamp time;
  final double total;
  final String userId;
  final List order;
  @override
  Widget build(BuildContext context) {
    //DateTime myDateTime = time.toDate();
    //var formattedDate = DateFormat.MMMd().add_jms().format(myDateTime);
          print(order);
 //var data = json.decode(order);
    return Column(children:<Widget> [
      Text(order.toString()),
    ],
    );
  }
}