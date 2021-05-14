import 'package:flutter/material.dart';

class CartItem extends ChangeNotifier{
   String id;
   String name;
   int quantity;
   String price;
   String description;
   String image;
   double total;

  CartItem(
      { 
       this.id,
       this.name,
       this.quantity,
       this.price,
       this.description,
       this.image,
       this.total});

    Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'quantity':this.quantity,
      'price': this.price,
      'total':this.total,
    };
  }
 factory CartItem.fromMap(Map<String,dynamic> data){
    return CartItem(
    id:data['id'],
    name:data['name'],
    quantity:data['quantity'],
    price:data['price'],
    );
  }
}
class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  List<CartItem> cart;
  int total;
  Cart({this.cart,this.total});

  Map<String, CartItem> get items {
    return {..._items};
  }

    Map<String, dynamic> toMap() {
    return {
      'cart': cart.map((i) => i.toMap()).toList(),
    };
  }

  factory Cart.fromMap(Map<String, dynamic> data) {
    var carts = data['cart'] as List;

    List<CartItem> cartItemList=carts.map((e) => CartItem.fromMap(data)).toList();

    return Cart(
      cart:cartItemList,
      total:data['total'],
    );
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