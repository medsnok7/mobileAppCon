// ignore_for_file: avoid_print
import 'package:flutter/cupertino.dart';

import '../../../../tools/widgets.dart';
import '../../db/DBHelper/db_helper.dart';
import '../../db/packages/cart_exports.dart';
import '../../db/provider/cart_provider.dart';
import '../../empty/empty_cart.dart';
import '../../style/colors.dart';
import '../../style/font_weights.dart';
import '../../style/sizes.dart';
import '../form/form_page.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  DBHelper dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Container(
      color: AppColors.backgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: AppColors.iconColor,
                  size: AppSizes.iconSize,
                )),
            centerTitle: true,
            title: Text(
              "Your Bag",
              style: TextStyle(
                fontSize: AppSizes.titleSize,
                fontWeight: AppFontWeights.titleFW,
                color: AppColors.themeColor,
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder(
                future: cart.getCartData(),
                builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const EmptyCartWidget(); // Show the empty widget
                  } else {
                    return Column(
                      children: [
                        SizedBox(
                          height: 460.h,
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 140.h,
                                width: 320.w,
                                decoration: const BoxDecoration(
                                  color: AppColors.backgroundColor,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 70,
                                          margin: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Image.asset(
                                            "assets/products/${snapshot.data![index].imageUrl}",
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot
                                                    .data![index].productName
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: AppSizes.titleSize,
                                                  fontWeight:
                                                      AppFontWeights.titleFW,
                                                  color: AppColors.titleColor,
                                                ),
                                              ),
                                              SizedBox(height: 20.h),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .backgroundColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 1,
                                                            blurRadius: 10,
                                                          )
                                                        ]),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        int quantity = snapshot
                                                            .data![index]
                                                            .quantity!;
                                                        int price = snapshot
                                                            .data![index]
                                                            .initialPrice!;

                                                        print("price : $price");
                                                        if (quantity > 0) {
                                                          quantity--;
                                                        }
                                                        int? newPrice =
                                                            price * quantity;
                                                        print(
                                                            "quantity : $quantity");

                                                        print(
                                                            "newPRice : $newPrice");
                                                        if (snapshot
                                                                .data![index]
                                                                .quantity! >
                                                            0) {
                                                          dbHelper
                                                              .updateCartList(Cart(
                                                                  id: snapshot
                                                                      .data![
                                                                          index]
                                                                      .id,
                                                                  productId: snapshot
                                                                      .data![
                                                                          index]
                                                                      .id
                                                                      .toString(),
                                                                  productName: snapshot
                                                                      .data![
                                                                          index]
                                                                      .productName,
                                                                  initialPrice: snapshot
                                                                      .data![
                                                                          index]
                                                                      .initialPrice,
                                                                  productPrice:
                                                                      newPrice,
                                                                  quantity:
                                                                      quantity,
                                                                  imageUrl: snapshot
                                                                      .data![
                                                                          index]
                                                                      .imageUrl))
                                                              .then((value) {
                                                            // if (quantity >= 0) {
                                                            // }
                                                            newPrice = 0;
                                                            quantity = 0;
                                                            cart.removeTotalPrice(
                                                                double.parse(snapshot
                                                                    .data![
                                                                        index]
                                                                    .initialPrice!
                                                                    .toString()));
                                                          }).onError((error,
                                                                  stackTrace) {
                                                            print(error
                                                                .toString());
                                                          });
                                                        }
                                                      },
                                                      child: Icon(
                                                        CupertinoIcons.minus,
                                                        size: AppSizes
                                                            .plusMinusSize,
                                                        color: AppColors
                                                            .themeColor,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    child: Text(
                                                      snapshot
                                                          .data![index].quantity
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: AppSizes
                                                              .numberSize,
                                                          fontWeight:
                                                              AppFontWeights
                                                                  .numberFW,
                                                          color: AppColors
                                                              .numberColor),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .backgroundColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 1,
                                                            blurRadius: 10,
                                                          )
                                                        ]),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        int quantity = snapshot
                                                            .data![index]
                                                            .quantity!;
                                                        int price = snapshot
                                                            .data![index]
                                                            .initialPrice!;

                                                        print("price : $price");
                                                        if (quantity >= 0) {
                                                          quantity++;
                                                        }
                                                        int? newPrice =
                                                            price * quantity;
                                                        print(
                                                            "quantity : $quantity");

                                                        print(
                                                            "newPRice : $newPrice");

                                                        dbHelper
                                                            .updateCartList(Cart(
                                                                id: snapshot
                                                                    .data![
                                                                        index]
                                                                    .id,
                                                                productId: snapshot
                                                                    .data![
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                                productName: snapshot
                                                                    .data![
                                                                        index]
                                                                    .productName,
                                                                initialPrice: snapshot
                                                                    .data![
                                                                        index]
                                                                    .initialPrice,
                                                                productPrice:
                                                                    newPrice,
                                                                quantity:
                                                                    quantity,
                                                                imageUrl: snapshot
                                                                    .data![
                                                                        index]
                                                                    .imageUrl))
                                                            .then((value) {
                                                          newPrice = 0;
                                                          quantity = 0;
                                                          cart.addTotalPrice(
                                                              double.parse(snapshot
                                                                  .data![index]
                                                                  .initialPrice!
                                                                  .toString()));
                                                        }).onError((error,
                                                                stackTrace) {
                                                          print(
                                                              error.toString());
                                                        });
                                                      },
                                                      child: Icon(
                                                        CupertinoIcons.plus,
                                                        size: AppSizes
                                                            .plusMinusSize,
                                                        color:
                                                            AppColors.iconColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  if (cart.counter > 0) {
                                                    cart.removeItemFromCart(
                                                        snapshot
                                                            .data![index].id!);

                                                    cart.removeTotalPrice(
                                                        double.parse((snapshot
                                                                    .data![
                                                                        index]
                                                                    .initialPrice! *
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .quantity!)
                                                            .toString()));
                                                    cart.removeCount();
                                                  }
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Item was removed successfully from your cart')));
                                                },
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: AppColors.deleteColor,
                                                ),
                                              ),
                                              SizedBox(height: 10.h),
                                              Text(
                                                "${snapshot.data![index].initialPrice!} TND",
                                                style: TextStyle(
                                                  fontSize: AppSizes.priceSize,
                                                  fontWeight:
                                                      AppFontWeights.priceFW,
                                                  color: AppColors.priceColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Container(
                                      height: 2.h,
                                      width: 330.w,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.5)),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Consumer<CartProvider>(
                            builder: (context, value, child) {
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    appText(
                                        "TOTAL : ",
                                        AppColors.titleColor,
                                        AppFontWeights.titleFW,
                                        AppSizes.titleSize,
                                        TextDecoration.none),
                                    Text(
                                      "${value.getTotalprice().toStringAsFixed(2)} TND ",
                                      style: TextStyle(
                                        color: AppColors.textColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppSizes.priceSize,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => const FormView(),
                                        duration:
                                            const Duration(milliseconds: 250),
                                        transition: Transition.downToUp);
                                  },
                                  child: appButtonPrf(
                                      "Proceed",
                                      AppColors.buttonColor,
                                      AppColors.buttonTextColor,
                                      Colors.transparent,
                                      300.w,
                                      50.h,
                                      15),
                                )
                              ],
                            ),
                          );
                        })
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
