// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobileappconcorde/tools/tool_exports.dart';
import 'package:provider/provider.dart';
import '../../../lists/products.dart';
import '../../../tools/widgets.dart';
import '../../db/provider/cart_provider.dart';
import '../cart/cart.dart';
import '../product_page/product_page.dart';

Widget galleryList() {
  String imagePath = "assets/products/";
  return Container(
    height: 230.h,
    width: 370.w,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 10,
          spreadRadius: 1,
          offset: const Offset(10, 10),
        )
      ],
      color: AppColors.backgroundColor,
    ),
    child: ListView.builder(
      physics: const PageScrollPhysics(),
      itemCount: products.length,
      padding: const EdgeInsets.only(
        top: 10,
      ),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              child: Container(
                height: 170.h,
                width: 360.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath + products[index].imageUrl),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 150,
              child: SizedBox(
                width: 70,
                height: 100,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(products.length, (currentIndex) {
                      return Container(
                        width: (index == currentIndex) ? 12 : 7,
                        height: (index == currentIndex) ? 12 : 7,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(1, 1),
                              color: Colors.black,
                              blurRadius: 5,
                            )
                          ],
                          borderRadius: (index == currentIndex)
                              ? BorderRadius.circular(9)
                              : BorderRadius.circular(5),
                          color: (currentIndex == index)
                              ? AppColors.buttonColor
                              : Colors.white,
                        ),
                      );
                    })),
              ),
            ),
          ],
        );
      },
    ),
  );
}

SliverAppBar appSliverAppBar(BuildContext context) {
  return SliverAppBar(
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: AppColors.iconColor,
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      title: Text(
        FirebaseAuth.instance.currentUser!.displayName ?? "Unkown",
        style: TextStyle(
            fontSize: AppSizes.titleSize, fontWeight: AppFontWeights.midTextFW),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Badge(
            label: Consumer<CartProvider>(builder: (context, value, child) {
              return Text(value.getCount().toString());
            }),
            child: IconButton(
                onPressed: () {
                  Get.to(() => const CartView(),
                      duration: const Duration(milliseconds: 250),
                      transition: Transition.zoom);
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  color: AppColors.iconColor,
                )),
          ),
        ),
        IconButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Get.to(() => const SignInView(),
                    duration: const Duration(milliseconds: 250));
              } catch (e) {
                print(e);
              }
            },
            icon: const Icon(
              Icons.logout,
              color: AppColors.iconColor,
            ))
      ]);
}

AppBar customAppBar(BuildContext context) {
  return AppBar(
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: AppColors.iconColor,
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      title: Text(FirebaseAuth.instance.currentUser!.displayName ?? "Unknown"),
      actions: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Badge(
            label: Consumer<CartProvider>(builder: (context, value, child) {
              return Text(value.getCount().toString());
            }),
            child: IconButton(
                onPressed: () {
                  Get.to(() => const CartView(),
                      duration: const Duration(milliseconds: 250),
                      transition: Transition.zoom);
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  color: AppColors.iconColor,
                )),
          ),
        ),
        IconButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Get.to(() => const SignInView(),
                    duration: const Duration(milliseconds: 250));
              } catch (e) {
                print(e);
              }
            },
            icon: const Icon(
              Icons.logout,
              color: AppColors.iconColor,
            ))
      ]);
}

Widget seeMore(String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      appText(text, AppColors.textColor, FontWeight.bold, 15.sp,
          TextDecoration.none),
      appTextButton("see more", AppColors.textButtonColor, FontWeight.bold,
          12.sp, TextDecoration.none),
    ],
  );
}

Widget textSurroundedByIcons({
  required String text,
  double height = 35,
  double width = 80,
  double radius = 10,
  required Icon leftIcon,
  required Icon rightIcon,
}) {
  return Container(
    padding: const EdgeInsets.only(left: 5, right: 5),
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: AppColors.backgroundColor,
      borderRadius: BorderRadius.circular(radius), // Border radius
      border: Border.all(
        color: AppColors.themeColor,
        width: 1, // Border width
      ),
    ),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leftIcon,
          Text(
            text,
            style: const TextStyle(color: AppColors.iconColor),
          ),
          rightIcon,
        ]),
  );
}

Widget appListViewProducts(ScrollController controller, CartProvider cart) {
  return Container(
    padding: const EdgeInsets.only(left: 10, right: 10),
    height: 450.h,
    width: 340.w,
    child: GridView.count(
        controller: controller,
        crossAxisCount: 2,
        shrinkWrap: true,
        children: List.generate(products.length, (index) {
          return Container(
            margin: const EdgeInsets.all(10),
            height: 70.h,
            width: 140.w,
            decoration: BoxDecoration(
              color: AppColors.themeColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: GestureDetector(
              onTap: () {
                Get.to(() => ProductView(index: index, cart: cart),
                    transition: Transition.downToUp,
                    duration: const Duration(milliseconds: 250));
              },
              child: Stack(alignment: Alignment.topCenter, children: [
                Positioned(
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    height: 90.h,
                    width: 110.w,
                    child: Image.asset(
                        "assets/products/${products[index].imageUrl}"),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 80.h,
                    width: 152.w,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)),
                        color: Colors.grey[100]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                              products[index].name,
                              AppColors.titleColor.withOpacity(0.5),
                              FontWeight.w600,
                              12.sp,
                              TextDecoration.none),
                          appText(
                              "${products[index].unitPrice.toStringAsFixed(2)} DT",
                              AppColors.textColor,
                              FontWeight.bold,
                              12.sp,
                              TextDecoration.none),
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            ),
          );
        })),
  );
}
