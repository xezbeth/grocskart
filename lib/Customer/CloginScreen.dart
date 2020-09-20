import 'package:flutter/material.dart';
import 'package:grocskart/CustomUI/Cbutton.dart';
import 'package:grocskart/Customer/CRegisterScreen.dart';
import 'package:grocskart/constants.dart';
import 'package:grocskart/CustomUI/CinputBox.dart';
import 'CNavigationScreen.dart';

class CloginScreen extends StatefulWidget {
  static final String id = "FrontPage";
  // This widget is the root of your application.
  @override
  _CloginScreenState createState() => _CloginScreenState();
}

class _CloginScreenState extends State<CloginScreen> {
  bool boxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimary,
      resizeToAvoidBottomPadding: true,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Image(
                        image: AssetImage("images/logo_eps.png"),
                        height: 150,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ), //logo
                  Text(
                    "Customer Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "BalsamiqSans",
                      fontSize: 22,
                      color: kdarkText,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Card(
                    color: Color(0xffeef4cd),
                    margin: EdgeInsets.only(
                        left: 30, right: 30, top: 0, bottom: 10),
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 0),
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
                                      color: kcyan,
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
                  SizedBox(
                    height: 40,
                  ),
                  cButton(
                    text: "LOGIN",
                    onPressed: () {
                      Navigator.pushNamed(context, CNavigationScreen.id);
                    },
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
                          color: kdarkText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, CRegisterScreen.id);
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
          ],
        ),
      ),
    );
  }
}
