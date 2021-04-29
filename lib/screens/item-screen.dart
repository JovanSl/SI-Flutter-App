import 'package:flutter/material.dart';
import 'package:v1/components/round_button.dart';
import 'package:v1/db/auth.dart';
import 'package:provider/provider.dart';
import 'package:v1/models/cart-items.dart';
import 'package:v1/screens/add-item-screen.dart';
import 'package:v1/components/appbar_cart_icon.dart';

class ItemScreen extends StatefulWidget {
  final String itemId;
  final String name;
  final String price;
  final String image;
  final String description;
  ItemScreen(
      {this.itemId, this.name, this.price, this.image, this.description});

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  var _counter = 1;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      // ignore: unnecessary_statements
      _counter > 1 ? _counter-- : null;
    });
  }

  String itemId, itemName, networkImage, itemPrice, itemDescription;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[appbarCartIcon(context)],
        automaticallyImplyLeading: false,
        title: Text(widget.name),
      ),
      body: Container(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: AspectRatio(
                      aspectRatio: 1.4, child: Image.network(widget.image)),
                ),
                Container(
                  child: Text(widget.name),
                ),
                Container(
                  child: Text(widget.price),
                ),
                Container(
                  child: Text(widget.description),
                ),
                RoundedButton(
                  colour: Colors.green,
                  title: 'Edit',
                  widget: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddItem(
                                widget.name,
                                widget.price,
                                widget.description,
                                widget.image,
                                widget.itemId)));
                  },
                ),
                RoundedButton(
                    colour: Colors.red,
                    title: 'Delete',
                    widget: () {
                      context.read<Auth>().deleteItem(widget.itemId);
                      Navigator.pushNamed(context, '/home');
                    }),
                RoundedButton(
                    colour: Colors.indigo,
                    title: 'Add to cart',
                    widget: () {
                      cart.addItem(widget.itemId, widget.name, widget.price,
                          widget.description, widget.image, _counter);
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FloatingActionButton(
                        heroTag: "fab1",
                        child: Icon(
                          Icons.remove,
                        ),
                        onPressed: _decrementCounter),
                    SizedBox(width: 30),
                    Text('$_counter'),
                    SizedBox(width: 30),
                    FloatingActionButton(
                        heroTag: "fab2",
                        child: Icon(
                          Icons.add,
                        ),
                        onPressed: _incrementCounter)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
