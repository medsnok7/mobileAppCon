import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../style/colors.dart';
import '../../../style/font_weights.dart';
import '../../../style/sizes.dart';

Row whoWidget(String who, String? him) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            who,
            style: TextStyle(
                fontWeight: AppFontWeights.titleFW,
                fontSize: AppSizes.titleSize,
                color: AppColors.titleColor),
          ),
        ),
        Expanded(
          child: Text(
            him!,
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
                color: AppColors.textColor),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

