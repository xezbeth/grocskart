import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocskart/CustomUI/ItemList.dart';
import 'package:grocskart/CustomUI/SearchBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:grocskart/Customer/ItemFocusScreen.dart';
import 'package:grocskart/CustomUI/ShopList.dart';

class CItemScreen extends StatefulWidget {
  static final String id = "CItemScreen";
  @override
  _CShopScreenState createState() => _CShopScreenState();
}

class _CShopScreenState extends State<CItemScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future shopFuture;

  String keyword, name;
  //int price, discount;
  //double distance;
  List<Widget> listShops = [];
  var im;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future getShopItem(String searchKeyWord) async {
    print(name);
    listShops = [];
    final message = await firestore.collection('shops/$name/items/').get();
    for (var attribute in message.docs) {
      print(attribute.data());
      im = await FirebaseStorage.instance
          .ref()
          .child('shop1/${attribute.data()["image"]}.jpg')
          .getDownloadURL();

      String image = im;
      String name;
      if (searchKeyWord == null) {
        name = attribute.data()["name"];
      } else {
        if (attribute.data()["name"] == searchKeyWord) {
          name = attribute.data()["name"];
        } else {
          continue;
        }
      }
      listShops.add(
        ShopList(
          image: im,
          name: name,
          desc: attribute.data()["desc"],
          onPressed: () {
            Navigator.pushNamed(context, ItemFocusScreen.id, arguments: {
              'image': image,
              'name': attribute.data()["name"],
              'price': attribute.data()["price"],
              'distance': attribute.data()["distance"].toDouble(),
              'discount': attribute.data()["discount"],
              'desc': attribute.data()["desc"],
              'id': attribute.data()["id"],
              'quantity': attribute.data()["quantity"],
            });
          },
        ),
      );
    }
    return listShops;
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments != null) {
      name = arguments['name'];
    }
    shopFuture = getShopItem(null);
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
                            shopFuture = getShopItem(keyword);
                            setState(() {});
                          }),
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
                          onPressed: () {
                            print(listShops.length);
                          }),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: shopFuture,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Text("NONE");
                        break;
                      case ConnectionState.active:
                        return Text("ACTIVE");
                        break;
                      case ConnectionState.waiting:
                        return Text("WAITING");
                        break;
                      case ConnectionState.done:
                        return ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: listShops,
                        );
                        break;
                      default:
                        return Text("DEFAULT");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
