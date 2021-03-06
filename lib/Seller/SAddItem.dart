import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:grocskart/CustomUI/CinputBox.dart';
import 'package:grocskart/constants.dart';
import 'package:grocskart/CustomUI/Clargetext.dart';
import 'package:grocskart/CustomUI/Cicontextfield.dart';
import 'package:grocskart/CustomUI/Cbutton.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class SAddItem extends StatefulWidget {
  static final String id = "SAddItem";
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
          color: kdarkText,
          fontFamily: "BalsamiqSans",
        ),
      ),
    );
  }
  return menuItems;
}

class _SAddItemState extends State<SAddItem> {
  final _firestore = FirebaseFirestore.instance;

  final String shopName = "shop1";

  String units = "qty", itemName, itemDesc, imageLink;
  String price, quantity, discount;
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
    img.Image reduceImage = img.decodeImage(image.readAsBytesSync());
    reduceImage = img.copyResize(reduceImage, height: 250);

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    image = File(appDocPath + "thumb.jpg")
      ..writeAsBytesSync(img.encodeJpg(reduceImage));
    Reference ref =
        FirebaseStorage.instance.ref().child(shopName).child("$imageName.jpg");
    UploadTask uploadTask = ref.putFile(image);
    var downloadURL = (await uploadTask).ref.getDownloadURL();
    return await downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: klightgreen,
      resizeToAvoidBottomPadding: true,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  _image == null
                      ? Container(
                          color: kgrey,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Image(
                              image: AssetImage("images/logo_eps.png"),
                              height: 250,
                              width: double.infinity,
                            ),
                          ),
                        )
                      : Container(
                          color: kgrey,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Image.file(
                              _image,
                              height: 250,
                              width: double.infinity,
                            ),
                          ),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              color: kcyan,
                              size: 40,
                            ),
                            onPressed: () {
                              getImage(true);
                            },
                          ),
                          Text(
                            "Camera",
                            style: TextStyle(
                              fontFamily: "BalsamiqSans",
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.insert_drive_file,
                              color: kcyan,
                              size: 40,
                            ),
                            onPressed: () {
                              getImage(false);
                            },
                          ),
                          Text(
                            "Gallery",
                            style: TextStyle(
                              fontFamily: "BalsamiqSans",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Ctextfield(
                    hint: "name",
                    onChanged: (value) {
                      itemName = value;
                    },
                  ),
                  QTextField(
                    hint: "short description",
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
                          hint: units,
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
                        icon: Image.asset(
                          "images/inr.png",
                          color: Colors.green,
                        ),
                        hint: "price",
                        onChanged: (value) {
                          price = value;
                        },
                      ),
                      Cicontext(
                        icon: Image.asset(
                          "images/percent.png",
                          color: kdarkText,
                        ),
                        hint: "discount",
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
                      if (_image != null &&
                          shopName != null &&
                          itemName != null &&
                          itemDesc != null &&
                          price != null &&
                          quantity != null) {
                        ConfirmAlertBox(
                            context: context,
                            title: "Add Item",
                            infoMessage: "Add Item to Shop?",
                            onPressedYes: () {
                              print(price);
                              print(quantity);
                              //var imageLink = saveImage(_image.toString());
                              if (discount == null) {
                                discount = 0 as String;
                              }
                              var imageLink = saveImage(_image, itemName);
                              _firestore
                                  .collection('shops/$shopName/items/')
                                  .add({
                                'image': itemName,
                                'name': itemName,
                                'desc': itemDesc,
                                'price': int.parse(price),
                                'discount': int.parse(discount),
                                'id': itemName +
                                    (Random().nextInt(999) + 100).toString(),
                                'quantity': int.parse(quantity),
                                'timestamp': FieldValue.serverTimestamp(),
                              }).whenComplete(() {
                                SuccessAlertBox(
                                    context: context,
                                    title: "Success",
                                    messageText: "Item added to shop");
                              }).catchError((error) {
                                DangerAlertBox(
                                    context: context,
                                    title: "Error",
                                    messageText:
                                        "An error occured.Item not added to cart");
                              });
                              Navigator.pop(context);
                            });
                      } else {
                        InfoAlertBox(
                            context: context,
                            title: "Empty Fields",
                            infoMessage:
                                "Some Fields are empty.Fill all fields to add item to shop");
                      }
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
