import 'package:flutter/material.dart';

IconButton appbarCartIcon(BuildContext context) {
  return IconButton(
    icon: Icon(
      Icons.shopping_cart_outlined,
      color: Colors.white,
    ),
    onPressed: () {
      Navigator.pushNamed(context, '/cart');
    },
  );
}
