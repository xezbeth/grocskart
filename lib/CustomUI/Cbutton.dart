import 'package:flutter/material.dart';
import 'package:grocskart/constants.dart';

class cButton extends StatelessWidget {
  cButton({this.text, this.onPressed});

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Material(
        elevation: 5.0,
        color: Color(0xff005249),
        borderRadius: BorderRadius.circular(25),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 350,
          height: 42.0,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontFamily: "BalsamiqSans",
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
