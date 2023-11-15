import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../view/widgets/login/snackbar.dart';
import '../constants/app_strings.dart';

const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);

Future<void> printBill({
  required List<List<String>> items,
  required List colums,
  required String billNumber,
  required String billLenth,
  required String billDate,
  required String startDate,
  required String endDate,
  required String label,
  required String kind,
  required String total,
}) async {
  if (items.isEmpty) {
    MySnackBar.snack(AppStrings.emptyList, '');
  } else {
    final Document pdf = Document();

    var arabicFont =
        Font.ttf(await rootBundle.load("assets/fonts/arial/Arial.ttf"));
    // final profileImage = MemoryImage(
    //   (await rootBundle.load('assets/images/logo.jpg')).buffer.asUint8List(),
    // );
    pdf.addPage(
      MultiPage(
        theme: ThemeData.withFont(
          base: arabicFont,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                        label,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  //for height
                  SizedBox(height: 20),
                  kind == '2'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(width: 4),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Center(
                                child: Text(
                                  '${AppStrings.to} : $endDate',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(width: 8),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Center(
                                child: Text(
                                  '${AppStrings.from} : $startDate',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(width: 8),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Center(
                                child: Text(
                                  AppStrings.inRange,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 4),
                          ],
                        )
                      : SizedBox(),
                  //for height
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: 4),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Center(
                          child: Text(
                            '${AppStrings.date} : $billDate',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Center(
                          child: Text(
                            '${AppStrings.numberOfitems} : $billLenth',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      total == '0'
                          ? SizedBox()
                          : Directionality(
                              textDirection: TextDirection.rtl,
                              child: Center(
                                child: Text(
                                  '${AppStrings.total} : $total',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                      kind == '1'
                          ? Directionality(
                              textDirection: TextDirection.rtl,
                              child: Center(
                                child: Text(
                                  '${AppStrings.billNumper} : $billNumber',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                      SizedBox(width: 4),
                    ],
                  ),
                  //for height
                  SizedBox(height: 20),

                  //the table
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
                        data: items,
                      ),
                    ),
                  ),
                  //for height
                  SizedBox(height: 5),
                ],
              ),
            )
          ];
        },
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
