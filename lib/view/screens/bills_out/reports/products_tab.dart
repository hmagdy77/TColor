import 'package:intl/intl.dart';

import '../../../../controllers/bill_out/bill_out_item_controller.dart';
import '../../../../controllers/bill_out/bill_out_reports_controller.dart';
import '../../../../controllers/items/item_controller.dart';
import '../../../../core/print/pdf_bill.dart';
import '../../../../libraries.dart';
import '../../../widgets/bills_out/bill_out_table_item.dart';
import '../../../widgets/login/snackbar.dart';
import '../../../widgets/lottie/empty.dart';

class ProductsTab extends StatelessWidget {
  ProductsTab({super.key});

  final BillOutItemControllerImp billOutItemController =
      Get.find<BillOutItemControllerImp>();
  final BillOutReportControllerImp billOutReportController =
      Get.find<BillOutReportControllerImp>();
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      content: Obx(
        () {
          if (billOutReportController.isLoading.value ||
              billOutItemController.isLoading.value ||
              itemController.isLoading.value) {
            return const MyLottieLoading();
          } else {
            return Column(
              children: [
                //dates
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.calendar_month),
                          onPressed: () {
                            billOutReportController.clearProdCart();
                            billOutItemController.billsOutAllItemsInRange
                                .clear();

                            billOutReportController.setDate(
                              context: context,
                              start: true,
                              end: false,
                            );
                          },
                        ),
                        billOutReportController.startDate.value.isEmpty
                            ? Text(
                                '${AppStrings.startDate}  :  ',
                                style: context.textTheme.displayLarge,
                              )
                            : Text(
                                '${AppStrings.startDate}  :  ${billOutReportController.startDateView.value.day} - ${billOutReportController.startDateView.value.month} - ${billOutReportController.startDateView.value.year}',
                                style: context.textTheme.displayLarge,
                              ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.calendar_month),
                          onPressed: () {
                            billOutReportController.clearProdCart();
                            billOutItemController.billsOutAllItemsInRange
                                .clear();

                            billOutReportController.setDate(
                              context: context,
                              start: false,
                              end: true,
                            );
                          },
                        ),
                        billOutReportController.endDate.value.isEmpty
                            ? Text(
                                '${AppStrings.endDate}  :  ',
                                style: context.textTheme.displayLarge,
                              )
                            : Text(
                                '${AppStrings.endDate}  :  ${billOutReportController.endDateView.value.day} - ${billOutReportController.endDateView.value.month} - ${billOutReportController.endDateView.value.year}',
                                style: context.textTheme.displayLarge,
                              ),
                      ],
                    ),
                    MyButton(
                      text: AppStrings.getData,
                      onPressed: getItems,
                    ),
                    MyButton(
                      // minWidth: AppSizes.w25,
                      text: AppStrings.print,
                      onPressed: () {
                        billOutReportController.items.clear();
                        List items;
                        if (billOutReportController
                                .searchProdTextField.text.isEmpty &&
                            billOutReportController.proudctsSearch.isEmpty) {
                          items = billOutReportController
                              .proudctsUniqeCarts.values
                              .toList();
                        } else {
                          items = billOutReportController.proudctsSearch;
                        }
                        for (int i = 0; i < items.length; i++) {
                          billOutReportController.items.add(
                            [
                              items[i].itemQuant,
                              (double.parse(items[i].itemPriceOut) *
                                      double.parse(items[i].itemMax))
                                  .toStringAsFixed(2),
                              items[i].itemMax,
                              (double.parse(items[i].itemPriceOut) *
                                      double.parse(items[i].itemMin))
                                  .toStringAsFixed(2),
                              items[i].itemMin,
                              items[i].itemPriceOut,
                              items[i].itemNum,
                              items[i].itemName
                            ],
                          );
                        }
                        printBill(
                          billDate: DateFormat.yMMMMEEEEd('ar')
                              .format(DateTime.now()),
                          billLenth: items.length.toString(),
                          billNumber: '0',
                          items: billOutReportController.items,
                          colums: [
                            AppStrings.currentValue,
                            AppStrings.total,
                            AppStrings.back,
                            AppStrings.total,
                            AppStrings.billOut,
                            AppStrings.itemPriceOut,
                            AppStrings.itemNum,
                            AppStrings.itemName,
                          ],
                          label:
                              '${AppStrings.billOutReports} ${AppStrings.products}',
                          kind: '2',
                          total: '0',
                          startDate: billOutReportController.formatter.format(
                            billOutReportController.startDateView.value,
                          ),
                          endDate: billOutReportController.formatter.format(
                            billOutReportController.endDateView.value,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                //for height
                SizedBox(
                  height: AppSizes.h01,
                ),
                MyTextField(
                  hidePassword: false,
                  controller: billOutReportController.searchProdTextField,
                  validate: (val) {},
                  label: AppStrings.search,
                  onChanged: (val) {
                    billOutReportController.search(searchName: val, kind: 2);
                  },
                  onSubmite: (val) {},
                ),
                //for height
                SizedBox(
                  height: AppSizes.h02,
                ),
                BillOutTableItem(
                  isHeader: true,
                  isInDayReport: false,
                ),
                //table
                Expanded(
                  child: Obx(
                    () {
                      if (billOutReportController.isLoading.value) {
                        return const MyLottieLoading();
                      } else {
                        if (billOutReportController.proudctsSearch.isEmpty &&
                            billOutReportController
                                .searchProdTextField.text.isNotEmpty) {
                          return const MyLottieEmpty();
                        } else if (billOutReportController
                                .proudctsSearch.isEmpty &&
                            billOutReportController
                                .searchProdTextField.text.isEmpty) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              List items = billOutReportController
                                  .proudctsUniqeCarts.values
                                  .toList();
                              return BillOutTableItem(
                                isHeader: false,
                                item: items[index],
                                isInDayReport: false,
                              );
                            },
                            itemCount: billOutReportController
                                .proudctsUniqeCarts.length,
                          );
                        } else {
                          return ListView.builder(
                            itemCount:
                                billOutReportController.proudctsSearch.length,
                            itemBuilder: (context, index) {
                              List items =
                                  billOutReportController.proudctsSearch;
                              return BillOutTableItem(
                                isHeader: false,
                                item: items[index],
                                isInDayReport: false,
                              );
                            },
                          );
                        }
                      }
                    },
                  ),
                ),
                // for Height
                SizedBox(
                  height: AppSizes.h05,
                ),
                // //print Button
                // MyButton(
                //   text: AppStrings.print,
                //   onPressed: () {
                //     printReport(
                //       startDate: billInController.startDate.toString(),
                //       endDate: billInController.endDate.toString(),
                //       kind: AppStrings.billInReports,
                //       date:
                //           '${AppStrings.printDate} ${billInController.formatter.format(DateTime.now())}',
                //       fristRow: [
                //         billInController.billsStockTotal.value
                //             .toStringAsFixed(2),
                //         AppStrings.billIn,
                //       ],
                //       secondRow: [
                //         (double.parse(billInController.billsStockTotal
                //                     .toString()) *
                //                 .14)
                //             .toStringAsFixed(2),
                //         AppStrings.pay14,
                //       ],
                //       thirdRow: [
                //         ((double.parse(billInController.billsStockTotal
                //                         .toString()) *
                //                     .14) +
                //                 double.parse(billInController.billsStockTotal
                //                     .toString()))
                //             .toStringAsFixed(2),
                //         AppStrings.totalWithPay,
                //       ],
                //     );
                //   },
                // ),
              ],
            );
          }
        },
      ),
    );
  }

  void getItems() async {
    if (billOutReportController.startDate.isEmpty) {
      MySnackBar.snack(AppStrings.mustChoseStartDate, '');
    } else if (billOutReportController.endDate.isEmpty) {
      MySnackBar.snack(AppStrings.mustChoseEndDate, '');
    } else {
      billOutReportController.clearProdCart();
      billOutItemController.billsOutAllItemsInRange.clear();

      await billOutItemController.getAllItemsinRange(
        start: billOutReportController.startDate.toString(),
        end: billOutReportController.endDate.toString(),
      );

      await billOutReportController.addListToProdCart(
        items: itemController.productsItemsList,
      );
      await billOutReportController.updateProdItems(
        items: billOutItemController.billsOutAllItemsInRange,
      );
    }
  }
}
