// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;
  const NoDataPage({
    Key? key,
    required this.text,
    this.imgPath = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPra0o7tLVfUGjp1xZz13H8l2sGJ1FSbxzaA&usqp=CAU",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.network(imgPath,
        height: MediaQuery.of(context).size.height*0.23,
        width: MediaQuery.of(context).size.width*0.23,
        ),
        SizedBox(height: MediaQuery.of(context).size.height*0.03,),
        Center(
          child: Text(text, 
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height*0.025,
            fontFamily: "IndieFlower",
            fontWeight: FontWeight.bold,
            color: Colors.red[700],
          ),
          ),
        ),
      ],
    );
  }
}
