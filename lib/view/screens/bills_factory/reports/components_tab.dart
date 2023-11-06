import 'package:intl/intl.dart';

import '../../../../controllers/factory/bill_factory_item_controller.dart';
import '../../../../controllers/factory/bill_factory_report_controller.dart';
import '../../../../controllers/items/item_controller.dart';
import '../../../../core/print/pdf_bill.dart';
import '../../../../libraries.dart';
import '../../../widgets/bills_factory/bill_factory_table_item.dart';
import '../../../widgets/login/snackbar.dart';
import '../../../widgets/lottie/empty.dart';

class ComponentsTab extends StatelessWidget {
  ComponentsTab({super.key});

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
          if (billFactoryReportController.isLoading.value ||
              billFactoryItemController.isLoading.value ||
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
                            billFactoryReportController.clearComCart();
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
                            billFactoryReportController.clearComCart();
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
                  controller: billFactoryReportController.searchComTextField,
                  validate: (val) {},
                  label: AppStrings.search,
                  onChanged: (val) {
                    billFactoryReportController.search(
                        searchName: val, kind: 1);
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
                  kind: AppStrings.components,
                ),
                //table
                Expanded(
                  child: Obx(
                    () {
                      if (billFactoryReportController.isLoading.value) {
                        return const MyLottieLoading();
                      } else {
                        if (billFactoryReportController
                                .componentsSearch.isEmpty &&
                            billFactoryReportController
                                .searchComTextField.text.isNotEmpty) {
                          return const MyLottieEmpty();
                        } else if (billFactoryReportController
                                .componentsSearch.isEmpty &&
                            billFactoryReportController
                                .searchComTextField.text.isEmpty) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              List items = billFactoryReportController
                                  .componentsUniqeCarts.values
                                  .toList();
                              return BillFactoryTableItem(
                                inDayReport: false,
                                isHeader: false,
                                kind: AppStrings.components,
                                item: items[index],
                              );
                            },
                            itemCount: billFactoryReportController
                                .componentsUniqeCarts.length,
                          );
                        } else {
                          return ListView.builder(
                            itemCount: billFactoryReportController
                                .componentsSearch.length,
                            itemBuilder: (context, index) {
                              List items =
                                  billFactoryReportController.componentsSearch;
                              return BillFactoryTableItem(
                                inDayReport: false,
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

                // for Height
                SizedBox(
                  height: AppSizes.h05,
                ),
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
    if (billFactoryReportController.searchComTextField.text.isEmpty &&
        billFactoryReportController.componentsSearch.isEmpty) {
      items = billFactoryReportController.componentsUniqeCarts.values.toList();
    } else {
      items = billFactoryReportController.componentsSearch;
    }
    for (int i = 0; i < items.length; i++) {
      billFactoryReportController.items.add(
        [
          items[i].itemQuant,
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
        AppStrings.usedFactory,
        AppStrings.itemNum,
        AppStrings.itemName,
      ],
      label: '${AppStrings.billFactoryReports} ${AppStrings.components}',
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
      billFactoryReportController.clearComCart();
      billFactoryItemController.billFactoryAllItemsInRange.clear();
      await billFactoryItemController.getAllItemsinRange(
        start: billFactoryReportController.startDate.toString(),
        end: billFactoryReportController.endDate.toString(),
      );
      await billFactoryReportController.addListToComCart(
        items: itemController.componetsItemsList,
      );
      await billFactoryReportController.updateComItems(
        items: billFactoryItemController.billFactoryAllItemsInRange,
      );
    }
  }
}
