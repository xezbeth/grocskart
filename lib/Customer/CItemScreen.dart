import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocskart/CustomUI/ItemList.dart';
import 'package:grocskart/CustomUI/SearchBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:grocskart/Customer/ItemFocusScreen.dart';
import 'package:grocskart/CustomUI/ShopList.dart';
import 'package:grocskart/constants.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CItemScreen extends StatefulWidget {
  static final String id = "CItemScreen";
  @override
  _CShopScreenState createState() => _CShopScreenState();
}

class _CShopScreenState extends State<CItemScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  ScrollController _scrollController = ScrollController();
  int _currentMax = 0;

  Future shopFuture;

  String keyword, shopName, shopID;
  bool canFilter = true;
  //int price, discount;
  //double distance;
  List<Widget> listShops = [], listItems = [];
  var im;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  _getMoreData() {
    for (int i = _currentMax; i < (_currentMax + 5); i++) {
      if (i < listShops.length) {
        listItems.add(listShops[i]);
      }
    }

    _currentMax += 5;

    setState(() {});
  }

  Future getShopItem(String searchKeyWord) async {
    print(shopName);
    listShops = [];
    listItems = [];
    _currentMax = 0;
    var message;
    if (shopID == null) {
      var data = await firestore
          .collection('shops')
          .where("name", isEqualTo: shopName)
          .get();

      for (var attr in data.docs) {
        print("doccccc : ${attr.id}");
        shopID = attr.id;
      }
    }

    if (searchKeyWord == null) {
      message = await firestore
          .collection('shops')
          .doc(shopID)
          .collection('items')
          .get();
    } else {
      message = await firestore
          .collection('shops')
          .doc(shopID)
          .collection('items')
          .where("name", isEqualTo: searchKeyWord)
          .get();
    }
    for (var attribute in message.docs) {
      //print(attribute.data());
      im = await FirebaseStorage.instance
          .ref()
          .child('$shopName/${attribute.data()["image"]}.jpg')
          .getDownloadURL();

      String image = im;
      String name = attribute.data()["name"];
      listShops.add(
        ItemList(
          image: im,
          name: name,
          discount: attribute.data()['discount'],
          price: attribute.data()['price'],
          onPressed: () {
            Navigator.pushNamed(context, ItemFocusScreen.id, arguments: {
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
    _getMoreData();
    return listShops;
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments != null) {
      shopName = arguments['name'];
    }
    if (canFilter) {
      canFilter = false;
      shopFuture = getShopItem(null);
    }

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
                            setState(() {
                              listShops = [];
                              shopFuture = getShopItem(keyword);
                              //shopFuture = getShopItem(null);
                            });
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
                        return ListView.builder(
                          controller: _scrollController,
                          itemCount: listItems.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == listItems.length) {
                              if (index >= listShops.length) {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("No More Items"),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 30, top: 10),
                                  child: SpinKitWanderingCubes(
                                    color: kdark,
                                    size: 50,
                                  ),
                                );
                              }
                            }
                            return LazyLoadingList(
                              initialSizeOfItems: 5,
                              index: index,
                              child: listItems[index],
                              loadMore: () => print('Loading More'),
                              hasMore: true,
                            );
                          },
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
