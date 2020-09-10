import 'package:flutter/material.dart';
import 'package:grocskart/CustomUI/ItemList.dart';

class CShopScreen extends StatefulWidget {
  @override
  _CShopScreenState createState() => _CShopScreenState();
}

class _CShopScreenState extends State<CShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SafeArea(
          child: ListView(
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
      ),
    );
  }
}
