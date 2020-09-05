import 'package:flutter/material.dart';
import 'package:grocskart/Customer/CloginScreen.dart';
import 'package:grocskart/constants.dart';
import 'package:grocskart/CustomUI/Cbutton.dart';
import 'package:grocskart/CustomUI/CinputBox.dart';

class CRegisterScreen extends StatefulWidget {
  static final String id = "CRegisterScreen";
  @override
  _CRegisterScreenState createState() => _CRegisterScreenState();
}

class _CRegisterScreenState extends State<CRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      //resizeToAvoidBottomInset: true,
      backgroundColor: kprimary,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 100,
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
            Card(
              color: Color(0xffeef4cd),
              margin: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 10),
              elevation: 10,
              child: Container(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
                child: Column(
                  children: <Widget>[
                    Ctextfield(
                      hint: "Email",
                      onChanged: null,
                      isPassword: false,
                    ),
                    Ctextfield(
                      hint: "password",
                      onChanged: null,
                      isPassword: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),

            cButton(
              text: "SIGN UP",
              onPressed: () {},
            ),

            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Already Have an account?",
                  style: TextStyle(
                    fontFamily: "BalsamiqSans",
                    fontSize: 15,
                    color: kdark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, CloginScreen.id);
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      fontFamily: "BalsamiqSans",
                      fontSize: 18,
                      color: kcyan,
                      fontWeight: FontWeight.bold,
                    ),
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
