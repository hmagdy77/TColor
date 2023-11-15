import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);

Future<void> printDayReportOneTable({
  required List colums,
  required List<List<String>> printList,
  required String subLabel,
  required String label,
  required String date,
}) async {
  final Document pdf = Document();

  var arabicFont =
      Font.ttf(await rootBundle.load("assets/fonts/arial/Arial.ttf"));
  // final profileImage = MemoryImage(
  //   (await rootBundle.load('assets/images/logo.jpg')).buffer.asUint8List(),
  // );
  pdf.addPage(
    MultiPage(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      theme: ThemeData.withFont(
        base: arabicFont,
      ),
      crossAxisAlignment: CrossAxisAlignment.center,
      pageFormat: PdfPageFormat.a4,
      build: (Context context) {
        return [
          // //image
          // Container(
          //   height: 70,
          //   width: double.infinity,
          //   child: Image(profileImage, fit: BoxFit.fill),
          // ),
          // //for height
          // SizedBox(height: 20),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: Text(
                date,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          //**********************************Factory*****************************************
          //for height
          SizedBox(height: 20),
          //theFactory
          Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          // for height
          SizedBox(height: 10),
          //components
          Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: Text(
                subLabel,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          //components table
          Container(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TableHelper.fromTextArray(
                border: TableBorder.all(
                  width: 3,
                ),
                headerStyle: const TextStyle(
                  fontSize: 16,
                ),
                headerAlignment: Alignment.center,
                headers: colums,
                cellAlignment: Alignment.center,
                cellStyle: const TextStyle(
                  fontSize: 14,
                ),
                data: printList,
              ),
            ),
          ),
        ];
      },
    ),
  );

  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
}
