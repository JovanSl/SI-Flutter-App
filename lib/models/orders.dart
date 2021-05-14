
import 'package:v1/models/cart-items.dart';

class Orders{
  String id;
  double total;
  String userId;
  List<Cart> order;

  Orders({this.id,this.total,this.userId,this.order});

    factory Orders.fromMap(Map<String, dynamic> parsedJson) {

    List<Cart> orders = [];
    //orders = parsedJson.map((key, value) => Cart.fromMap(key).);

    return new Orders(
      id:parsedJson['id'].toString(),
      order: orders,
      userId: parsedJson['userId']
    );
  }
}