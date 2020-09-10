import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocskart/CustomUI/Cbutton.dart';
import 'package:grocskart/utils/database_helper.dart';
import 'package:grocskart/Customer/CartTracker.dart';

class ItemFocusScreen extends StatefulWidget {
  static final String id = "ItemFocusScreen";

  String image, name, desc;
  int price, discount, pid, quantity;
  double distance;

  @override
  _ItemFocusSceenState createState() => _ItemFocusSceenState();
}

class _ItemFocusSceenState extends State<ItemFocusScreen> {
  int _quantity = 1;
  double _quantityinKG = 0.5;
  @override
  Widget build(BuildContext context) {
    DatabaseHelper databaseHelper = DatabaseHelper();

    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments != null) {
      widget.image = arguments['image'];
      widget.name = arguments['name'];
      widget.desc = arguments['desc'];
      widget.price = arguments['price'];
      widget.discount = arguments['discount'];
      widget.distance = arguments['distance'];
      widget.pid = arguments['id'];
      widget.quantity = arguments['quantity'];
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Image.network(
                  widget.image,
                  height: 250,
                  width: double.infinity,
                ),
              ),
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "₹ ${widget.price}",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.desc,
                style: TextStyle(
                  fontSize: 18,
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
              cButton(
                text: "Add to Cart",
                onPressed: () {
                  CartTraker item = CartTraker(
                      id: widget.pid,
                      image: widget.image,
                      name: widget.name,
                      desc: widget.desc,
                      quantity: widget.quantity,
                      price: widget.price);
                  databaseHelper.initializeDatabase();
                  //databaseHelper.insertToCart(item);
                  print(databaseHelper.insertToCart(item));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
