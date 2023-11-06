import 'package:intl/intl.dart';

import '../../../../controllers/bill_in/bill_in_item_controller.dart';
import '../../../../controllers/bill_out/bill_out_item_controller.dart';
import '../../../../controllers/bill_shortage/bill_shortage_item_controller.dart';
import '../../../../controllers/bill_stock/bill_stock_items_controller.dart';
import '../../../../controllers/items/item_controller.dart';
import '../../../../controllers/reports/stock_report_controller.dart';
import '../../../../core/print/pdf_bill.dart';
import '../../../../libraries.dart';
import '../../../widgets/login/snackbar.dart';
import '../../../widgets/lottie/empty.dart';
import '../../../widgets/stock_reports/report_table_item.dart';

class ComponentsTab extends StatelessWidget {
  ComponentsTab({super.key});

  final BillInItemControllerImp billInItemController =
      Get.find<BillInItemControllerImp>();
  final BillOutItemControllerImp billOutItemController =
      Get.find<BillOutItemControllerImp>();
  final BillStockItemControllerImp billStockItemController =
      Get.find<BillStockItemControllerImp>();
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
          if (billInItemController.isLoading.value ||
              billOutItemController.isLoading.value ||
              billStockItemController.isLoading.value) {
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
                            stockReportController.clearComCart();
                            billInItemController.billsInAllItemsInRange.clear();
                            billOutItemController.billsOutAllItemsInRange
                                .clear();
                            billStockItemController.billsStockAllItemsInRange
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
                            stockReportController.clearComCart();
                            billInItemController.billsInAllItemsInRange.clear();
                            billOutItemController.billsOutAllItemsInRange
                                .clear();
                            billStockItemController.billsStockAllItemsInRange
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
                                .searchComTextField.text.isEmpty &&
                            stockReportController.componentsSearch.isEmpty) {
                          items = stockReportController
                              .componentsUniqeCarts.values
                              .toList();
                        } else {
                          items = stockReportController.componentsSearch;
                        }
                        for (int i = 0; i < items.length; i++) {
                          stockReportController.items.add(
                            [
                              items[i].itemQuant,
                              items[i].stockId,
                              items[i].billId,
                              items[i].itemDone,
                              items[i].itemExchange,
                              items[i].itemMax,
                              items[i].itemMin,
                              items[i].itemPriceOut,
                              items[i].itemPriceIn,
                              items[i].itemNum,
                              items[i].itemName
                            ],
                          );
                        }
                        printBill(
                          billDate: DateFormat.yMEd().format(DateTime.now()),
                          billLenth: items.length.toString(),
                          billNumber: '0',
                          items: stockReportController.items,
                          colums: [
                            AppStrings.currentValue,
                            AppStrings.theMinus,
                            AppStrings.thePlus,
                            AppStrings.back,
                            AppStrings.billStock,
                            AppStrings.back,
                            AppStrings.billOut,
                            AppStrings.back,
                            AppStrings.billIn,
                            AppStrings.itemNum,
                            AppStrings.itemName,
                          ],
                          label: AppStrings.components,
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
                  controller: stockReportController.searchComTextField,
                  validate: (val) {},
                  label: AppStrings.search,
                  onChanged: (val) {
                    stockReportController.search(searchName: val, kind: 1);
                  },
                  onSubmite: (val) {},
                ),
                //for height
                SizedBox(
                  height: AppSizes.h02,
                ),
                ReporTableItem(
                  isHeader: true,
                  kind: AppStrings.components,
                ),
                //table
                Expanded(
                  child: Obx(
                    () {
                      if (stockReportController.isLoading.value) {
                        return const MyLottieLoading();
                      } else {
                        if (stockReportController.componentsSearch.isEmpty &&
                            stockReportController
                                .searchComTextField.text.isNotEmpty) {
                          return const MyLottieEmpty();
                        } else if (stockReportController
                                .componentsSearch.isEmpty &&
                            stockReportController
                                .searchComTextField.text.isEmpty) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              List items = stockReportController
                                  .componentsUniqeCarts.values
                                  .toList();
                              return ReporTableItem(
                                isHeader: false,
                                kind: AppStrings.components,
                                item: items[index],
                              );
                            },
                            itemCount: stockReportController
                                .componentsUniqeCarts.length,
                          );
                        } else {
                          return ListView.builder(
                            itemCount:
                                stockReportController.componentsSearch.length,
                            itemBuilder: (context, index) {
                              List items =
                                  stockReportController.componentsSearch;
                              return ReporTableItem(
                                isHeader: false,
                                kind: AppStrings.components,
                                item: items[index],
                              );
                            },
                          );
                        }
                      }
                    },
                  ),
                ),
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
      stockReportController.clearComCart();
      billInItemController.billsInAllItemsInRange.clear();
      billOutItemController.billsOutAllItemsInRange.clear();
      billStockItemController.billsStockAllItemsInRange.clear();
      billShortageItemController.billShortageAllItemsInRange.clear();
      await billShortageItemController.getAllItemsinRange(
        start: stockReportController.startDate.toString(),
        end: stockReportController.endDate.toString(),
      );
      await billInItemController.getAllItemsinRange(
        start: stockReportController.startDate.toString(),
        end: stockReportController.endDate.toString(),
      );
      await billOutItemController.getAllItemsinRange(
        start: stockReportController.startDate.toString(),
        end: stockReportController.endDate.toString(),
      );
      await billStockItemController.getAllItemsinRange(
        start: stockReportController.startDate.toString(),
        end: stockReportController.endDate.toString(),
      );
      await stockReportController.addListToComCart(
        items: itemController.componetsItemsList,
      );
      await stockReportController.updateComItems(
        items: billShortageItemController.billShortageAllItemsInRange,
        kind: AppStrings.billShortage,
      );
      await stockReportController.updateComItems(
        items: billInItemController.billsInAllItemsInRange,
        kind: AppStrings.billIn,
      );
      await stockReportController.updateComItems(
        items: billOutItemController.billsOutAllItemsInRange,
        kind: AppStrings.billOut,
      );
      await stockReportController.updateComItems(
        items: billStockItemController.billsStockAllItemsInRange,
        kind: AppStrings.billStock,
      );
    }
  }
}
