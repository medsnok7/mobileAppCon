import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../lists/products.dart';
import '../style/colors.dart';

class CartItemSamples extends StatefulWidget {
  const CartItemSamples({super.key});

  @override
  State<CartItemSamples> createState() => _CartItemSamplesState();
}

class _CartItemSamplesState extends State<CartItemSamples> {
  double sum = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < products.length; i++)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            padding: const EdgeInsets.all(10),
            height: 110.h,
            width: 320.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Radio(
                  value: "",
                  groupValue: "",
                  activeColor: AppColors.buttonColor,
                  onChanged: (index) {},
                ),
                Container(
                  height: 70,
                  width: 70,
                  margin: const EdgeInsets.only(right: 15),
                  child: Image.asset(
                    "assets/products/${products[i].imageUrl}",
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        products[i].name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.buttonColor,
                        ),
                      ),
                      Text(
                        "${products[i].unitPrice.toString()} DT",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                  )
                                ]),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (products[i].quantity >= 0 && sum >= 0) {
                                    products[i].quantity += 1;
                                    sum = sum + products[i].unitPrice;
                                  } else {
                                    products[i].quantity = 0;
                                  }
                                });
                              },
                              child: const Icon(
                                CupertinoIcons.plus,
                                size: 18,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              products[i].quantity.toString(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.buttonColor),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                  )
                                ]),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (products[i].quantity >= 0 && sum >= 0) {
                                    products[i].quantity -= 1;
                                    sum = sum - products[i].unitPrice;
                                  } else {
                                    products[i].quantity = 0;
                                  }
                                });
                              },
                              child: const Icon(
                                CupertinoIcons.minus,
                                size: 18,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }
}
