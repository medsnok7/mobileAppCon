
import '../db/packages/cart_exports.dart';
import '../style/colors.dart';
import '../style/font_weights.dart';
import '../style/sizes.dart';

class EmptyInvoiceWidget extends StatefulWidget {
  const EmptyInvoiceWidget({
    super.key,
  });

  @override
  State<EmptyInvoiceWidget> createState() => _EmptyInvoiceWidgetState();
}

class _EmptyInvoiceWidgetState extends State<EmptyInvoiceWidget> {
  bool showWidget = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        showWidget = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: (showWidget == true) ? 400.h : 0.h,
          width: (showWidget == true) ? 375.w : 0.w,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/cart/empty-invoice.jpg"),
            ),
          ),
        ),
        SizedBox(
          height: (showWidget == true) ? 100.h : 0.h,
          width: (showWidget == true) ? 375.w : 0.w,
          child: Center(
            child: Text(
              "Empty invoices list",
              style: TextStyle(
                  fontSize: AppSizes.titleSize,
                  color: AppColors.themeColor.withOpacity(0.5),
                  fontWeight: AppFontWeights.midTextFW,
                  wordSpacing: 1.5,
                  fontStyle: FontStyle.italic),
            ),
          ),
        )
      ],
    );
  }
}
