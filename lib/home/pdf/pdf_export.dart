import 'dart:typed_data';

import 'package:mobileappconcorde/home/pdf/pdf_widgets/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../lists/invocies.dart';

Future<Uint8List> makePdf(Invoice invoice) async {
  final pdf = Document();
  pdf.addPage(MultiPage(
    build: (context) => [
      Widgets.buildHeader(invoice),
      SizedBox(height: 1 * PdfPageFormat.cm),
      Widgets.buildTitle(invoice),
      Widgets.buildInvoice(invoice),
      Divider(),
      Widgets.buildTotal(invoice),
    ],
    footer: (context) => Widgets.buildFooter(invoice),
  ));
  return pdf.save();
}
