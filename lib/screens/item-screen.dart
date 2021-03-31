import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:v1/components/round_button.dart';
import 'package:v1/db/auth.dart';
import 'package:provider/provider.dart';
import 'package:v1/screens/add-item-screen.dart';

  final _firestore = FirebaseFirestore.instance;
class ItemScreen extends StatefulWidget {
  final String itemId;
  ItemScreen({this.itemId});
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  String itemId;
  String itemName;
  String networkImage;
  String itemPrice;
  String itemDescription;
  
  @override
  Widget build(BuildContext context) {
    print(widget.itemId);
    return FutureBuilder(
            future: _firestore.collection('items').doc(widget.itemId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
    if (snapshot.connectionState == ConnectionState.done) {
                final item = snapshot.data;
                
                itemName = item['name'];
                itemPrice = item['price'];
                networkImage=item['image'];
                itemDescription=item['description'];
                itemId=item['id'];

                return Scaffold(body: 
                SafeArea(
                  child: Column(
                    children:<Widget> [
                  SizedBox(
                    width:MediaQuery.of(context).size.width,
                  child:(networkImage != null)
                  ? AspectRatio(aspectRatio:1.4,child: Image.network(networkImage))
                  : Text("no image retrieved"),),
                  Container(child: Text(itemName),),
                  Container(child: Text(itemPrice),),
                  Container(child: Text(itemDescription),),
                  RoundedButton(
                  colour: Colors.green,
                  title: 'Edit',
                  widget:(){
                 Navigator.push(
                 context,
                 MaterialPageRoute(
                 builder: (context) => AddItem(itemName,itemPrice,itemDescription,networkImage,itemId)));
                  },
                  
              ),
                  RoundedButton(
                  colour: Colors.red,
                  title: 'Delete',
                  widget:(){
                  context.read<Auth>().deleteItem(itemId,);
                  Navigator.pushNamed(context,'/home');
                  }
               ),
                   ],
                   ),
                ),
                 );
              
     }
     else{
       return Scaffold(body: CircularProgressIndicator());
     }
   });
  
  }
}