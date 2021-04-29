import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:v1/components/round_button.dart';
import 'package:provider/provider.dart';
import 'package:v1/db/auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:v1/screens/home-screen.dart';

class AddItem extends StatefulWidget {
  final String titleText,
      priceText,
      descriptionText,
      networkImage,
      itemId,
      image = null;
  AddItem(this.titleText, this.priceText, this.descriptionText,
      this.networkImage, this.itemId,
      {Key key})
      : super(key: key);
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  File _image;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  bool showSpinner = false;
  String name, price, image, description;
  @override
  Widget build(BuildContext context) {
    var titleTextController = TextEditingController(text: widget.titleText);
    var priceTextController = TextEditingController(text: widget.priceText);
    var descriptionTextController =
        TextEditingController(text: widget.descriptionText);
    image = widget.networkImage;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('ADD ITEM'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: ModalProgressHUD(
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
                  controller: titleTextController,
                  decoration: InputDecoration(
                      hintText: 'Enter item title',
                      border: OutlineInputBorder()),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    titleTextController.text = value;
                    titleTextController.selection = TextSelection.fromPosition(
                        TextPosition(offset: titleTextController.text.length));
                  },
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: priceTextController,
                  decoration: InputDecoration(
                      hintText: 'Enter item price',
                      border: OutlineInputBorder()),
                  textAlign: TextAlign.center,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  onChanged: (value) {
                    priceTextController.text = value;
                    priceTextController.selection = TextSelection.fromPosition(
                        TextPosition(offset: priceTextController.text.length));
                  },
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  maxLines: 4,
                  controller: descriptionTextController,
                  decoration: InputDecoration(
                      hintText: 'Enter item description',
                      border: OutlineInputBorder()),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) {
                    descriptionTextController.text = value;
                    descriptionTextController.selection =
                        TextSelection.fromPosition(TextPosition(
                            offset: descriptionTextController.text.length));
                  },
                ),
                SizedBox(
                  height: 24.0,
                ),
                Container(child: ImageDisplay(image, _image, getImage)),
                SizedBox(
                  height: 24.0,
                ),
                SizedBox(
                  height: 24.0,
                ),
                (widget.itemId.isNotEmpty)
                    ? RoundedButton(
                        colour: Colors.greenAccent,
                        title: 'Update item',
                        widget: () {
                          if (titleTextController.text.isNotEmpty &&
                              priceTextController.text.isNotEmpty &&
                              descriptionTextController.text.isNotEmpty) {
                            context.read<Auth>().editItem(
                                  name: titleTextController.text.trim(),
                                  price: priceTextController.text.trim(),
                                  description:
                                      descriptionTextController.text.trim(),
                                  image: (_image == null) ? image : _image,
                                  itemId: widget.itemId,
                                );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(),
                                ));
                          } else {
                            print("All fields must have value");
                          }
                        })
                    : RoundedButton(
                        colour: Colors.blueAccent,
                        title: 'Create item',
                        widget: () {
                          context.read<Auth>().addItem(
                                name: titleTextController.text.trim(),
                                price: priceTextController.text.trim(),
                                description:
                                    descriptionTextController.text.trim(),
                                image: _image,
                              );
                          Navigator.pushNamed(context, '/home');
                        }),
                SizedBox(
                  height: 24.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageDisplay extends StatefulWidget {
  final String image;
  final File _image;
  final Function getImage;
  ImageDisplay(this.image, this._image, this.getImage);
  @override
  _ImageDisplayState createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  @override
  Widget build(BuildContext context) {
    if (widget.image.isNotEmpty && widget._image == null) {
      return Container(
        height: 250,
        child: GestureDetector(
          child: Image.network(widget.image),
          onTap: () {
            widget.getImage();
          },
        ),
      );
    } else if (widget._image != null) {
      return Container(
        height: 250,
        child: GestureDetector(
          child: Image.file(widget._image),
          onTap: () {
            widget.getImage();
          },
        ),
      );
    } else {
      return Container(
          child: FloatingActionButton(
        onPressed: () {
          widget.getImage();
        },
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ));
    }
  }
}
