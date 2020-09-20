import 'package:flutter/material.dart';
import 'package:grocskart/CustomUI/Cbutton.dart';
import 'package:grocskart/CustomUI/CartList.dart';
import 'package:grocskart/utils/database_helper.dart';
import 'CartTracker.dart';
import 'package:grocskart/Customer/ItemFocusScreen.dart';
import 'package:grocskart/constants.dart';

class CartScreen extends StatefulWidget {
  static final String id = "CartScreen";
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Widget> cartList = [];
  Future cartFuture;
  DatabaseHelper databaseHelper = DatabaseHelper();

  int subTotal = 0,
      tax = 15,
      deliveryCharges = 50,
      totalPrice = 0,
      itemCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartFuture = getCartList();
  }

  Future getCartList() async {
    cartList = [];
    databaseHelper.initializeDatabase();
    List<Map> result = await databaseHelper.getCartMapList();
    itemCount = await databaseHelper.getCount();
    for (var r in result) {
      subTotal += (r['price'] * r['quantity']);
      cartList.add(CartList(
        image: r['image'],
        name: r['name'],
        price: r['price'],
        quantity: r['quantity'],
        onPressed: () {
          Navigator.pushNamed(context, ItemFocusScreen.id, arguments: {
            'image': r['image'],
            'name': r["name"],
            'price': r["price"],
            //'distance': r["distance"].toDouble(),
            //'discount': r["discount"],
            'desc': r["desc"],
            'id': r["id"],
            'quantity': r["quantity"],
            'fromwhere': CartScreen.id
          });
        },
      ));
    }
    totalPrice = subTotal + tax + deliveryCharges;
    print(totalPrice);

    return cartList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: kyellowSubtle,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              "Shopping Cart",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kdarkText,
                fontFamily: "BalsamiqSans",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          shadowColor: kdarkText,
          backgroundColor: kprimary,
        ),
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
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
                  return Text("LOADING");
                  break;
                case ConnectionState.done:
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: cartList,
                        ),
                      ),
                      Container(
                        height: 2,
                        color: kdarkText,
                      ),
                      Container(
                        color: kprimary,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Details",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "BalsamiqSans",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "Items :\n"
                                  "Sub Total :\n"
                                  "Tax :\n"
                                  "Delivery Charges :",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "BalsamiqSans",
                                  ),
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "$itemCount\n"
                                  "₹ $subTotal\n"
                                  "₹ $tax\n"
                                  "₹ $deliveryCharges",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "BalsamiqSans",
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Container(
                              height: 2,
                              color: kdarkText,
                            ),
                            Container(
                              color: kprimary,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Total : ₹ $totalPrice",
                                          style: TextStyle(
                                            fontFamily: "BalsamiqSans",
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                  break;
                default:
                  return Text("DEFAULT");
              }
            },
          ),
        ),
      ),
    );
  }
}
