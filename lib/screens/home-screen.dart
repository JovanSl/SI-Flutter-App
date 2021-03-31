import 'package:flutter/material.dart';
import 'package:v1/db/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:v1/components/stack_buttons.dart';
import 'package:v1/components/circular_button.dart';
import 'package:v1/screens/item-screen.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;
AnimationController animationController;
Animation transitionAnimation;

Auth dbAuth=new Auth(auth);
String userRole;

double getRadians(double degree){
  double unitRadian=57.295779513;
  return degree/unitRadian;
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>with TickerProviderStateMixin {

  @override
  void initState() {
    animationController=AnimationController(vsync:this,duration: Duration(milliseconds: 250) );
    transitionAnimation=Tween(begin: 0.0,end:1.0).animate(animationController);
    animationController.addListener(() {
      setState((){
      });
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('V1')),),
        body: Container(
          child:Stack(
            children: <Widget>[
            ItemsStream(),
            Positioned(
              right: 30,
              bottom: 30,
              child:Stack(
                alignment: Alignment.bottomRight,
                  children:<Widget>[
                    IfAdmin(),
                    CircluarButton(
                      color:Colors.blue,
                      width: 50,
                      height: 50,
                      icon: Icon(Icons.menu,color:Colors.white,),
                     onClick: (){
                         if(animationController.isCompleted){
                           animationController.reverse();
                         }else{
                           animationController.forward();
                         }  
                     },
                    ),
               ],
               ),
               ),
             ],) ,
           ),
    backgroundColor: Colors.lightBlueAccent,
    );
  }
}
class IfAdmin extends StatefulWidget{
  @override
  _IfAdminState createState() => _IfAdminState();
}

class _IfAdminState extends State<IfAdmin>with TickerProviderStateMixin{

  @override
  void initState() {
    animationController=AnimationController(vsync:this,duration: Duration(milliseconds: 250) );
    transitionAnimation=Tween(begin: 0.0,end:1.0).animate(animationController);
    animationController.addListener(() {
      setState((){
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) => 
  FutureBuilder(
        future: dbAuth.userRole().then((value) =>{
        userRole=value.toString()}),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
           if(userRole=='admin'){
           return Stack(
                    alignment:AlignmentDirectional.bottomStart,
                    children:<Widget>[
                    IgnorePointer(
                    ignoring:(animationController.isCompleted) ? false :true,
                    child: Container(
                    color: Colors.transparent,
                    height: 270.0,
                    width: 50.0,
                  ),
                ),
                StackButtons(Colors.yellow[800], Icons.add,(){Navigator.pushNamed(context,'/addItem');} , 220 ),
                    StackButtons(Colors.red, Icons.logout,(){print("logout");} , 55 ),
                    StackButtons(Colors.indigo, Icons.person, (){print("profile");} , 110 ),
                    StackButtons(Colors.green, Icons.history_sharp,(){print("order history");} , 165 ),
                    ],
                    );
           }else{
             return Stack(
               alignment:AlignmentDirectional.bottomStart,
               children:<Widget>[
                StackButtons(Colors.red, Icons.logout,(){print("logout");} , 55 ),
                StackButtons(Colors.indigo, Icons.person, (){print("profile");} , 110 ),
                StackButtons(Colors.green, Icons.history_sharp,(){print("order history");} , 165 ),
               ]
             );
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
            final itemId=item.data()['id'];
            final itemsList = ItemsList(
                name: name,
                price: price,
                image: image,
                description: description,
                itemId:itemId,);
            itemsLists.add(itemsList);
          }
          return ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: itemsLists,
          );
          
        });
        }
  }
  class ItemsList extends StatelessWidget {
  ItemsList({this.name, this.price, this.image, this.description,this.itemId});
  final String name;
  final String price;
  final String image;
  final String description;
  final String itemId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
        builder: (context) => ItemScreen(itemId: itemId,),
        ));
      },
      child: Container(
          height: 150,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), 
          color: Colors.white,
           boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
          ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  
                  Text(
                    name,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text(
                   "$price RSD",
                    style: const TextStyle(fontSize: 17, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      child: Text(
                      description,
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ],
                  ),
                Flexible(child: Image.network(image))
              ],
            ),
          ))
    );
  }
}    