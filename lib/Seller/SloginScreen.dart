import 'package:flutter/material.dart';
import 'package:grocskart/constants.dart';
import 'package:grocskart/CustomUI/Cbutton.dart';
import 'package:grocskart/CustomUI/CinputBox.dart';
import 'SRegisterScreen.dart';

class SloginScreen extends StatefulWidget {
  static final String id = "SloginScreen";
  @override
  _SloginScreenState createState() => _SloginScreenState();
}

class _SloginScreenState extends State<SloginScreen> {
  bool boxValue = false;
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
            Text(
              "Seller Account",
              style: TextStyle(
                fontFamily: "BalsamiqSans",
                fontSize: 22,
                color: kdark,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            Card(
              color: Color(0xffeef4cd),
              margin: EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 10),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: boxValue,
                              onChanged: (newValue) {
                                setState(() {
                                  boxValue = newValue;
                                });
                              },
                            ),
                            Text(
                              "Remember me",
                              style: TextStyle(
                                fontFamily: "BalsamiqSans",
                                color: kdark,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "forgot password?",
                          style: TextStyle(
                            fontFamily: "BalsamiqSans",
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            color: kcyan,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            cButton(
              text: "LOGIN",
              onPressed: () {},
            ),

            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Don't Have an account?",
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
                    Navigator.pushNamed(context, SRegisterScreen.id);
                  },
                  child: Text(
                    "Sign Up",
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
