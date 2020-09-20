import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocskart/CustomUI/Cbutton.dart';
import 'package:grocskart/CustomUI/SearchBar.dart';
import 'package:grocskart/Seller/SAddItem.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:grocskart/CustomUI/MenuList.dart';
import 'SEditItem.dart';
import 'package:grocskart/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';

class SItemScreen extends StatefulWidget {
  @override
  _SItemScreenState createState() => _SItemScreenState();
}

class _SItemScreenState extends State<SItemScreen> {
  String keyword, name = "shop1";
  Future menuFuture;
  List<Widget> menuList = [], itemList = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  ScrollController _scrollController = ScrollController();
  var im, timestamp;
  bool canRefresh = true;
  int _currentMax = 0, limit = 14, listViewLimit = 7;

  void _updateData() {
    for (int i = _currentMax; i < (_currentMax + listViewLimit); i++) {
      if (i < menuList.length) {
        itemList.add(menuList[i]);
      }
    }

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
        getMenuItem(null, true);
      }
    } else {
      _updateData();
    }
  }

  Future getMenuItem(String searchKeyWord, bool moreData) async {
    if (moreData) {
    } else {
      menuList = [];
      itemList = [];
      _currentMax = 0;
      timestamp = null;
    }
    var message;

    if (searchKeyWord == null || searchKeyWord == "") {
      message = await firestore
          .collection('shops/$name/items/')
          .orderBy('timestamp', descending: false)
          .where('timestamp', isGreaterThan: timestamp)
          .limit(limit)
          .get();
    } else {
      message = await firestore
          .collection('shops/$name/items/')
          .where("name", isEqualTo: searchKeyWord)
          .where('timestamp', isGreaterThan: timestamp)
          .limit(limit)
          .get();
    }

    for (var attribute in message.docs) {
      // print(attribute.data());
      timestamp = attribute.data()['timestamp'];
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

    if (!moreData) {
      _getMoreData(true);
    } else {
      _updateData();
    }
    return menuList;
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

    menuFuture = getMenuItem(null, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kyellowSubtle,
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
                        menuFuture = getMenuItem(keyword, false);
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
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SpinKitWanderingCubes(
                            color: kdark,
                            size: 60,
                          ),
                          Text(
                            "LOADING",
                            style: TextStyle(
                              fontFamily: "BalsamiqSans",
                            ),
                          ),
                        ],
                      );
                      break;
                    case ConnectionState.done:
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: itemList.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == itemList.length) {
                            if (index >= menuList.length) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "No More Items",
                                    style: TextStyle(
                                      fontFamily: "BalsamiqSans",
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 30, top: 10),
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
                            child: itemList[index],
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
