import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/colors.dart';




List<String> images = ["invoice.png", "create.png", "profile.png"];

Widget appBottomNavBar() {
  return Container(
    decoration: const BoxDecoration(
      color: AppColors.navigationBarColor,
      // borderRadius: const BorderRadius.only(
      //   topLeft: Radius.circular(20),
      //   topRight: Radius.circular(20),
      // ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.w),
            image:
                DecorationImage(image: AssetImage("assets/icons/$images[0]")),
          ),
        ),
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.w),
            image:
                DecorationImage(image: AssetImage("assets/icons/$images[1]")),
          ),
        ),
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.w),
            image: DecorationImage(
              image: AssetImage("assets/icons/${images[2]}"),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),
      ],
    ),
  );
}
