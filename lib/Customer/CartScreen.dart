import 'package:flutter/material.dart';
import 'package:grocskart/CustomUI/Cbutton.dart';
import 'package:grocskart/CustomUI/CartList.dart';
import 'package:grocskart/utils/database_helper.dart';
import 'CartTracker.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Widget> cartList = [];
  Future cartFuture;
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartFuture = getCartList();
  }

  Future getCartList() async {
    databaseHelper.initializeDatabase();
    List<Map> result = await databaseHelper.getCartMapList();
    for (var r in result) {
      cartList
          .add(CartList(image: r['image'], name: r['name'], price: r['price']));
    }
  }

  @override
  Widget build(BuildContext context) {
    getCartList();
    return Container(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: FutureBuilder(
                  future: cartFuture,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Text("NONE");
                        break;
                      case ConnectionState.active:
                        return Text("ACTIVE");
                        break;
                      case ConnectionState.waiting:
                        return Text("WAITING");
                        break;
                      case ConnectionState.done:
                        return ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: cartList,
                        );
                        break;
                      default:
                        return Text("DEFAULT");
                    }
                  },
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Details",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Sub Total :\n"
                          "Tax :\n"
                          "Delivery Charges :",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "₹ 600\n"
                          "₹ 8\n"
                          "₹ 30",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "Total : ₹ 638",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: cButton(
                            text: "Checkout",
                            onPressed: () {},
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
      ),
    );
  }
}
