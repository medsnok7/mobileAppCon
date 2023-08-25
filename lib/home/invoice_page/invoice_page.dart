import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../lists/invocies.dart';
import '../../style/colors.dart';
import '../explore/explore_tools.dart';
import 'detail_page.dart';

class InvoiceView extends StatefulWidget {
  final ScrollController controller;
  const InvoiceView({Key? key, required this.controller}) : super(key: key);

  @override
  State<InvoiceView> createState() => _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.backgroundColor,
        child: SafeArea(
          child: Scaffold(
              appBar: customAppBar(context),
              body: ListView.builder(
                controller: widget.controller,
                itemCount: invoices.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          invoices[index].id.toString(),
                        ),
                      ),
                    ),
                    title: Text(
                      invoices[index].name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.titleColor),
                    ),
                    subtitle: Text(invoices[index].customer.name),
                    trailing: Text(
                        "${invoices[index].totalCost().toStringAsFixed(2)} DT"),
                    onTap: () {
                      Get.to(() => DetailPage(invoice: invoices[index]),
                          duration: const Duration(milliseconds: 500),
                          transition: Transition.zoom);
                    },
                  );
                },
              )),
        ));
  }
}
