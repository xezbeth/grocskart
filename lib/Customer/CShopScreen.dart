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

  Future shopFuture;

  String image, name;
  int price, discount;
  double distance;
  List<Widget> listshopitem = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shopFuture = getShopItem();
  }

  Future getShopItem() async {
    var im;
    //listshopitem = [];
    final message = await firestore.collection('shop').get();
    for (var attribute in message.docs) {
      im = await FirebaseStorage.instance
          .ref()
          .child('shop1/1.jpg')
          .getDownloadURL();
      listshopitem.add(
        ItemList(
          image: im,
          name: attribute.data()["name"],
          discount: attribute.data()["discount"],
          distance: attribute.data()["distance"].toDouble(),
          price: attribute.data()["price"],
        ),
      );
    }
    return listshopitem;
  }

  @override
  Widget build(BuildContext context) {
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
                          onPressed: () {
                            print(listshopitem.length);
                            shopFuture = getShopItem();
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
                          onPressed: () {}),
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
                          children: listshopitem,
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
