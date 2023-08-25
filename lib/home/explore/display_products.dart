import 'package:mobileappconcorde/db/DBHelper/db_helper.dart';
import 'package:mobileappconcorde/db/packages/cart_exports.dart';
import 'package:mobileappconcorde/db/provider/cart_provider.dart';
import 'package:mobileappconcorde/home/explore/explore_tools.dart';
import 'package:mobileappconcorde/home/product_page/product_page.dart';
import 'package:mobileappconcorde/lists/products.dart';
import 'package:mobileappconcorde/style/colors.dart';
import 'package:mobileappconcorde/style/font_weights.dart';
import 'package:mobileappconcorde/style/sizes.dart';
import 'package:mobileappconcorde/tools/widgets.dart';

class DisplayProducts extends StatefulWidget {
  final ScrollController controller;

  const DisplayProducts({Key? key, required this.controller}) : super(key: key);

  @override
  State<DisplayProducts> createState() => _SearchBarState();
}

class _SearchBarState extends State<DisplayProducts> {
  TextEditingController searchField = TextEditingController();

  var filteredProducts = <Product>[];
  DBHelper dbHelper = DBHelper();

  @override
  void initState() {
    filteredProducts = products;
    super.initState();
  }

  void filterSeachResults(String query) {
    setState(() {
      filteredProducts = products
          .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Column(
      children: [
        Container(
          height: 80.h,
          width: 350.w,
          padding: const EdgeInsets.all(20.0),
          child: TextFormField(
            onChanged: (value) {
              filterSeachResults(value);
            },
            controller: searchField,
            decoration: InputDecoration(
              prefixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: AppColors.iconColor,
                    size: AppSizes.iconSize,
                  )),

              hintText: 'Search',
              hintStyle: TextStyle(
                fontSize: AppSizes.textSize,
                fontWeight: AppFontWeights.textFW,
                color: AppColors.midTextColor,
              ),
              fillColor: Colors.grey[200], // Background color
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none, // No border
              ),
              // Customize other properties as needed
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: const EdgeInsets.only(right: 30.0, left: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              textSurroundedByIcons(
                text: "sort",
                leftIcon: const Icon(Icons.sort,
                    color: AppColors.iconColor, size: 15),
                rightIcon: const Icon(Icons.arrow_downward,
                    color: AppColors.iconColor, size: 15),
              ),
              textSurroundedByIcons(
                text: "filter",
                leftIcon: const Icon(Icons.short_text_outlined,
                    color: AppColors.iconColor, size: 15),
                rightIcon: const Icon(Icons.arrow_downward,
                    color: AppColors.iconColor, size: 15),
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          height: 450.h,
          width: 340.w,
          child: GridView.count(
              controller: widget.controller,
              crossAxisCount: 2,
              shrinkWrap: true,
              children: List.generate(filteredProducts.length, (index) {
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
                              "assets/products/${filteredProducts[index].imageUrl}"),
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
                                    filteredProducts[index].name,
                                    AppColors.titleColor.withOpacity(0.5),
                                    AppFontWeights.textFW,
                                    AppSizes.midTextSize,
                                    TextDecoration.none),
                                appText(
                                    "${filteredProducts[index].unitPrice.toStringAsFixed(2)} DT",
                                    AppColors.textColor,
                                    AppFontWeights.textFW,
                                    AppSizes.midTextSize,
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
        )
      ],
    );
  }
}
