// ignore_for_file: avoid_print
import 'package:get/get.dart';
import 'package:mobileappconcorde/home/home_view.dart';

import '../../../db/DBHelper/db_helper.dart';
import '../../../db/provider/cart_provider.dart';
import '../../../style/colors.dart';
import '../packages/exports.dart';

class InfoWidget extends StatefulWidget {
  const InfoWidget({
    super.key,
  });

  @override
  State<InfoWidget> createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {
  final DBHelper dbHelper = DBHelper();

  final TextEditingController firstName = TextEditingController();

  final TextEditingController lastName = TextEditingController();

  final TextEditingController address = TextEditingController();

  final TextEditingController phoneNumber = TextEditingController();

  final date = DateTime.now();

  final dueDate = DateTime.now().add(const Duration(days: 7));

  final supplierName = "random name";

  final supplierAddress = "sfax tunis street ";

  final description = "sell of items";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: firstName,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "First Name"),
          ),
          SizedBox(
            height: 15.h,
          ),
          TextField(
            controller: lastName,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "Last Name"),
          ),
          SizedBox(height: 15.h),
          TextField(
            controller: address,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "Street/City"),
          ),
          SizedBox(height: 15.h),
          TextField(
            keyboardType: TextInputType.phone,
            controller: phoneNumber,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Phone Number",
            ),
          ),
          SizedBox(height: 25.h),
          Align(
            alignment: Alignment.bottomCenter,
            child: appButton(
                "Confirm",
                AppColors.buttonColor,
                AppColors.buttonTextColor,
                Colors.transparent,
                300.w,
                50.h,
                15, () async {
              cart.removeAllFromCart();
              cart.initCounter();
              cart.initTotalPrice();

              Get.to(() => const HomeView(),
                  transition: Transition.fade,
                  duration: const Duration(milliseconds: 250));
            }),
          )
        ],
      ),
    );
  }
}
