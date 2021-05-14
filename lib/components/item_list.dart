import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:v1/screens/item-screen.dart';

class ItemsList extends StatelessWidget {
  ItemsList(
      {this.itemId,
      this.name,
      this.price,
      this.image,
      this.description,
      this.userRole});
  final String itemId;
  final String name;
  final String price;
  final String image;
  final String description;
  final String userRole;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemScreen(
                  itemId: itemId,
                  name: name,
                  price: price,
                  image: image,
                  description: description),
            ));
      },
      child: userRole != 'admin'
          ? Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: SingleItem(
                  name: name,
                  price: price,
                  description: description,
                  image: image),
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Edit',
                  color: Colors.green,
                  icon: Icons.add,
                  onTap: () => null,
                ),
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () => null,
                ),
              ],
            )
          : SingleItem(
              name: name, price: price, description: description, image: image),
    );
  }
}

class SingleItem extends StatelessWidget {
  const SingleItem({
    Key key,
    @required this.name,
    @required this.price,
    @required this.description,
    @required this.image,
  }) : super(key: key);

  final String name;
  final String price;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "$price RSD",
                    style: const TextStyle(fontSize: 17, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    width: 210,
                    height: 62,
                    child: Text(
                      description,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ],
              ),
              Flexible(child: Image.network(image))
            ],
          ),
        ));
  }
}
