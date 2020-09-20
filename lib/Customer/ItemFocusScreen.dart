import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocskart/CustomUI/Cbutton.dart';
import 'package:grocskart/Customer/CNavigationScreen.dart';
import 'package:grocskart/Customer/CShopScreen.dart';
import 'package:grocskart/Customer/CartScreen.dart';
import 'package:grocskart/constants.dart';
import 'package:grocskart/utils/database_helper.dart';
import 'package:grocskart/Customer/CartTracker.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class ItemFocusScreen extends StatefulWidget {
  static final String id = "ItemFocusScreen";

  String image, name, desc, fromWhere, pid;
  int price, discount, quantity;
  double distance;

  @override
  _ItemFocusSceenState createState() => _ItemFocusSceenState();
}

class _ItemFocusSceenState extends State<ItemFocusScreen> {
  int _quantity = 1;
  double _quantityinKG = 0.5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    BackButtonInterceptor.remove(myInterceptor);
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    print("BACK BUTTON!"); // Do some stuff.
    //Navigator.popAndPushNamed(context, CNavigationScreen.id);

    return false;
  }

  @override
  Widget build(BuildContext context) {
    DatabaseHelper databaseHelper = DatabaseHelper();

    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments != null) {
      widget.image = arguments['image'];
      widget.name = arguments['name'];
      widget.desc = arguments['desc'];
      widget.price = arguments['price'];
      //widget.discount = arguments['discount'];
      //widget.distance = arguments['distance'];
      widget.pid = arguments['id'];
      widget.fromWhere = arguments['fromwhere'];
      //widget.quantity = arguments['quantity'];
    }

    return Scaffold(
      backgroundColor: klightgreen,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: kgrey,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Image.network(
                    widget.image,
                    height: 250,
                    width: double.infinity,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "BalsamiqSans",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  "₹ ${widget.price}",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "BalsamiqSans",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  widget.desc,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "BalsamiqSans",
                  ),
                ),
              ),
              Card(
                elevation: 8,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Text("quantity"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              cRoundIconButton(
                                icon: CupertinoIcons.left_chevron,
                                onpress: () {
                                  if (_quantity > 1) {
                                    setState(() {
                                      _quantity--;
                                    });
                                  }
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.all(6),
                                child: Text(
                                  _quantity.toString(),
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              cRoundIconButton(
                                icon: CupertinoIcons.right_chevron,
                                onpress: () {
                                  setState(() {
                                    _quantity++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Text("Kg"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              cRoundIconButton(
                                icon: CupertinoIcons.left_chevron,
                                onpress: () {
                                  if (_quantityinKG >= 1) {
                                    setState(() {
                                      _quantityinKG -= 0.5;
                                    });
                                  }
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.all(6),
                                child: Text(
                                  _quantityinKG.toString(),
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              cRoundIconButton(
                                icon: CupertinoIcons.right_chevron,
                                onpress: () {
                                  setState(() {
                                    _quantityinKG += 0.5;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: cButton(
                      text: "Remove Item",
                      onPressed: () {
                        CartTraker item = CartTraker(
                            id: widget.pid,
                            image: widget.image,
                            name: widget.name,
                            desc: widget.desc,
                            quantity: _quantity,
                            price: widget.price);
                        databaseHelper.initializeDatabase();
                        //databaseHelper.insertToCart(item);
                        print(databaseHelper.deleteFromCart(item));
                      },
                    ),
                  ),
                  Expanded(
                    child: cButton(
                      text: "Add Item",
                      onPressed: () {
                        CartTraker item = CartTraker(
                            id: widget.pid,
                            image: widget.image,
                            name: widget.name,
                            desc: widget.desc,
                            quantity: _quantity,
                            price: widget.price);
                        databaseHelper.initializeDatabase();
                        //databaseHelper.insertToCart(item);
                        print(databaseHelper.insertToCart(item));
                      },
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
}
