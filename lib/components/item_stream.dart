import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:v1/components/item_list.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;
AnimationController animationController;
Animation transitionAnimation;

class ItemsStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('items').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final items = snapshot.data.docs;
          List<ItemsList> itemsLists = [];
          for (var item in items) {
            final name = item.data()['name'];
            final price = item.data()['price'];
            final image = item.data()['image'];
            final description = item.data()['description'];
            final itemId = item.data()['id'];
            final itemsList = ItemsList(
              name: name,
              price: price,
              image: image,
              description: description,
              itemId: itemId,
            );
            itemsLists.add(itemsList);
          }
          return ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: itemsLists,
          );
        });
  }
}
