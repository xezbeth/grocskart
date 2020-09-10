import 'package:flutter/material.dart';
import 'package:grocskart/Customer/CNavigationScreen.dart';
import 'package:grocskart/Customer/CRegisterScreen.dart';
import 'package:grocskart/Customer/ItemFocusScreen.dart';
import 'package:grocskart/WelcomeScreen.dart';
import 'Customer/CloginScreen.dart';
import 'package:grocskart/Seller/SloginScreen.dart';
import 'package:grocskart/Seller/SRegisterScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        CloginScreen.id: (context) => CloginScreen(),
        CRegisterScreen.id: (context) => CRegisterScreen(),
        SloginScreen.id: (context) => SloginScreen(),
        SRegisterScreen.id: (context) => SRegisterScreen(),
        CNavigationScreen.id: (context) => CNavigationScreen(),
        ItemFocusScreen.id: (context) => ItemFocusScreen(),
      },
    ),
  );
}
