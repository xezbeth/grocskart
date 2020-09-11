import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocskart/CustomUI/CinputBox.dart';
import 'package:grocskart/constants.dart';
import 'package:grocskart/CustomUI/Clargetext.dart';
import 'package:grocskart/CustomUI/Cicontextfield.dart';
import 'package:grocskart/CustomUI/Cbutton.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
        ),
      ),
    );
  }
  return menuItems;
}

class _SAddItemState extends State<SAddItem> {
  String units = "qty",itemName,itemDesc,image;
  int price,quantity,discount;
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

  @override
  Widget build(BuildContext context) {
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
                    hint: "name",
                    onChanged: (value) {},
                  ),
                  QTextField(
                    hint: "short description",
                    onChanged: (value) {},
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
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Cicontext(
                        icon: Image.asset("images/inr.png"),
                        hint: "price",
                        onChanged: (value) {},
                      ),
                      Cicontext(
                        icon: Image.asset(
                          "images/percent.png",
                        ),
                        hint: "discount",
                        onChanged: (value) {},
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
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  cButton(
                    text: "push",
                    onPressed: () {},
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
