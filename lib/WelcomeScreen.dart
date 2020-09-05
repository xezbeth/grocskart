import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:grocskart/CustomUI/Cbutton.dart';

class WelcomeScreen extends StatelessWidget {
  static final String id = "WelcomeScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimary,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
            ),
            Container(
              width: 150.0,
              height: 150.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/logo_eps.png'), fit: BoxFit.fill),
              ),
            ), //logo
            SizedBox(
              height: 100,
            ),
            Text(
              "Hello,Welcome to Grocskart",
              style: TextStyle(
                fontFamily: "BalsamiqSans",
                fontSize: 22,
                color: kdark,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Are you looking to ...",
              style: TextStyle(
                fontFamily: "BalsamiqSans",
                fontSize: 22,
                color: kdark,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: cButton(
                    text: "BUY",
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: cButton(
                    text: "SELL",
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
