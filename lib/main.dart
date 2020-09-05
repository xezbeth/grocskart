import 'package:flutter/material.dart';
import 'package:grocskart/Customer/CRegisterScreen.dart';
import 'package:grocskart/WelcomeScreen.dart';
import 'Customer/CloginScreen.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        CloginScreen.id: (context) => CloginScreen(),
        CRegisterScreen.id: (context) => CRegisterScreen(),
      },
    ),
  );
}
