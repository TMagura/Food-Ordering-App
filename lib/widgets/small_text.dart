// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// creating reusable code for our TExt

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
   double height;
  //contructor
  SmallText({
    Key? key,
    this.color = const Color(0xFF948D8A),
    required this.text,
    this.size = 12,
     this.height = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      //  maxLines: 1,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: size,
        height: height,
      ),
      );
  }
}
