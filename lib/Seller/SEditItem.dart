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
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';

class SEditItem extends StatefulWidget {
  static final String id = "SEditItem";

  var im;

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
            fontSize: 24, fontFamily: "BalsamiqSans", color: kdarkText),
      ),
    );
  }
  return menuItems;
}

class _SAddItemState extends State<SEditItem> {
  final _firestore = FirebaseFirestore.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final String shopName = "shop1";

  String units = "qty", itemName, itemDesc, imageLink;
  String price, quantity, discount, id, image, itemID;
  File _image;
  var data;

  Future<String> getItem(String searchKeyWord) async {
    data = await firestore
        .collection('shops/$shopName/items/')
        .where("id", isEqualTo: searchKeyWord)
        .get();

    for (var attr in data.docs) {
      print("doccccc : ${attr.id}");
      itemID = attr.id;
    }
  }

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
    if (image != null) {
      img.Image reduceImage = img.decodeImage(image.readAsBytesSync());
      reduceImage = img.copyResize(reduceImage, height: 250);

      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;

      image = File(appDocPath + "thumb.jpg")
        ..writeAsBytesSync(img.encodeJpg(reduceImage));

      StorageReference ref = FirebaseStorage.instance
          .ref()
          .child(shopName)
          .child("$imageName.jpg");
      StorageUploadTask uploadTask = ref.putFile(image);
      var downloadURL = (await uploadTask.onComplete).ref.getDownloadURL();
      return await downloadURL;
    } else {
      return null;
    }
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

      getItem(id);
    }

    return Scaffold(
      backgroundColor: klightgreen,
      resizeToAvoidBottomPadding: true,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              image: NetworkImage(image),
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
                        icon: Image.asset(
                          "images/inr.png",
                          color: Colors.green,
                        ),
                        hint: price,
                        onChanged: (value) {
                          price = value;
                        },
                      ),
                      Cicontext(
                        icon: Image.asset(
                          "images/percent.png",
                          color: kdarkText,
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
                            DeleteAlertBox(
                              context: context,
                              title: "Delete item",
                              infoMessage:
                                  "Are you sure you want to delete this item?",
                              onPressedYes: () {
                                if (itemID != null) {
                                  _firestore
                                      .collection('shops/$shopName/items/')
                                      .doc(itemID)
                                      .delete()
                                      .whenComplete(() {
                                    SuccessAlertBox(
                                        context: context,
                                        title: "Success",
                                        messageText: "Item deleted from shop");
                                  }).catchError((error) {
                                    DangerAlertBox(
                                        context: context,
                                        title: "Error",
                                        messageText:
                                            "An error occured.changes not saved");
                                  });

                                  FirebaseStorage.instance
                                      .ref()
                                      .child(shopName)
                                      .child("$itemName.jpg")
                                      .delete();
                                }
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  cButton(
                    text: "push",
                    onPressed: () {
                      //print(data.docs);
                      ConfirmAlertBox(
                        context: context,
                        title: "Edit Item",
                        infoMessage: "Save changes to item?",
                        onPressedYes: () {
                          print(quantity);
                          //var imageLink = saveImage(_image.toString());
                          var imageLink = saveImage(_image, itemName);
                          print("document id : $itemID");
                          _firestore
                              .collection('shops/$shopName/items/')
                              .doc(itemID)
                              .update({
                            'image': itemName,
                            'name': itemName,
                            'desc': itemDesc,
                            'price': int.parse(price),
                            'discount': int.parse(discount),
                            'id': id,
                            'quantity': int.parse(quantity),
                            'timestamp': FieldValue.serverTimestamp(),
                          }).whenComplete(() {
                            SuccessAlertBox(
                                context: context,
                                title: "Success",
                                messageText: "Saved changes");
                          }).catchError((error) {
                            DangerAlertBox(
                                context: context,
                                title: "Error",
                                messageText:
                                    "An error occured.changes not saved");
                          });
                          Navigator.pop(context);
                        },
                      );

                      // _firestore.collection('shops/$shopName/items/').add({

                      //});
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
