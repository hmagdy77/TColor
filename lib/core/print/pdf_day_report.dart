import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../constants/app_strings.dart';

const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);

Future<void> printDayReport({
  required List columsStock,
  required List<List<String>> stockCom,
  required List columsFactory,
  required List<List<String>> factoryCom,
  required List<List<String>> factoryProd,
  required List columsBillIn,
  required List<List<String>> billInCom,
  required List columsBilOut,
  required List<List<String>> bilOutCom,
  required List<List<String>> bilOutProd,
  required List columsBillShortage,
  required List<List<String>> shortageCom,
  required List<List<String>> shortageProd,
  required String label,
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
      pageFormat: PdfPageFormat.a4,
      crossAxisAlignment: CrossAxisAlignment.center,
      footer: (context) {
        return Column(
          children: [
            Divider(thickness: 1),
            Row(
              children: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(
                    child: Text(
                      '${AppStrings.hossamName} : ${AppStrings.hossaPhone}',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Center(
                    child: Text(
                      '${context.pageNumber}',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(
                    child: Text(
                      AppStrings.programName,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
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
                label,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          //for height
          SizedBox(height: 20),
          //  stockComponents
          Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: Text(
                AppStrings.stockComponents,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          //for height
          SizedBox(height: 10),
          //stock table
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
                headers: columsStock,
                cellAlignment: Alignment.center,
                cellStyle: const TextStyle(
                  fontSize: 14,
                ),
                data: stockCom,
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
                AppStrings.theFactory,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          //for height
          SizedBox(height: 10),
          //products
          Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: Text(
                AppStrings.products,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          //products table
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
                headers: columsFactory,
                cellAlignment: Alignment.center,
                cellStyle: const TextStyle(
                  fontSize: 14,
                ),
                data: factoryProd,
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
                AppStrings.components,
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
                headers: columsFactory,
                cellAlignment: Alignment.center,
                cellStyle: const TextStyle(
                  fontSize: 14,
                ),
                data: factoryCom,
              ),
            ),
          ),
          //**********************************Bill in*****************************************
          //for height
          SizedBox(height: 20),
          //Bill in
          Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: Text(
                AppStrings.billIn,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          //for height
          SizedBox(height: 10),
          //Bill in table
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
                headers: columsBillIn,
                cellAlignment: Alignment.center,
                cellStyle: const TextStyle(
                  fontSize: 14,
                ),
                data: billInCom,
              ),
            ),
          ),
          //**********************************Bill Out*****************************************
          //for height
          SizedBox(height: 20),
          //theFactory
          Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: Text(
                AppStrings.billOut,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          //for height
          SizedBox(height: 10),
          //products
          Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: Text(
                AppStrings.products,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          //products table
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
                headers: columsBilOut,
                cellAlignment: Alignment.center,
                cellStyle: const TextStyle(
                  fontSize: 14,
                ),
                data: bilOutProd,
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
                AppStrings.components,
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
                headers: columsBilOut,
                cellAlignment: Alignment.center,
                cellStyle: const TextStyle(
                  fontSize: 14,
                ),
                data: bilOutProd,
              ),
            ),
          ),
          //**********************************Bill Shortage*****************************************
          //for height
          SizedBox(height: 20),
          //theFactory
          Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: Text(
                AppStrings.billShortage,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          //for height
          SizedBox(height: 10),
          //products
          Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: Text(
                AppStrings.products,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          //products table
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
                headers: columsBillShortage,
                cellAlignment: Alignment.center,
                cellStyle: const TextStyle(
                  fontSize: 14,
                ),
                data: shortageProd,
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
                AppStrings.components,
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
                headers: columsBillShortage,
                cellAlignment: Alignment.center,
                cellStyle: const TextStyle(
                  fontSize: 14,
                ),
                data: shortageCom,
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
