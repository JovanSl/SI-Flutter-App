import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1/models/cart-items.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartI extends StatelessWidget {
  final String id;
  final String productId;
  final String price;
  final int quantity;
  final String name;
  final String description;
  final String image;

  CartI(this.id, this.productId, this.price, this.quantity, this.name,
      this.description, this.image);

  @override
  Widget build(BuildContext context) {
    double doublePrice = double.parse(price);
    return Card(
      key: ValueKey(id),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: ListTile(
          leading: CircleAvatar(
            child: Image.network(image),
          ),
          title: Text(name),
          subtitle: Text('Total: RSD${(doublePrice * quantity)}'),
          trailing: Text('$quantity x'),
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Add one',
            color: Colors.green,
            icon: Icons.add,
            onTap: () => Provider.of<Cart>(context, listen: false)
                .addItem(productId, name, price, description, image, 1),
          ),
          IconSlideAction(
            caption: 'Remove one',
            color: Colors.red,
            icon: Icons.remove,
            onTap: () => Provider.of<Cart>(context, listen: false)
                .removeSingleItem(productId),
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.blue,
            icon: Icons.delete,
            onTap: () =>
                Provider.of<Cart>(context, listen: false).removeItem(productId),
          ),
        ],
      ),
    );
  }
}
