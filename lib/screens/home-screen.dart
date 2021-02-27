import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1/components/round_button.dart';
import 'package:v1/db/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;
Auth dbAuth=new Auth(auth);
String userRole;

class Home extends StatefulWidget {
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
     super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('V1')),),
       bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ],
      selectedItemColor: Color(0xFFF44336),
      onTap: null,
    ),
      body:Column(
      crossAxisAlignment:CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         IfAdmin(),
         ItemsStream(),
      ],
    ),
    backgroundColor: Colors.lightBlueAccent,
    );
  }
}
class IfAdmin extends StatefulWidget{
  @override
  _IfAdminState createState() => _IfAdminState();
}

class _IfAdminState extends State<IfAdmin> {
  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: dbAuth.userRole().then((value) =>{
        userRole=value.toString()}),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
           if(userRole=='admin'){
           return Center(
          child: Container(
            child: RoundedButton(
                widget:()=>
                Navigator.pushNamed(context, '/addItem'), 
                title:"Add new menu item",
                colour: Color(0xFFF44336),
            ),
          ),
        );
           }else{
             return Container(child:null);
           }
          } else {
            return CircularProgressIndicator();
          }
        });
}
class ItemsStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('items')
            .snapshots(),
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
            final itemsList = ItemsList(
                name: name,
                price: price,
                image: image,
                description: description);
            itemsLists.add(itemsList);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: itemsLists,
            ),
          );
          
        });
        }
  }
  class ItemsList extends StatelessWidget {
  ItemsList({this.name, this.price, this.image, this.description});
  final String name;
  final String price;
  final String image;
  final String description;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {Navigator.pushNamed(context, '/addItem');},
      child: Card(
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0),
  ),
        child: Column(
          children: <Widget>[
            Text(
              'name: $name',
              style: TextStyle(fontSize: 20.0, color: Colors.black54),
            ),
             Text(
              'price: $price',
              style: TextStyle(fontSize: 20.0, color: Colors.black54),
            ),
             Text(
              'image: $image',
              style: TextStyle(fontSize: 20.0, color: Colors.black54),
            ),
             Text(
              'description: $description',
              style: TextStyle(fontSize: 20.0, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}