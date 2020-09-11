import 'package:flutter/material.dart';
import 'SItemScreen.dart';
import 'SHistoryScreen.dart';
import 'SProfileScreen.dart';

class SNavigationScreen extends StatefulWidget {
  static final String id = "SNavigationScreen";
  @override
  _CNavigationScreenState createState() => _CNavigationScreenState();
}

class _CNavigationScreenState extends State<SNavigationScreen> {
  int _currentIndex = 0;

  static List<Widget> _myPages = <Widget>[
    SItemScreen(),
    SHistoryScreen(),
    SProfileScreen()
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
            icon: Icon(Icons.add_shopping_cart),
            title: Text("Items"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            title: Text("History"),
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
