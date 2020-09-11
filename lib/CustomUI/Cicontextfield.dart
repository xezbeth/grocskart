import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:grocskart/constants.dart';

class Cicontext extends StatelessWidget {
  Cicontext({this.icon, this.hint, this.onChanged});

  final Widget icon;
  final String hint;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: icon,
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: TextField(
                onChanged: onChanged,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Color(0xffaeb880)),
                  hintText: hint,
                  fillColor: Colors.blue,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff393e46), width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kprimary, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
