import 'package:flutter/material.dart';
import 'package:grocskart/constants.dart';

class QTextField extends StatelessWidget {
  QTextField({this.hint, this.onChanged});

  final String hint;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        child: TextField(
          onChanged: onChanged,
          maxLines: 4,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(
            height: 1,
          ),
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Color(0xffaeb880)),
            hintText: hint,
            fillColor: Colors.blue,
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
    );
  }
}
