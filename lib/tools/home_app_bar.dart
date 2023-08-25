// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../home/cart/cart.dart';
import '../style/colors.dart';



class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75.h,
      width: 375.w,
      child: Column(
        children: [
          Container(
            color: AppColors.appBarColor,
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Icon(
                  Icons.sort,
                  size: 30,
                  color: AppColors.buttonColor,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    'APP NAME',
                    style: TextStyle(
                      color: AppColors.buttonColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                  ),
                ),
                Spacer(),
                Badge(
                  backgroundColor: Colors.red,
                  label: Text(
                    "0",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  isLabelVisible: true,
                  child: InkWell(
                    onTap: () {
                      Get.to((const CartView()),
                          transition: Transition.downToUp,
                          duration: Duration(milliseconds: 350));
                    },
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      size: 32,
                      color: AppColors.buttonColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            width: 375.w,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
