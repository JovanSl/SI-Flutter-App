import 'package:flutter/material.dart';

class CartItem extends ChangeNotifier{
  final String id;
  final String name;
  final int quantity;
  final String price;
  final String description;
  final String image;

  CartItem(
      { 
      @required this.id,
      @required this.name,
      @required this.quantity,
      @required this.price,
       this.description,
       this.image,});

  //   Map<String, dynamic> toMap() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['quantity'] = this.quantity;
  //   data['price'] = this.price;
  //   return data;
  // }
    Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'quantity':this.quantity,
      'price': this.price,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id:json['id'],
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'],
      description:json['description'],
      image:json['image']
    );
  }
}
class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  List<CartItem> cart;
  Cart({this.cart});
  Map<String, CartItem> get items {
    return {..._items};
  }
    Map<String, dynamic> toMap() {
    return {
      'cart': cart.map((i) => i.toMap()).toList(),
    };
  }
  // Map<String,dynamic> toJson(){
  //   final Map<String,dynamic> data=new Map<String,dynamic>();
  //   if (this.cart != null) {
  //     data['cart'] = this.cart.map((v) => v.toJson()).toList();
  //   }
  // }
  factory Cart.fromJson(dynamic json) {
    List<CartItem> cart = (json as List).map((i) {
      return CartItem.fromJson((i));
    }).toList();
    return Cart(cart: cart);
  }


  int get itemCount {
    return _items.length;
  }



  void addItem(String itemId, String name, String price, String description,String image,int quantity) {
    if (_items.containsKey(itemId)) {
      _items.update(
          itemId,
          (existingCartItem) => CartItem(
              id: itemId,
              name: existingCartItem.name,
              quantity: existingCartItem.quantity + quantity,
              price: existingCartItem.price,
              description: description,
              image: image));
    } else {
      _items.putIfAbsent(
          itemId,
          () => CartItem(
                name: name,
                id: itemId,
                quantity: quantity,
                price: price,
                description: description,
                image: image
              ));
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    }
    if (_items[id].quantity > 1) {
      _items.update(
          id,
          (existingCartItem) => CartItem(
              id: id,
              name: existingCartItem.name,
              quantity: existingCartItem.quantity - 1,
              price: existingCartItem.price,
              description: existingCartItem.description,
              image: existingCartItem.image));
    }
    notifyListeners();
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += double.parse(cartItem.price) * cartItem.quantity;
    });
    return total;
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
  
}