import 'package:flutter/material.dart';
import 'package:mobileappconcorde/home/pdf/pdf_export.dart';
import 'package:printing/printing.dart';

import '../../../lists/invocies.dart';
import '../../style/colors.dart';
import '../../style/font_weights.dart';
import '../../style/sizes.dart';

class PdfPreviewPage extends StatelessWidget {
  final Invoice invoice;
  const PdfPreviewPage({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              size: AppSizes.iconSize,
              color: AppColors.iconColor,
            )),
        title: Text(
          'PDF Preview',
          style: TextStyle(
              color: AppColors.iconColor,
              fontWeight: AppFontWeights.midTextFW,
              fontSize: AppSizes.titleSize),
        ),
      ),
      body: PdfPreview(
        build: (context) => makePdf(invoice),
      ),
    );
  }
}
