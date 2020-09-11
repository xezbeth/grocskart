import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocskart/CustomUI/CinputBox.dart';
import 'package:grocskart/constants.dart';
import 'package:grocskart/CustomUI/Clargetext.dart';
import 'package:grocskart/CustomUI/Cicontextfield.dart';
import 'package:grocskart/CustomUI/Cbutton.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SEditItem extends StatefulWidget {
  static final String id = "SEditItem";
  @override
  _SAddItemState createState() => _SAddItemState();
}

List<Text> getUnits() {
  List<Text> menuItems = [];
  for (String item in kUnits) {
    menuItems.add(
      Text(
        item,
        style: TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }
  return menuItems;
}

class _SAddItemState extends State<SEditItem> {
  final _firestore = FirebaseFirestore.instance;

  final String shopName = "shop1";

  String units = "qty", itemName, itemDesc, imageLink;
  String price, quantity, discount, id, image;
  File _image;

  Future getImage(bool isCamera) async {
    var image;
    if (isCamera) {
      image = await ImagePicker().getImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker().getImage(source: ImageSource.gallery);
    }

    setState(() {
      if (image != null) {
        _image = File(image.path);
      }
    });
  }

  Future<String> saveImage(File image, String imageName) async {
    StorageReference ref =
        FirebaseStorage.instance.ref().child(shopName).child("$imageName.jpg");
    StorageUploadTask uploadTask = ref.putFile(image);
    var downloadURL = (await uploadTask.onComplete).ref.getDownloadURL();
    return await downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments != null) {
      image = arguments['image'];
      itemName = arguments['name'];
      itemDesc = arguments['desc'];
      price = arguments['price'].toString();
      discount = arguments['discount'].toString();
      id = arguments['id'].toString();
      quantity = arguments['quantity'].toString();
    }

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  _image == null
                      ? Image(
                          image: NetworkImage(image),
                          height: 250,
                          width: double.infinity,
                        )
                      : Image.file(
                          _image,
                          height: 250,
                          width: double.infinity,
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              size: 40,
                            ),
                            onPressed: () {
                              getImage(true);
                            },
                          ),
                          Text("Camera"),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.insert_drive_file,
                              size: 40,
                            ),
                            onPressed: () {
                              getImage(false);
                            },
                          ),
                          Text("Gallery"),
                        ],
                      ),
                    ],
                  ),
                  Ctextfield(
                    hint: itemName,
                    onChanged: (value) {
                      itemName = value;
                    },
                  ),
                  QTextField(
                    hint: itemDesc,
                    onChanged: (value) {
                      itemDesc = value;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 100,
                            child: CupertinoPicker(
                              itemExtent: 40,
                              onSelectedItemChanged: (index) {
                                setState(() {
                                  units = kUnits[index];
                                });
                              },
                              children: getUnits(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Ctextfield(
                          hint: quantity,
                          onChanged: (value) {
                            quantity = value;
                            print(quantity);
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Cicontext(
                        icon: Image.asset("images/inr.png"),
                        hint: price,
                        onChanged: (value) {
                          price = value;
                        },
                      ),
                      Cicontext(
                        icon: Image.asset(
                          "images/percent.png",
                        ),
                        hint: discount,
                        onChanged: (value) {
                          discount = value;
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: cButton(
                          text: "preview",
                          onPressed: () {},
                        ),
                      ),
                      Expanded(
                        child: cButton(
                          text: "delete",
                          onPressed: () {
                            //  print(_image.toString());
                            // var imageLink = saveImage(_image, itemName);
                            // print(imageLink);
                          },
                        ),
                      ),
                    ],
                  ),
                  cButton(
                    text: "push",
                    onPressed: () {
                      print(price);
                      print(quantity);
                      //var imageLink = saveImage(_image.toString());
                      var imageLink = saveImage(_image, itemName);
                      _firestore.collection('shops/$shopName/items/').add({
                        'image': itemName,
                        'name': itemName,
                        'desc': itemDesc,
                        'price': int.parse(price),
                        'discount': int.parse(discount),
                        'id': 10,
                        'quantity': int.parse(quantity),
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
