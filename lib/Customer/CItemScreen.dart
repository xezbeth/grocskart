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
  int _currentMax = 0, limit = 14, listViewLimit = 7;

  Future shopFuture;

  String keyword, shopName, shopID;
  bool canFilter = true, canRefresh = true, anyDataLeft = true;
  //int price, discount;
  //double distance;
  List<Widget> listShops = [], listItems = [];
  var im, timestamp;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData(false);
      }
    });
  }

  Widget getSpinner() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 10),
      child: SpinKitWanderingCubes(
        color: kdark,
        size: 50,
      ),
    );
  }

  void _updateData() {
    for (int i = _currentMax; i < (_currentMax + listViewLimit); i++) {
      if (i < listShops.length) {
        listItems.add(listShops[i]);
      }
    }

    print("item length: ${listItems.length}");
    print("shop length: ${listShops.length}");
    print("current max: $_currentMax");

    _currentMax += listViewLimit;

    setState(() {});
  }

  _getMoreData(bool isInit) {
    if (!isInit) {
      print(timestamp);
      if (canRefresh) {
        canRefresh = false;
        _updateData();
        //getShopItem(null, true);
      } else {
        canRefresh = true;
        getShopItem(null, true);
      }
    } else {
      _updateData();
    }
  }

  Future getShopItem(String searchKeyWord, bool moreData) async {
    print(shopName);
    if (moreData) {
    } else {
      listItems = [];
      listShops = [];
      _currentMax = 0;
      timestamp = null;
    }

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

    if (searchKeyWord == null || searchKeyWord == '') {
      message = await firestore
          .collection('shops')
          .doc(shopID)
          .collection('items')
          .orderBy('timestamp', descending: false)
          .where('timestamp', isGreaterThan: timestamp)
          .limit(limit)
          .get();
    } else {
      message = await firestore
          .collection('shops')
          .doc(shopID)
          .collection('items')
          .where("name", isEqualTo: searchKeyWord)
          .where('timestamp', isGreaterThan: timestamp)
          .limit(limit)
          .get();
    }
    if (message == null) {
      anyDataLeft = false;
    }
    for (var attribute in message.docs) {
      timestamp = attribute.data()['timestamp'];
      print(attribute.data()['timestamp']);
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

    if (!moreData) {
      _getMoreData(true);
    } else {
      _updateData();
    }
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
      shopFuture = getShopItem(null, false);
    }

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
                            setState(() {
                              listShops = [];
                              shopFuture = getShopItem(keyword, false);
                              //var d = FieldValue.serverTimestamp();
                              //print();
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
                        return ListView.builder(
                          controller: _scrollController,
                          itemCount: listItems.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == listItems.length) {
                              if (index >= listShops.length) {
                                if (anyDataLeft) {
                                  return getSpinner();
                                } else {
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("No More Items"),
                                    ),
                                  );
                                }
                              } else {
                                return getSpinner();
                              }
                            }
                            return LazyLoadingList(
                              initialSizeOfItems: listViewLimit,
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
