import 'package:flutter/material.dart';
import 'package:grocskart/Customer/CItemScreen.dart';
import 'package:grocskart/Customer/CNavigationScreen.dart';
import 'package:grocskart/Customer/CRegisterScreen.dart';
import 'package:grocskart/Customer/CShopScreen.dart';
import 'package:grocskart/Customer/CartScreen.dart';
import 'package:grocskart/Customer/ItemFocusScreen.dart';
import 'package:grocskart/Seller/SAddItem.dart';
import 'package:grocskart/WelcomeScreen.dart';
import 'Customer/CloginScreen.dart';
import 'package:grocskart/Seller/SloginScreen.dart';
import 'package:grocskart/Seller/SRegisterScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grocskart/Seller/SNavigationScreen.dart';
import 'package:grocskart/Seller/SEditItem.dart';

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
        SNavigationScreen.id: (context) => SNavigationScreen(),
        ItemFocusScreen.id: (context) => ItemFocusScreen(),
        CShopScreen.id: (context) => CShopScreen(),
        CartScreen.id: (context) => CartScreen(),
        CItemScreen.id: (context) => CItemScreen(),
        SAddItem.id: (context) => SAddItem(),
        SEditItem.id: (context) => SEditItem()
      },
    ),
  );
}
