import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocskart/CustomUI/ItemList.dart';
import 'package:grocskart/CustomUI/SearchBar.dart';

class CShopScreen extends StatefulWidget {
  @override
  _CShopScreenState createState() => _CShopScreenState();
}

class _CShopScreenState extends State<CShopScreen> {
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
                  children: <Widget>[
                    ItemList(),
                    ItemList(),
                    ItemList(),
                    ItemList(),
                    ItemList(),
                    ItemList(),
                    ItemList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
