import 'package:flutter/material.dart';
import 'package:grocskart/Customer/ItemFocusScreen.dart';

class ItemList extends StatelessWidget {
  ItemList(
      {this.image,
      this.name,
      this.distance,
      this.discount,
      this.price,
      this.onPressed});

  final String image, name;
  final int price, discount;
  final double distance;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        elevation: 8,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  image: NetworkImage(image),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Distance : $distance km"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Discount : $discount %"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "₹ $price",
                          style: TextStyle(
                            fontSize: 24,
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
