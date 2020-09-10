import 'package:flutter/material.dart';

class CProfileScreen extends StatefulWidget {
  @override
  _CProfileScreenState createState() => _CProfileScreenState();
}

class _CProfileScreenState extends State<CProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Name : "),
                Text("Sharoon Al Ibrahim"),
                IconButton(icon: Icon(Icons.edit), onPressed: () {}),
              ],
            ),
            Text("Name : Sharoon Al Ibrahim"),
            Text("Phone no: 7994204866"),
            Text("Set Location"),
            Text("Change Password"),
          ],
        ),
      ),
    );
  }
}
