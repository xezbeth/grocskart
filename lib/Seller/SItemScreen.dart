import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocskart/CustomUI/Cbutton.dart';
import 'package:grocskart/CustomUI/SearchBar.dart';
import 'package:grocskart/Seller/SAddItem.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:grocskart/CustomUI/MenuList.dart';
import 'SEditItem.dart';
import 'package:grocskart/CustomUI/ItemList.dart';

class SItemScreen extends StatefulWidget {
  @override
  _SItemScreenState createState() => _SItemScreenState();
}

class _SItemScreenState extends State<SItemScreen> {
  String keyword, name = "shop1";
  Future menuFuture;
  List<Widget> menuList = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var im;

  Future getMenuItem(String searchKeyWord) async {
    menuList = [];
    var message;


    if (searchKeyWord == null || searchKeyWord == "") {
      message = await firestore.collection('shops/$name/items/').get();
    } else {
      message = await firestore
          .collection('shops/$name/items/')
          .where("name", isEqualTo: searchKeyWord)
          .get();
    }

    for (var attribute in message.docs) {
      print(attribute.data());
      im = await FirebaseStorage.instance
          .ref()
          .child('shop1/${attribute.data()["image"]}.jpg')
          .getDownloadURL();

      String image = im;
      String name = attribute.data()["name"];
      menuList.add(
        MenuList(
          image: im,
          name: name,
          price: attribute.data()['price'].toString(),
          quantity: attribute.data()['quantity'].toString(),
          discount: attribute.data()['discount'].toString(),
          onPressed: () {
            Navigator.pushNamed(context, SEditItem.id, arguments: {
              'image': image,
              'name': attribute.data()["name"],
              'price': attribute.data()["price"],
              //'distance': attribute.data()["distance"].toDouble(),
              'discount': attribute.data()["discount"],
              'desc': attribute.data()["desc"],
              'id': attribute.data()["id"],
              'quantity': attribute.data()["quantity"],
            });
          },
        ),
      );
    }
    return menuList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menuFuture = getMenuItem(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: cSearchBar(
                    hint: "Search",
                    onChanged: (value) {
                      keyword = value;
                    },
                    isPassword: false,
                  ),
                ),
                Expanded(
                  child: IconButton(
                      padding: EdgeInsets.only(right: 5),
                      iconSize: 40,
                      icon: Icon(Icons.search),
                      onPressed: () {
                        print(menuList.length);
                        menuFuture = getMenuItem(keyword);
                        setState(() {});
                      }),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: menuFuture,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text("NONE");
                      break;
                    case ConnectionState.active:
                      return Text("ACTIVE");
                      break;
                    case ConnectionState.waiting:
                      return Text("LOADING");
                      break;
                    case ConnectionState.done:
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: menuList,
                            ),
                          ),
                        ],
                      );
                      break;
                    default:
                      return Text("DEFAULT");
                  }
                },
              ),
            ),
            cButton(
              text: "Add Item",
              onPressed: () {
                Navigator.pushNamed(context, SAddItem.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
