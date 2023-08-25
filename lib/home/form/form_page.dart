import '../../style/colors.dart';
import '../../style/font_weights.dart';
import '../../style/sizes.dart';
import 'packages/exports.dart';

class FormView extends StatelessWidget {
  const FormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: AppColors.iconColor,
              )),
          title: Text(
            "Information",
            style: TextStyle(
                fontSize: AppSizes.titleSize,
                fontWeight: AppFontWeights.titleFW,
                color: AppColors.themeColor),
          ),
        ),
        body: const InfoWidget(),
      )),
    );
  }
}
