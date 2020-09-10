import 'package:flutter/material.dart';
import 'package:grocskart/constants.dart';

class cButton extends StatelessWidget {
  cButton({this.text, this.onPressed, this.color = kcyan});

  final String text;
  final Function onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Material(
        elevation: 5.0,
        color: color,
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

class cRoundIconButton extends StatelessWidget {
  cRoundIconButton({this.icon, this.onpress});

  final IconData icon;
  final Function onpress;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: RawMaterialButton(
        child: Icon(
          icon,
          size: 40,
        ),
        onPressed: onpress,
        elevation: 6,
        constraints: BoxConstraints.tightFor(
          width: 45,
          height: 45,
        ),
        shape: CircleBorder(),
        fillColor: Color(0xFF4C4F5E),
      ),
    );
  }
}
