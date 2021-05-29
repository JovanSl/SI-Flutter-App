import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1/components/round_button.dart';
import 'package:v1/db/auth.dart';
import 'package:v1/models/cart-items.dart';
import 'package:v1/components/cart_item.dart';

import 'home-screen.dart';

var total;
List<List> x = [];
List<String> y = [];
  final FirebaseAuth auth = FirebaseAuth.instance;
          

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
   var address;
          @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbAuth.userInfo().then((value) =>
          { address = value[2],print("$address")});
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Cart'),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            
            cart.items.length >= 1
                ? Expanded(
                    child: ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) => CartI(
                          cart.items.values.toList()[index].id,
                          cart.items.keys.toList()[index],
                          cart.items.values.toList()[index].price,
                          cart.items.values.toList()[index].quantity,
                          cart.items.values.toList()[index].name,
                          cart.items.values.toList()[index].description,
                          cart.items.values.toList()[index].image),
                    ),
                  )
                : Expanded(child: Center(child: Text("Your cart is empty"))),
            cart.items.length < 1
                ? RoundedButton(
                    colour: Colors.grey,
                    widget: () {
                      print('null');
                    },
                    title: 'Cart is empty',
                  )
                : RoundedButton(
                    colour: Colors.green,
                    widget: () {
                      context.read<Auth>().placeOrder(
                          cart.items.values.map((e) => e.toMap()).toList(),
                          cart.totalAmount,
                          auth.currentUser.email,
                          address,
                          );
                      cart.clear();
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/home');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(milliseconds: 1500),
                          backgroundColor: Colors.black,
                          content: Text(
                            'Order created',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    },
                    title: 'Checkout total: ${cart.totalAmount} RSD',
                  ),
          ],
        ));
  }
}
