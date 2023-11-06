import 'package:intl/intl.dart';

import '../../../../controllers/factory/bill_factory_item_controller.dart';
import '../../../../controllers/factory/bill_factory_report_controller.dart';
import '../../../../controllers/items/item_controller.dart';
import '../../../../core/print/pdf_bill.dart';
import '../../../../libraries.dart';
import '../../../widgets/bills_factory/bill_factory_table_item.dart';
import '../../../widgets/login/snackbar.dart';
import '../../../widgets/lottie/empty.dart';

class ProductsTab extends StatelessWidget {
  ProductsTab({super.key});

  final BillFactoryItemControllerImp billFactoryItemController =
      Get.find<BillFactoryItemControllerImp>();
  final BillFactoryReportControllerImp billFactoryReportController =
      Get.find<BillFactoryReportControllerImp>();
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      content: Obx(
        () {
          if (billFactoryItemController.isLoading.value ||
              billFactoryReportController.isLoading.value ||
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
                            billFactoryReportController.clearProdCart();
                            billFactoryItemController.billFactoryAllItemsInRange
                                .clear();
                            billFactoryReportController.setDate(
                              context: context,
                              start: true,
                              end: false,
                            );
                          },
                        ),
                        billFactoryReportController.startDate.value.isEmpty
                            ? Text(
                                '${AppStrings.startDate}  :  ',
                                style: context.textTheme.displayLarge,
                              )
                            : Text(
                                '${AppStrings.startDate}  :  ${billFactoryReportController.startDateView.value.day} - ${billFactoryReportController.startDateView.value.month} - ${billFactoryReportController.startDateView.value.year}',
                                style: context.textTheme.displayLarge,
                              ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.calendar_month),
                          onPressed: () {
                            billFactoryReportController.clearProdCart();

                            billFactoryItemController.billFactoryAllItemsInRange
                                .clear();
                            billFactoryReportController.setDate(
                              context: context,
                              start: false,
                              end: true,
                            );
                          },
                        ),
                        billFactoryReportController.endDate.value.isEmpty
                            ? Text(
                                '${AppStrings.endDate}  :  ',
                                style: context.textTheme.displayLarge,
                              )
                            : Text(
                                '${AppStrings.endDate}  :  ${billFactoryReportController.endDateView.value.day} - ${billFactoryReportController.endDateView.value.month} - ${billFactoryReportController.endDateView.value.year}',
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
                      onPressed: printFunc,
                    ),
                  ],
                ),
                //for height
                SizedBox(
                  height: AppSizes.h01,
                ),
                MyTextField(
                  hidePassword: false,
                  controller: billFactoryReportController.searchProdTextField,
                  validate: (val) {},
                  label: AppStrings.search,
                  onChanged: (val) {
                    billFactoryReportController.search(
                        searchName: val, kind: 2);
                  },
                  onSubmite: (val) {},
                ),
                //for height
                SizedBox(
                  height: AppSizes.h02,
                ),
                BillFactoryTableItem(
                  inDayReport: false,
                  isHeader: true,
                  kind: AppStrings.products,
                ),
                //table
                Expanded(
                  child: Obx(
                    () {
                      if (billFactoryReportController.isLoading.value) {
                        return const MyLottieLoading();
                      } else {
                        if (billFactoryReportController
                                .proudctsSearch.isEmpty &&
                            billFactoryReportController
                                .searchProdTextField.text.isNotEmpty) {
                          return const MyLottieEmpty();
                        } else if (billFactoryReportController
                                .proudctsSearch.isEmpty &&
                            billFactoryReportController
                                .searchProdTextField.text.isEmpty) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              List items = billFactoryReportController
                                  .proudctsUniqeCarts.values
                                  .toList();
                              return BillFactoryTableItem(
                                inDayReport: false,
                                isHeader: false,
                                kind: AppStrings.products,
                                item: items[index],
                              );
                            },
                            itemCount: billFactoryReportController
                                .proudctsUniqeCarts.length,
                          );
                        } else {
                          return ListView.builder(
                            itemCount: billFactoryReportController
                                .proudctsSearch.length,
                            itemBuilder: (context, index) {
                              List items =
                                  billFactoryReportController.proudctsSearch;
                              return BillFactoryTableItem(
                                inDayReport: false,
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

  void printFunc() {
    billFactoryReportController.items.clear();
    List items;
    if (billFactoryReportController.searchProdTextField.text.isEmpty &&
        billFactoryReportController.proudctsSearch.isEmpty) {
      items = billFactoryReportController.proudctsUniqeCarts.values.toList();
    } else {
      items = billFactoryReportController.proudctsSearch;
    }
    for (int i = 0; i < items.length; i++) {
      billFactoryReportController.items.add(
        [
          items[i].itemQuant,
          items[i].itemQuantWight,
          items[i].itemUsed,
          items[i].itemNum,
          items[i].itemName
        ],
      );
    }
    printBill(
      billDate: DateFormat.yMEd().format(DateTime.now()),
      billLenth: items.length.toString(),
      billNumber: '0',
      items: billFactoryReportController.items,
      colums: [
        AppStrings.currentValue,
        AppStrings.wight,
        AppStrings.doneFactory,
        AppStrings.itemNum,
        AppStrings.itemName,
      ],
      label: '${AppStrings.billFactoryReports} ${AppStrings.products}',
      kind: '2',
      total: '0',
      startDate: billFactoryReportController.formatter.format(
        billFactoryReportController.startDateView.value,
      ),
      endDate: billFactoryReportController.formatter.format(
        billFactoryReportController.endDateView.value,
      ),
    );
  }

  void getItems() async {
    if (billFactoryReportController.startDate.isEmpty) {
      MySnackBar.snack(AppStrings.mustChoseStartDate, '');
    } else if (billFactoryReportController.endDate.isEmpty) {
      MySnackBar.snack(AppStrings.mustChoseEndDate, '');
    } else {
      billFactoryReportController.clearProdCart();

      billFactoryItemController.billFactoryAllItemsInRange.clear();

      await billFactoryItemController.getAllItemsinRange(
        start: billFactoryReportController.startDate.toString(),
        end: billFactoryReportController.endDate.toString(),
      );
      await billFactoryReportController.addListToProdCart(
        items: itemController.productsItemsList,
      );

      await billFactoryReportController.updateProdItems(
        items: billFactoryItemController.billFactoryAllItemsInRange,
      );
    }
  }
}
