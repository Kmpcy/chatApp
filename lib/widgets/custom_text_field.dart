import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  CustomFormTextField({this.obscure=false, this.hintText, this.onChanged});
  String? hintText;
  Function(String)? onChanged;
  bool? obscure;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: obscure!,
        validator: (data) {
          if (data!.isEmpty) {
            return "Field is required";
          }
        },
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white, fontSize: 18),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlueAccent),
          ),
        ),
        // تحديد الارتفاع هنا
        style: TextStyle(height: 1, color: Colors.white));
  }
}
