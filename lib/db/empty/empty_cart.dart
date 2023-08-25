import '../../home/form/packages/exports.dart';
import '../../style/colors.dart';
import '../../style/font_weights.dart';
import '../../style/sizes.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 400.h,
          width: 375.w,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/cart/empty-cart.png"),
            ),
          ),
        ),
        SizedBox(
          height: 100.h,
          width: 375.w,
          child: Center(
            child: Text(
              "Empty cart list",
              style: TextStyle(
                  fontSize: AppSizes.titleSize,
                  color: AppColors.themeColor,
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
