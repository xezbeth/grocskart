import 'package:flutter/material.dart';
import 'package:grocskart/constants.dart';

class cSearchBar extends StatelessWidget {
  cSearchBar(
      {this.hint,
      this.onChanged,
      this.isPassword = false,
      this.keyboardType = TextInputType.text});
  final String hint;
  final Function onChanged;
  final bool isPassword;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
      child: TextField(
        keyboardType: keyboardType,
        obscureText: isPassword,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Color(0xffaeb880)),
          hintText: hint,
          fillColor: Colors.blue,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
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
    );
  }
}
