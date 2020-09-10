import 'package:flutter/material.dart';
import 'CShopScreen.dart';
import 'CartScreen.dart';
import 'CProfileScreen.dart';

class CNavigationScreen extends StatefulWidget {
  static final String id = "CNavigationScreen";
  @override
  _CNavigationScreenState createState() => _CNavigationScreenState();
}

class _CNavigationScreenState extends State<CNavigationScreen> {
  int _currentIndex = 0;

  static List<Widget> _myPages = <Widget>[
    CShopScreen(),
    CartScreen(),
    CProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _myPages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            title: Text("Shop"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text("Cart"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face),
            title: Text("Profile"),
          ),
        ],
      ),
    );
  }
}
