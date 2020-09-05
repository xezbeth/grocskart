import 'package:flutter/material.dart';
import 'package:grocskart/Customer/CloginScreen.dart';
import 'constants.dart';
import 'package:grocskart/CustomUI/Cbutton.dart';
import 'Seller/SloginScreen.dart';

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
              height: 50,
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
              height: 50,
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
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: cButton(
                    text: "BUY",
                    color: Colors.green,
                    onPressed: () {
                      Navigator.pushNamed(context, CloginScreen.id);
                    },
                  ),
                ),
                Expanded(
                  child: cButton(
                    text: "SELL",
                    color: Colors.red,
                    onPressed: () {
                      Navigator.pushNamed(context, SloginScreen.id);
                    },
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
