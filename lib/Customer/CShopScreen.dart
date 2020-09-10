import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocskart/CustomUI/ItemList.dart';
import 'package:grocskart/CustomUI/SearchBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CShopScreen extends StatefulWidget {
  @override
  _CShopScreenState createState() => _CShopScreenState();
}

class _CShopScreenState extends State<CShopScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String image, name;
  int price, discount;
  double distance;
  List<Widget> listshopitem = [
    ItemList(
      image: "grocskart-e99b7.appspot.com/1.jpg",
      name: "as",
      discount: 4,
      distance: 3,
      price: 500,
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getShopItem();
  }

  void getShopItem() async {
    final message = await firestore.collection('shop').get();
    for (var attribute in message.docs) {
      listshopitem.add(
        ItemList(
          image:
              await FirebaseStorage.instance.ref().child('1').getDownloadURL(),
          name: attribute.data()["name"],
          discount: attribute.data()["discount"],
          distance: attribute.data()["distance"],
          price: attribute.data()["price"],
        ),
      );
      //print(m.data());
    }
    print(listshopitem);
  }

  @override
  Widget build(BuildContext context) {
    getShopItem();
    return Container(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: cSearchBar(
                        hint: "Search",
                        onChanged: null,
                        isPassword: false,
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                          padding: EdgeInsets.only(right: 5),
                          iconSize: 40,
                          icon: Icon(Icons.search),
                          onPressed: () {}),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: IconButton(
                          padding: EdgeInsets.only(right: 5),
                          iconSize: 40,
                          icon: Icon(Icons.filter_list),
                          onPressed: () {}),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: listshopitem,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
