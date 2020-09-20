import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocskart/CustomUI/ItemList.dart';
import 'package:grocskart/CustomUI/SearchBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:grocskart/Customer/CItemScreen.dart';
import 'package:grocskart/Customer/ItemFocusScreen.dart';
import 'package:grocskart/CustomUI/ShopList.dart';
import 'package:grocskart/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CShopScreen extends StatefulWidget {
  static final String id = "CShopScreen";
  @override
  _CShopScreenState createState() => _CShopScreenState();
}

class _CShopScreenState extends State<CShopScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future shopFuture;

  String keyword;
  //int price, discount;
  //double distance;
  List<Widget> listShops = [];
  var im;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shopFuture = getShopItem(null);
  }

  Future getShopItem(String searchKeyWord) async {
    listShops = [];
    final message = await firestore.collection('shops').get();
    for (var attribute in message.docs) {
      print(attribute.data());
      im = await FirebaseStorage.instance
          .ref()
          .child('${attribute.data()["name"]}/${attribute.data()["image"]}.jpg')
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
          desc: attribute.data()['desc'],
          onPressed: () {
            Navigator.pushNamed(context, CItemScreen.id, arguments: {
              'name': attribute.data()["name"],
            });
          },
        ),
      );
    }
    return listShops;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: kyellowSubtle,
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
                          icon: Icon(
                            Icons.search,
                            color: kcyan,
                          ),
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
                          icon: Icon(
                            Icons.filter_list,
                            color: kprimary,
                          ),
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
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SpinKitWanderingCubes(
                              color: kdark,
                              size: 60,
                            ),
                            Text("LOADING"),
                          ],
                        );
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
