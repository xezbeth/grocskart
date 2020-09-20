import 'package:flutter/material.dart';
import 'package:grocskart/constants.dart';
import 'package:grocskart/CustomUI/Cbutton.dart';
import 'package:grocskart/CustomUI/CinputBox.dart';
import 'SloginScreen.dart';

class SRegisterScreen extends StatefulWidget {
  static final String id = "SRegisterScreen";
  @override
  _SRegisterScreenState createState() => _SRegisterScreenState();
}

class _SRegisterScreenState extends State<SRegisterScreen> {
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
                    "Seller Account",
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
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  cButton(
                    text: "SIGN UP",
                    onPressed: () {
                      Navigator.pushNamed(context, SloginScreen.id);
                    },
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
                          color: kdarkText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SloginScreen.id);
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
          ],
        ),
      ),
    );
  }
}
