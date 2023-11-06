import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../view/widgets/login/snackbar.dart';
import '../constants/app_strings.dart';

const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);

Future<void> printPlan({
  required List<List<String>> itemsF,
  required List columsF,
  required List<List<String>> itemsS,
  required List columsS,
  required String label,
  required String billNumber,
  required String billDate,
  required String kind,
  required String total,
}) async {
  if (itemsF.isEmpty || itemsS.isEmpty) {
    MySnackBar.snack(AppStrings.emptyList, '');
  } else {
    final Document pdf = Document();

    var arabicFont =
        Font.ttf(await rootBundle.load("assets/fonts/arial/Arial.ttf"));
    // final profileImage = MemoryImage(
    //   (await rootBundle.load('assets/images/logo.jpg')).buffer.asUint8List(),
    // );
    pdf.addPage(
      Page(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        theme: ThemeData.withFont(
          base: arabicFont,
        ),
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return Center(
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
                // details
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
                          '${AppStrings.products} : ${itemsF.length}',
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
                          '${AppStrings.components} : ${itemsS.length}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    billNumber == '0'
                        ? SizedBox()
                        : Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              child: Text(
                                '${AppStrings.billNumper} : $billNumber',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(width: 4),
                  ],
                ),
                //for height
                SizedBox(height: 20),
                //firist label
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(
                    child: Text(
                      AppStrings.products,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                //for height
                SizedBox(height: 10),
                //firist table
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
                      headers: columsF,
                      cellAlignment: Alignment.center,
                      cellStyle: const TextStyle(
                        fontSize: 14,
                      ),
                      data: itemsF,
                    ),
                  ),
                ),
                //for height
                SizedBox(height: 20),
                //second label
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(
                    child: Text(
                      AppStrings.components,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                //for height
                SizedBox(height: 10),
                //second table
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
                      headers: columsS,
                      cellAlignment: Alignment.center,
                      cellStyle: const TextStyle(
                        fontSize: 14,
                      ),
                      data: itemsS,
                    ),
                  ),
                ),
                //for height
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
