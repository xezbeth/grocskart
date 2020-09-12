import 'package:flutter/material.dart';
import 'package:grocskart/CustomUI/CinputBox.dart';
import 'package:grocskart/CustomUI/Clargetext.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:grocskart/CustomUI/Cbutton.dart';

class SProfileScreen extends StatefulWidget {
  @override
  _SProfileScreenState createState() => _SProfileScreenState();
}

class _SProfileScreenState extends State<SProfileScreen> {
  final _firestore = FirebaseFirestore.instance;
  String shopName, shopDesc;
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
    StorageReference ref =
        FirebaseStorage.instance.ref().child(shopName).child("$imageName.jpg");
    StorageUploadTask uploadTask = ref.putFile(image);
    var downloadURL = (await uploadTask.onComplete).ref.getDownloadURL();
    return await downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _image == null
                ? Image(
                    image: AssetImage("images/logo_eps.png"),
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
            cButton(
              text: "Save Changes",
              onPressed: () async {
                var imageLink = saveImage(_image, shopName);

                var message = await _firestore
                    .collection("shops")
                    .where("name", isEqualTo: shopName)
                    .get();

                if (message != null) {
                  _firestore.collection('shops').add({
                    'image': shopName,
                    'name': shopName,
                    'desc': shopDesc,
                  }).whenComplete(() {});
                } else {
                  print("shop already exists");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
