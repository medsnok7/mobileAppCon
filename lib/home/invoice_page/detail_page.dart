import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileappconcorde/style/font_weights.dart';
import 'package:mobileappconcorde/style/sizes.dart';
import '../../../lists/invocies.dart';
import '../../style/colors.dart';
import '../pdf/pdf_preview_page.dart';

class DetailPage extends StatelessWidget {
  final Invoice invoice;
  const DetailPage({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: AppColors.buttonColor,
        onPressed: () async {
          Get.to(
            () => PdfPreviewPage(invoice: invoice),
            transition: Transition.zoom,
            duration: const Duration(milliseconds: 500),
          );
        },
        child: const Icon(
          Icons.picture_as_pdf,
          color: AppColors.backgroundColor,
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: AppColors.iconColor,
              size: AppSizes.iconSize,
            )),
        backgroundColor: AppColors.backgroundColor,
        title: Text(invoice.name,
            style: TextStyle(
                color: AppColors.themeColor,
                fontWeight: AppFontWeights.midTextFW,
                fontSize: AppSizes.titleSize)),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              elevation: 0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Customer:',
                          style: TextStyle(
                              fontSize: AppSizes.titleSize,
                              fontWeight: AppFontWeights.titleFW,
                              color: AppColors.textColor),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          invoice.customer.name,
                          style: TextStyle(
                              fontSize: AppSizes.titleSize,
                              fontWeight: AppFontWeights.textFW,
                              color: AppColors.textColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Supplier:',
                          style: TextStyle(
                              fontSize: AppSizes.titleSize,
                              fontWeight: AppFontWeights.titleFW,
                              color: AppColors.textColor),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          invoice.supplier.name,
                          style: TextStyle(
                              fontSize: AppSizes.titleSize,
                              fontWeight: AppFontWeights.textFW,
                              color: AppColors.textColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              child: Column(
                children: [
                  Text(
                    'Items',
                    style: TextStyle(
                        fontSize: AppSizes.titleSize,
                        color: AppColors.titleColor),
                  ),
                  ...invoice.items.map(
                    (e) => ListTile(
                      title: Text(e.name),
                      trailing: Text(
                        e.quantity.toString(),
                      ),
                    ),
                  ),
                  DefaultTextStyle.merge(
                    style:
                        TextStyle(fontSize: 20.sp, color: AppColors.titleColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("Total"),
                        Text(
                          invoice.totalCost().toStringAsFixed(2),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
