
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_oders/utils/dimensions.dart';
import 'package:food_oders/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  //these will take care of our long texts to show readMore or ReadLess
  late String firstHalfOfText;
  late String secondHalfOfText;
   
   bool hiddenText = true;

   double textHeight = Dimensions.screenHeight/5.63; // use this height for a start

   @override
  void initState() {
    super.initState();
    if(widget.text.length > textHeight.toInt()){
      firstHalfOfText = widget.text.substring( 0, (textHeight.toInt()) );
      secondHalfOfText = widget.text.substring((textHeight.toInt()+1) , widget.text.length);
    }else{   
      firstHalfOfText = widget.text;
      secondHalfOfText = "";
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Container(     
      child: secondHalfOfText.isEmpty 
      ? SmallText(size:Dimensions.fonts16, text: firstHalfOfText)
      : Column(
        children: [
          // SmallText(text:firstHalfOfText),
          SmallText(size: Dimensions.fonts16, text: hiddenText ? (firstHalfOfText) :(widget.text)),//i will test widget.text
          InkWell(
            onTap: () {
              setState(() {
                hiddenText = !hiddenText; 
              });
            },
            child: Row(
              children: [               
                SmallText(text: hiddenText?"Show more":"Show Less",color: Colors.blueAccent,),
                Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up, color: Colors.blueAccent,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}