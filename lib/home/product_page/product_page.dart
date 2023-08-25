// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileappconcorde/lists/products.dart';
import 'package:mobileappconcorde/tools/widgets.dart';
import 'package:provider/provider.dart';

import '../../db/DBHelper/db_helper.dart';
import '../../db/models/cart.dart';
import '../../db/provider/cart_provider.dart';
import '../../lists/colors.dart';
import '../../lists/sizes.dart';
import '../../style/colors.dart';
import '../../style/font_weights.dart';
import '../../style/sizes.dart';

class ProductView extends StatefulWidget {
  final int index;
  final CartProvider cart;
  const ProductView({Key? key, required this.index, required this.cart})
      : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    String imagePath = "assets/products/${products[widget.index].imageUrl}";
    final cart = Provider.of<CartProvider>(context);

    return SafeArea(
        child: Scaffold(
      body: ListView(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: 240.h,
                width: 375.w,
                decoration: BoxDecoration(
                    color: AppColors.buttonColor.withOpacity(0.1),
                    image: DecorationImage(
                        image: AssetImage(imagePath), fit: BoxFit.cover)),
              ),
              Positioned(
                left: 0,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                  color: AppColors.iconColor,
                  iconSize: AppSizes.iconSize,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appText(
                    products[widget.index].name,
                    AppColors.titleColor,
                    AppFontWeights.titleFW,
                    AppSizes.titleSize,
                    TextDecoration.none),
                appText(
                    "${products[widget.index].unitPrice} DT",
                    AppColors.priceColor,
                    AppFontWeights.priceFW,
                    AppSizes.priceSize,
                    TextDecoration.none),
                SizedBox(height: 20.h),
                appText(
                    products[widget.index].description.padLeft(50),
                    AppColors.descriptionColor,
                    AppFontWeights.descriptionFW,
                    AppSizes.descriptionSize,
                    TextDecoration.none),
                SizedBox(height: 20.h),
                appText("Size", AppColors.textColor, AppFontWeights.titleFW,
                    AppSizes.textSize, TextDecoration.none),
                SizedBox(height: 5.h),
                Container(
                  height: 35.h,
                  width: 250.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(sizes.length, (index) {
                      return sizeIcon(
                          products[index].size, widget.index, index);
                    })
                    // for (int i = 0; i < sizes.length; i++)
                    //   ,
                    ,
                  ),
                ),
                SizedBox(height: 20.h),
                appText("Color", AppColors.textColor, AppFontWeights.titleFW,
                    AppSizes.textSize, TextDecoration.none),
                SizedBox(height: 5.h),
                Container(
                  height: 50.h,
                  width: 250.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(colors.length, (index) {
                      return colorIcon(
                          products[index].color, widget.index, index);
                    }),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(child: Container()),
                    GestureDetector(
                      onTap: () async {
                        dbHelper
                            .insertCart(Cart(
                                id: widget.index,
                                productId: products[widget.index].id.toString(),
                                productName: products[widget.index].name,
                                initialPrice:
                                    products[widget.index].unitPrice.toInt(),
                                productPrice:
                                    products[widget.index].unitPrice.toInt(),
                                quantity: products[widget.index].quantity,
                                imageUrl: products[widget.index].imageUrl))
                            .then((value) {
                          cart.addCount();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Product was added to your cart")));
                        }).onError((error, stackTrace) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error.toString())));
                        });
                        Navigator.pop(context);
                      },
                      child: appButtonPrf(
                        "+ Add to cart",
                        AppColors.buttonColor,
                        AppColors.backgroundColor,
                        Colors.transparent,
                        300.w,
                        60.h,
                        AppSizes.buttonTextSize,
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Container sizeIcon(String size, int index, int number) {
    return Container(
      height: 30.h,
      width: 40.w,
      decoration: BoxDecoration(
        color: (sizes[products[index].size] == number)
            ? AppColors.buttonColor
            : Colors.blueAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          size,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: (sizes[products[index].size] == number)
                  ? AppColors.backgroundColor
                  : AppColors.buttonColor),
        ),
      ),
    );
  }
}

Stack colorIcon(String color, int index, int number) {
  return Stack(
    alignment: Alignment.topRight,
    children: [
      Container(
        height: 40.h,
        width: 40.h,
        decoration: BoxDecoration(
          color: colors[color],
          borderRadius: BorderRadius.circular(20.h),
        ),
      ),
      Positioned(
          top: 0,
          right: 0,
          child: Container(
            height: (index == number) ? 15.h : 0,
            width: (index == number) ? 15.h : 0,
            decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(7.5.h)),
            child: Center(
              child: Icon(
                Icons.verified_outlined,
                color: (index == number)
                    ? AppColors.buttonColor
                    : Colors.transparent,
                size: (index == number) ? 15.h : 0,
              ),
            ),
          ))
    ],
  );
}
