import 'package:intl/intl.dart';

import '../../../../controllers/bill_out/bill_out_item_controller.dart';
import '../../../../controllers/bill_shortage/bill_shortage_item_controller.dart';
import '../../../../controllers/factory/bill_factory_item_controller.dart';
import '../../../../controllers/items/item_controller.dart';
import '../../../../controllers/reports/stock_report_controller.dart';
import '../../../../core/print/pdf_bill.dart';
import '../../../../libraries.dart';
import '../../../widgets/login/snackbar.dart';
import '../../../widgets/lottie/empty.dart';
import '../../../widgets/stock_reports/report_table_item.dart';

class ProductsTab extends StatelessWidget {
  ProductsTab({super.key});

  final BillOutItemControllerImp billOutItemController =
      Get.find<BillOutItemControllerImp>();
  final BillFactoryItemControllerImp billFactoryItemController =
      Get.find<BillFactoryItemControllerImp>();
  final StockReportControllerImp stockReportController =
      Get.find<StockReportControllerImp>();
  final BillShortageItemControllerImp billShortageItemController =
      Get.find<BillShortageItemControllerImp>();

  final ItemControllerImp itemController = Get.find<ItemControllerImp>();

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      content: Obx(
        () {
          if (billFactoryItemController.isLoading.value ||
              billOutItemController.isLoading.value) {
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
                            stockReportController.clearProdCart();
                            billOutItemController.billsOutAllItemsInRange
                                .clear();
                            billFactoryItemController.billFactoryAllItemsInRange
                                .clear();
                            stockReportController.setDate(
                              context: context,
                              start: true,
                              end: false,
                            );
                          },
                        ),
                        stockReportController.startDate.value.isEmpty
                            ? Text(
                                '${AppStrings.startDate}  :  ',
                                style: context.textTheme.displayLarge,
                              )
                            : Text(
                                '${AppStrings.startDate}  :  ${stockReportController.startDateView.value.day} - ${stockReportController.startDateView.value.month} - ${stockReportController.startDateView.value.year}',
                                style: context.textTheme.displayLarge,
                              ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.calendar_month),
                          onPressed: () {
                            stockReportController.clearProdCart();
                            billOutItemController.billsOutAllItemsInRange
                                .clear();
                            billFactoryItemController.billFactoryAllItemsInRange
                                .clear();
                            stockReportController.setDate(
                              context: context,
                              start: false,
                              end: true,
                            );
                          },
                        ),
                        stockReportController.endDate.value.isEmpty
                            ? Text(
                                '${AppStrings.endDate}  :  ',
                                style: context.textTheme.displayLarge,
                              )
                            : Text(
                                '${AppStrings.endDate}  :  ${stockReportController.endDateView.value.day} - ${stockReportController.endDateView.value.month} - ${stockReportController.endDateView.value.year}',
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
                        stockReportController.items.clear();
                        List items;
                        if (stockReportController
                                .searchProdTextField.text.isEmpty &&
                            stockReportController.proudctsSearch.isEmpty) {
                          items = stockReportController
                              .proudctsUniqeCarts.values
                              .toList();
                        } else {
                          items = stockReportController.proudctsSearch;
                        }
                        for (int i = 0; i < items.length; i++) {
                          stockReportController.items.add(
                            [
                              items[i].itemQuant,
                              items[i].stockId,
                              items[i].billId,
                              items[i].itemUsed,
                              items[i].itemMax,
                              items[i].itemMin,
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
                          items: stockReportController.items,
                          colums: [
                            AppStrings.currentValue,
                            AppStrings.theMinus,
                            AppStrings.thePlus,
                            AppStrings.theFactory,
                            AppStrings.back,
                            AppStrings.billOut,
                            AppStrings.itemNum,
                            AppStrings.itemName,
                          ],
                          label: AppStrings.products,
                          kind: '2',
                          total: '0',
                          startDate: stockReportController.formatter.format(
                            stockReportController.startDateView.value,
                          ),
                          endDate: stockReportController.formatter.format(
                            stockReportController.endDateView.value,
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
                  controller: stockReportController.searchProdTextField,
                  validate: (val) {},
                  label: AppStrings.search,
                  onChanged: (val) {
                    stockReportController.search(searchName: val, kind: 2);
                  },
                  onSubmite: (val) {},
                ),
                //for height
                SizedBox(
                  height: AppSizes.h02,
                ),
                ReporTableItem(
                  isHeader: true,
                  kind: AppStrings.products,
                ),
                //table
                Expanded(
                  child: Obx(
                    () {
                      if (stockReportController.isLoading.value) {
                        return const MyLottieLoading();
                      } else {
                        if (stockReportController.proudctsSearch.isEmpty &&
                            stockReportController
                                .searchProdTextField.text.isNotEmpty) {
                          return const MyLottieEmpty();
                        } else if (stockReportController
                                .proudctsSearch.isEmpty &&
                            stockReportController
                                .searchProdTextField.text.isEmpty) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              List items = stockReportController
                                  .proudctsUniqeCarts.values
                                  .toList();
                              return ReporTableItem(
                                isHeader: false,
                                kind: AppStrings.products,
                                item: items[index],
                              );
                            },
                            itemCount:
                                stockReportController.proudctsUniqeCarts.length,
                          );
                        } else {
                          return ListView.builder(
                            itemCount:
                                stockReportController.proudctsSearch.length,
                            itemBuilder: (context, index) {
                              List items = stockReportController.proudctsSearch;
                              return ReporTableItem(
                                isHeader: false,
                                kind: AppStrings.products,
                                item: items[index],
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
    if (stockReportController.startDate.isEmpty) {
      MySnackBar.snack(AppStrings.mustChoseStartDate, '');
    } else if (stockReportController.endDate.isEmpty) {
      MySnackBar.snack(AppStrings.mustChoseEndDate, '');
    } else {
      stockReportController.clearProdCart();
      billOutItemController.billsOutAllItemsInRange.clear();
      billFactoryItemController.billFactoryAllItemsInRange.clear();
      billShortageItemController.billShortageAllItemsInRange.clear();

      await billShortageItemController.getAllItemsinRange(
        start: stockReportController.startDate.toString(),
        end: stockReportController.endDate.toString(),
      );
      await billOutItemController.getAllItemsinRange(
        start: stockReportController.startDate.toString(),
        end: stockReportController.endDate.toString(),
      );
      await billFactoryItemController.getAllItemsinRange(
        start: stockReportController.startDate.toString(),
        end: stockReportController.endDate.toString(),
      );
      await stockReportController.addListToProdCart(
        items: itemController.productsItemsList,
      );
      await stockReportController.updateProdItems(
        items: billShortageItemController.billShortageAllItemsInRange,
        kind: AppStrings.billShortage,
      );
      await stockReportController.updateProdItems(
        items: billOutItemController.billsOutAllItemsInRange,
        kind: AppStrings.billOut,
      );
      await stockReportController.updateProdItems(
        items: billFactoryItemController.billFactoryAllItemsInRange,
        kind: AppStrings.theFactory,
      );
    }
  }
}
