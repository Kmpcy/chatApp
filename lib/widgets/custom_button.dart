import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
    CustomButton({ required this.text,this.onTap});
  String text;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap:onTap,
      child: Container(
        child: Center(child: Text(text, style: TextStyle(fontSize: 19))),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        height: 48,
        width: double.infinity,
      ),
    );
  }
}
