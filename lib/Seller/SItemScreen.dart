import 'package:flutter/material.dart';
import 'package:grocskart/CustomUI/Cbutton.dart';
import 'package:grocskart/CustomUI/SearchBar.dart';
import 'package:grocskart/Seller/SAddItem.dart';

class SItemScreen extends StatefulWidget {
  @override
  _SItemScreenState createState() => _SItemScreenState();
}

class _SItemScreenState extends State<SItemScreen> {
  String keyword;

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
                        //shopFuture = getShopItem(keyword);
                        setState(() {});
                      }),
                ),
              ],
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
