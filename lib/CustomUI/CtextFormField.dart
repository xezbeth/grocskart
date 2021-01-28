import 'package:flutter/material.dart';
import 'package:grocskart/constants.dart';
class CtextFormField extends StatelessWidget
{
  CtextFormField(
      {this.hint,
        this.onChanged,
        this.isPassword = false,
        this.keyboardType = TextInputType.text, TextEditingController controller, String Function(String) validator});
  final String hint;
  final Function onChanged;
  final bool isPassword;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: isPassword,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: Color(0xffaeb880),
            fontFamily: "BalsamiqSans",
          ),
          hintText: hint,
          fillColor: Colors.blue,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kcyan, width: 2),
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