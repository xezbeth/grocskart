import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocskart/Customer/CRegisterScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocskart/Customer/CNavigationScreen.dart';
import 'package:grocskart/Customer/ForgotScreen.dart';


class CloginScreen extends StatefulWidget {
  static final String id = "FrontPage";
  // This widget is the root of your application.
  @override
  _CloginScreenState createState() => _CloginScreenState();
}

class _CloginScreenState extends State<CloginScreen> {
  String email = "",
      password = "",
      user;
  var _formKey = GlobalKey<FormState>();

  static FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> logIn() async {
    user = (await auth.signInWithEmailAndPassword(
        email: email.trim(), password: password))
        .toString();
    return user;
  }


  @override
  void initState() {
    super.initState();
    Future(() async {
      if (user != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => CNavigationScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000725),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 180,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Log In",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35),
                    ),
                    Text(
                      "Welcome to our store",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.only(bottomRight: Radius.circular(150)),
                color: Color(0xffff2fc3),
              ),
            ),
            Theme(
              data: ThemeData(hintColor: Colors.blue),
              child: Padding(
                padding: EdgeInsets.only(top: 50, right: 20, left: 20),
                child: TextFormField(
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter your email";
                    } else {
                      email = value;
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                        BorderSide(color: Color(0xffff2fc3), width: 1)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                        BorderSide(color: Color(0xffff2fc3), width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                        BorderSide(color: Color(0xffff2fc3), width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                        BorderSide(color: Color(0xffff2fc3), width: 1)),
                  ),
                ),
              ),
            ),
            Theme(
              data: ThemeData(hintColor: Colors.blue),
              child: Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                child: TextFormField(
                  obscureText: true,
                  autocorrect: false,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter your password";
                    } else {
                      password = value;
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                        BorderSide(color: Color(0xffff2fc3), width: 1)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                        BorderSide(color: Color(0xffff2fc3), width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                        BorderSide(color: Color(0xffff2fc3), width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                        BorderSide(color: Color(0xffff2fc3), width: 1)),
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                  right: 20,
                  top: 10,
                ),
                child: Container(
                  width: double.infinity,
                  child: InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>ForgotScreen()));
                    },
                    child: Text(
                      "Forgot Password ?",
                      style: TextStyle(color: Color(0xffff2fc3)),
                      textAlign: TextAlign.right,
                    ),
                  ),
                )
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      user = (await auth.signInWithEmailAndPassword(
                          email: email.trim(), password: password))
                          .toString();
                      //Future<String> check = logIn();
                      if (user != null) {
                        print("checker-----------------------------: $user");
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CNavigationScreen()));
                      }
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Color(0xffff2fc3),
                  child: Text(
                    "Log In",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  padding: EdgeInsets.all(10),
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.blue,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: RaisedButton(
                onPressed: () {},
                color: Colors.white,
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.google,
                      color: Color(0xffff2fc3),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Sign in with google",
                      style: TextStyle(fontSize: 20, color: Color(0xff000725)),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 20, right: 20),
              child: RaisedButton(
                onPressed: () {},
                color: Colors.white,
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.phone,
                      color: Color(0xffff2fc3),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Sign in with Phone",
                      style: TextStyle(fontSize: 20, color: Color(0xff000725)),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Column(
                  children: [
                    Text(
                      "Don't have an account ?",
                      style: TextStyle(color: Colors.white),
                    ),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (BuildContext context) => CRegisterScreen()));
                        },
                        child: Column(
                          children: [
                            Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.blue),
                            ),
                            Container(
                              width: 45,
                              height: 1,
                              color: Colors.blue,
                            )
                          ],
                        ))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
