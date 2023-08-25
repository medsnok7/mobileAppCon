import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'package:pdf/widgets.dart' as pw;

import '../../../../lists/invocies.dart';
import '../../../../tools/utils.dart';

class Widgets {
  static Widget buildHeader(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSupplierAddress(invoice.supplier),
              Container(
                height: 50,
                width: 50,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: invoice.info.number,
                ),
              ),
            ],
          ),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCustomerAddress(invoice.customer),
              buildInvoiceInfo(invoice),
            ],
          ),
        ],
      );

  static Widget buildCustomerAddress(Customer customer) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSimpleText(title: "Customer: ", value: customer.name),
          buildSimpleText(title: "Address: ", value: customer.address),
        ],
      );

  static Widget buildInvoiceInfo(Invoice invoice) {
    final paymentTerms =
        '${invoice.info.dueDate.difference(invoice.info.date).inDays} days';
    final titles = <String>[
      'Invoice Number:',
      'Invoice Date:',
      'Payment Terms:',
      'Due Date:'
    ];
    final data = <String>[
      invoice.info.number,
      Utils.formatDate(invoice.info.date),
      paymentTerms,
      Utils.formatDate(invoice.info.dueDate),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildSupplierAddress(Supplier supplier) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSimpleText(title: "Supplier: ", value: supplier.name),
          SizedBox(height: 1 * PdfPageFormat.mm),
          buildSimpleText(title: "Address: ", value: supplier.address),
        ],
      );

  static Widget buildTitle(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INVOICE',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text(invoice.info.description),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      'Ref',
      'Product',
      'Date',
      'Quantity',
      '%TVA',
      'Total HT TND',
      'Total TTC TND'
    ];
    final data = invoice.items.map((item) {
      return [
        item.id,
        item.name,
        Utils.formatDate(invoice.info.date),
        '${item.quantity}',
        '${item.vat * 100}',
        '${(item.unitPrice * (1 - item.vat)).toStringAsFixed(2)}',
        '${item.unitPrice.toStringAsFixed(2)}',
      ];
    }).toList();

    return TableHelper.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: const BoxDecoration(color: PdfColors.grey200),
      cellHeight: 30,
      cellStyle: TextStyle(fontSize: 10.sp),
      cellAlignments: {
        0: Alignment.center,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.center,
        4: Alignment.centerLeft,
        5: Alignment.centerLeft,
      },
    );
  }

  static Widget buildTotal(Invoice invoice) {
    final netTotal = invoice.items
        .map((item) => item.unitPrice * item.quantity)
        .reduce((item1, item2) => item1 + item2);
    final total = netTotal;

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Total HT',
                  titleStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  value: Utils.formatPrice(total - total * 0.19),
                  unite: true,
                ),
                Divider(),
                buildText(
                  title: 'TVA(19%)',
                  titleStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  value: Utils.formatPrice(total * 0.19),
                  unite: true,
                ),
                Divider(),
                buildText(
                  title: 'Net total',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: Utils.formatPrice(netTotal),
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(
              title: 'Supplier address', value: invoice.supplier.address),
          SizedBox(height: 1 * PdfPageFormat.mm),
          buildSimpleText(
              title: 'Payment method', value: invoice.supplier.paymentInfo),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
