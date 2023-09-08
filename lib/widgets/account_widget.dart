// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:food_oders/utils/dimensions.dart';
import 'package:food_oders/widgets/app_icon.dart';
import 'package:food_oders/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({
    Key? key,
    required this.appIcon,
    required this.bigText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.only(
        left: Dimensions.width20,
        bottom:Dimensions.width10,
        top: Dimensions.width10,
        ),
        child: Row(
          children: [
            appIcon,
            SizedBox(width: Dimensions.width15,),
            bigText,
          ],
        ),
        decoration: BoxDecoration( 
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 1,
              offset: Offset(0, 4), 
              color: Colors.grey.withOpacity(0.3),
            ),
          ]
        ),
    );
  }
}
