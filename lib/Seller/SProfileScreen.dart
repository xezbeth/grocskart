import 'package:flutter/material.dart';
import 'package:grocskart/CustomUI/CinputBox.dart';
import 'package:grocskart/CustomUI/Clargetext.dart';
import 'package:grocskart/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:grocskart/CustomUI/Cbutton.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';

class SProfileScreen extends StatefulWidget {
  @override
  _SProfileScreenState createState() => _SProfileScreenState();
}

class _SProfileScreenState extends State<SProfileScreen> {
  final _firestore = FirebaseFirestore.instance;
  String shopName, shopDesc, shopID, ownerName, contactNo;
  File _image;
  Position position;

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

  Future updateLocation(String searchKeyWord) async {
    var data = await _firestore
        .collection('shops')
        .where("name", isEqualTo: searchKeyWord)
        .get();

    for (var attr in data.docs) {
      print("doccccc : ${attr.id}");
      shopID = attr.id;
    }

    updateShop();
  }

  void updateShop() {
    _firestore.collection('shops').doc(shopID).update({
      //'image': shopName,
      //'name': shopName,
      //'desc': shopDesc,
      'latitude': position.latitude,
      'longitude': position.longitude,
    });
  }

  void updateInformation() async {
    if (_image != null) {
      var imageLink = saveImage(_image, shopName);
    }

    var message = await _firestore
        .collection("shops")
        .where("name", isEqualTo: shopName)
        .get();

    if (message == null) {
      if (shopName != null &&
          shopDesc != null &&
          _image != null &&
          position != null &&
          ownerName != null &&
          contactNo != null) {
        _firestore.collection('shops').add({
          'image': shopName,
          'name': shopName,
          'desc': shopDesc,
          'latitude': position.latitude,
          'longitude': position.longitude,
          'ownername': ownerName,
          'contactno': contactNo
        }).whenComplete(() {
          SuccessAlertBox(
              context: context,
              title: "Success",
              messageText: "Created shop.You can now add items to the shop.");
        }).catchError((error) {
          DangerAlertBox(
              context: context,
              title: "Error",
              messageText: "An error occured.Shop not created");
        });
      } else {
        InfoAlertBox(
            context: context,
            title: "Empty Fields",
            infoMessage:
                "Some Fields are empty.Fill all fields to save changes to shop");
      }
    } else {
      _firestore.collection('shops').doc(message.docs[0].id).update({
        // 'image': shopName,
        // 'name': shopName,
        //'desc': shopDesc,
        // 'latitude': position.latitude,
        //'longitude': position.longitude,
        'ownername': ownerName,
        'contactno': contactNo
      }).whenComplete(() {
        SuccessAlertBox(
            context: context, title: "Success", messageText: "Saved changes");
      }).catchError((error) {
        DangerAlertBox(
            context: context,
            title: "Error",
            messageText: "An error occured.Changes not saved");
      });
      print("shop already exists");
      print(shopName);
      //getItem(shopName);
    }
  }

  Future<String> saveImage(File image, String imageName) async {
    img.Image reduceImage = img.decodeImage(image.readAsBytesSync());
    reduceImage = img.copyResize(reduceImage, height: 250);

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    image = File(appDocPath + "thumb.jpg")
      ..writeAsBytesSync(img.encodeJpg(reduceImage));
    StorageReference ref =
        FirebaseStorage.instance.ref().child(shopName).child("$imageName.jpg");
    StorageUploadTask uploadTask = ref.putFile(image);
    var downloadURL = (await uploadTask.onComplete).ref.getDownloadURL();
    return await downloadURL;
  }

  Future getLocation() async {
    position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kyellowSubtle,
      resizeToAvoidBottomPadding: true,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
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
                    hint: "Shop name",
                    onChanged: (value) {
                      shopName = value;
                    },
                  ),
                  QTextField(
                    hint: "short description",
                    onChanged: (value) {
                      shopDesc = value;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Get Location : ",
                        style: TextStyle(
                          fontFamily: "BalsamiqSans",
                        ),
                      ),
                      IconButton(
                        iconSize: 40,
                        icon: Icon(
                          Icons.my_location,
                          color: kcyan,
                          size: 40,
                        ),
                        onPressed: () {
                          getLocation();
                        },
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    color: Colors.red,
                    height: 3,
                  ),
                  Ctextfield(
                    hint: "Name of Owner",
                    onChanged: (value) {
                      ownerName = value;
                    },
                  ),
                  Ctextfield(
                    hint: "Contact No.",
                    onChanged: (value) {
                      contactNo = value;
                    },
                  ),
                  cButton(
                    text: "Save Changes",
                    onPressed: () {
                      updateInformation();
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
