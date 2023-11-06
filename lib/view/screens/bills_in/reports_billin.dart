import 'package:intl/intl.dart';

import '../../../controllers/bill_in/bill_in_item_controller.dart';
import '../../../controllers/bill_in/bill_in_report_controller.dart';
import '../../../controllers/items/item_controller.dart';
import '../../../core/print/pdf_bill.dart';
import '../../../libraries.dart';
import '../../widgets/bills_in/bill_in_table_item.dart';
import '../../widgets/login/snackbar.dart';
import '../../widgets/lottie/empty.dart';
import '../../widgets/menus/upper_widget.dart';

class ReportsBillInScreen extends StatelessWidget {
  ReportsBillInScreen({super.key});
  final BillInItemControllerImp billInItemController =
      Get.find<BillInItemControllerImp>();
  final BillInReportControllerImp billInReportController =
      Get.find<BillInReportControllerImp>();
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UpperWidget(
            isAdminScreen: false,
            onPressed: () {},
          ),
          Expanded(
            child: MyContainer(
              content: Obx(
                () {
                  if (billInItemController.isLoading.value ||
                      itemController.isLoading.value ||
                      billInReportController.isLoading.value) {
                    return const MyLottieLoading();
                  } else {
                    return Column(
                      children: [
                        const Text(AppStrings.billInReports),
                        SizedBox(
                          height: AppSizes.h02,
                        ),
                        //dates
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.calendar_month),
                                  onPressed: () {
                                    billInReportController.clearComCart();
                                    billInItemController.billsInAllItemsInRange
                                        .clear();

                                    billInReportController.setDate(
                                      context: context,
                                      start: true,
                                      end: false,
                                    );
                                  },
                                ),
                                billInReportController.startDate.value.isEmpty
                                    ? Text(
                                        '${AppStrings.startDate}  :  ',
                                        style: context.textTheme.displayLarge,
                                      )
                                    : Text(
                                        '${AppStrings.startDate}  :  ${billInReportController.startDateView.value.day} - ${billInReportController.startDateView.value.month} - ${billInReportController.startDateView.value.year}',
                                        style: context.textTheme.displayLarge,
                                      ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.calendar_month),
                                  onPressed: () {
                                    billInReportController.clearComCart();
                                    billInItemController.billsInAllItemsInRange
                                        .clear();

                                    billInReportController.setDate(
                                      context: context,
                                      start: false,
                                      end: true,
                                    );
                                  },
                                ),
                                billInReportController.endDate.value.isEmpty
                                    ? Text(
                                        '${AppStrings.endDate}  :  ',
                                        style: context.textTheme.displayLarge,
                                      )
                                    : Text(
                                        '${AppStrings.endDate}  :  ${billInReportController.endDateView.value.day} - ${billInReportController.endDateView.value.month} - ${billInReportController.endDateView.value.year}',
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
                                billInReportController.items.clear();
                                List items;
                                if (billInReportController
                                        .searchComTextField.text.isEmpty &&
                                    billInReportController
                                        .componentsSearch.isEmpty) {
                                  items = billInReportController
                                      .componentsUniqeCarts.values
                                      .toList();
                                } else {
                                  items =
                                      billInReportController.componentsSearch;
                                }
                                for (int i = 0; i < items.length; i++) {
                                  billInReportController.items.add(
                                    [
                                      items[i].itemQuant,
                                      (double.parse(items[i].itemPriceIn) *
                                              double.parse(items[i].itemMax))
                                          .toStringAsFixed(2),
                                      items[i].itemMax,
                                      (double.parse(items[i].itemPriceIn) *
                                              double.parse(items[i].itemMin))
                                          .toStringAsFixed(2),
                                      items[i].itemMin,
                                      items[i].itemPriceIn,
                                      items[i].itemNum,
                                      items[i].itemName
                                    ],
                                  );
                                }
                                printBill(
                                  billDate:
                                      DateFormat.yMEd().format(DateTime.now()),
                                  billLenth: items.length.toString(),
                                  billNumber: '0',
                                  items: billInReportController.items,
                                  colums: [
                                    AppStrings.currentValue,
                                    AppStrings.total,
                                    AppStrings.back,
                                    AppStrings.total,
                                    AppStrings.billIn,
                                    AppStrings.itemPriceIn,
                                    AppStrings.itemNum,
                                    AppStrings.itemName,
                                  ],
                                  label: AppStrings.billInReports,
                                  kind: '2',
                                  total: '0',
                                  startDate:
                                      billInReportController.formatter.format(
                                    billInReportController.startDateView.value,
                                  ),
                                  endDate:
                                      billInReportController.formatter.format(
                                    billInReportController.endDateView.value,
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
                        // search
                        MyTextField(
                          hidePassword: false,
                          controller: billInReportController.searchComTextField,
                          validate: (val) {},
                          label: AppStrings.search,
                          onChanged: (val) {
                            billInReportController.search(searchName: val);
                          },
                          onSubmite: (val) {},
                        ),
                        //for height
                        SizedBox(
                          height: AppSizes.h02,
                        ),
                        // table header
                        BillInTableItem(
                          isHeader: true,
                          isInDay: false,
                        ),
                        //table
                        Expanded(
                          child: Obx(
                            () {
                              if (billInReportController.isLoading.value) {
                                return const MyLottieLoading();
                              } else {
                                if (billInReportController
                                        .componentsSearch.isEmpty &&
                                    billInReportController
                                        .searchComTextField.text.isNotEmpty) {
                                  return const MyLottieEmpty();
                                } else if (billInReportController
                                        .componentsSearch.isEmpty &&
                                    billInReportController
                                        .searchComTextField.text.isEmpty) {
                                  return ListView.builder(
                                    itemBuilder: (context, index) {
                                      List items = billInReportController
                                          .componentsUniqeCarts.values
                                          .toList();
                                      return BillInTableItem(
                                        isHeader: false,
                                        isInDay: false,
                                        item: items[index],
                                      );
                                    },
                                    itemCount: billInReportController
                                        .componentsUniqeCarts.length,
                                  );
                                } else {
                                  return ListView.builder(
                                    itemCount: billInReportController
                                        .componentsSearch.length,
                                    itemBuilder: (context, index) {
                                      List items = billInReportController
                                          .componentsSearch;
                                      return BillInTableItem(
                                        isHeader: false,
                                        isInDay: false,
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
            ),
          ),
        ],
      ),
    );
  }

  void getItems() async {
    if (billInReportController.startDate.isEmpty) {
      MySnackBar.snack(AppStrings.mustChoseStartDate, '');
    } else if (billInReportController.endDate.isEmpty) {
      MySnackBar.snack(AppStrings.mustChoseEndDate, '');
    } else {
      billInReportController.clearComCart();
      billInItemController.billsInAllItemsInRange.clear();
      await billInItemController.getAllItemsinRange(
        start: billInReportController.startDate.toString(),
        end: billInReportController.endDate.toString(),
      );

      await billInReportController.addListToComCart(
        items: itemController.componetsItemsList,
      );
      await billInReportController.updateComItems(
        items: billInItemController.billsInAllItemsInRange,
      );
    }
  }
}
