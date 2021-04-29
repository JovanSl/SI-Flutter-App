import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1/components/round_button.dart';
import 'package:v1/db/auth.dart';
import 'package:v1/models/cart-items.dart';
import 'package:v1/components/cart_item.dart';

var total;

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Cart'),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            cart.items.length >= 1
                ? Expanded(
                    child: ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) => CartPdt(
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
            RoundedButton(
              colour: Colors.green,
              widget: () {
                context.read<Auth>().placeOrder(
                    cart.items.values.map((e) => e.toMap()).toList(),
                    cart.totalAmount);
                cart.clear();
                Navigator.pushNamed(context, '/home');
              },
              title: 'Checkout total: ${cart.totalAmount} RSD',
            ),
          ],
        ));
  }
}
