import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:v1/components/round_button.dart';
import 'package:provider/provider.dart';
import 'package:v1/db/auth.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  bool showSpinner = false;
  String name,price,image,description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: Text('ADD ITEM'),),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[ 
              SizedBox(
                height: 48.0,
              ),
              TextField(
                decoration: InputDecoration(
                hintText: 'Enter item title'
                ),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  name = value;
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                decoration: InputDecoration(
                hintText: 'Enter item price'
                ),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  price = value;
                },
              ),
               TextField(
                decoration: InputDecoration(
                hintText: 'Add  image'
                ),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  image = value;
                },
              ),
               TextField(
                decoration: InputDecoration(
                hintText: 'Enter item description'
                ),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  description = value;
                },
              ),
              SizedBox(
                height: 24.0,
              ),
                RoundedButton(
                colour: Colors.blueAccent,
                title: 'Create item',
                  widget:(){
                  context.read<Auth>().addItem(
                    name:name.trim(),
                    price: price.trim(),
                    description: description.trim(),
                    image: image.trim(),
                  );
                  }
              ),
               SizedBox(
                height: 24.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}