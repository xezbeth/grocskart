import 'package:flutter/material.dart';
import 'package:grocskart/Customer/CloginScreen.dart';
import 'package:grocskart/constants.dart';
import 'package:grocskart/CustomUI/Cbutton.dart';
import 'package:grocskart/CustomUI/CtextFormField.dart';
import 'package:geolocator/geolocator.dart';
import 'auth.dart';
import 'CNavigationScreen.dart';

class CRegisterScreen extends StatefulWidget {
  static final String id = "CRegisterScreen";
  @override
  _CRegisterScreenState createState() => _CRegisterScreenState();
}

class _CRegisterScreenState extends State<CRegisterScreen> {
  var locationMessage = "";
  var lat;
  var long;
  String name, email, password, phoneNo;

  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    print(lastPosition);
    lat = position.latitude;
    long = position.longitude;
    print("$lat,$long");

    setState(() {
      locationMessage = "\nLatitude: $lat"
          "\nLongitude: $long";
    });
  }

  final _key = GlobalKey<FormState>();

  final AuthenticationService _auth = AuthenticationService();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      //resizeToAvoidBottomInset: true,
      backgroundColor: kprimary,
      body: SafeArea(
        child: Form(
          key: _key,
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
                      image: AssetImage('images/logo_eps.png'),
                      fit: BoxFit.fill),
                ),
              ), //logo
              Card(
                color: Color(0xffeef4cd),
                margin:
                    EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 10),
                elevation: 10,
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
                  child: Column(
                    children: <Widget>[
                      CtextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Name cannot be empty';
                          } else
                            return null;
                        },
                        hint: "Name",
                        onChanged: (value) {
                          name = value;
                        },
                        isPassword: false,
                      ),
                      CtextFormField(
                        controller: _numberController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Phone cannot be empty';
                          } else
                            return null;
                        },
                        hint: "Phone",
                        onChanged: (value) {
                          phoneNo = value;
                        },
                        isPassword: false,
                      ),
                      CtextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Email cannot be empty';
                          } else
                            return null;
                        },
                        hint: "Email",
                        onChanged: (value) {
                          email = value;
                        },
                        isPassword: false,
                      ),
                      CtextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password cannot be empty';
                          } else
                            return null;
                        },
                        hint: "password",
                        onChanged: (value) {
                          password = value;
                        },
                        isPassword: true,
                      ),
                      Text(
                        "Position: $locationMessage",
                        style: TextStyle(color: Colors.white),
                      ),
                      FlatButton(
                        onPressed: () {
                          getCurrentLocation();
                        },
                        color: Colors.white,
                        child: Text('Get Location'),
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
                onPressed: () {
                  if (_key.currentState.validate()) {
                    createUser();
                  }
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
      ),
    );
  }

  void createUser() async {
    print(email);
    dynamic result =
        await _auth.createNewUser(name, phoneNo, email, password, lat, long);
    if (result == null) {
      print('Email is not valid');
    } else {
      print(result.toString());
      _nameController.clear();
      _passwordController.clear();
      _emailController.clear();
      _numberController.clear();

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => CNavigationScreen()));
    }
  }
}
