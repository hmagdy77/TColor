import '../../../controllers/bill_in/bill_in_item_controller.dart';
import '../../../controllers/bill_out/bill_out_item_controller.dart';
import '../../../controllers/bill_shortage/bill_shortage_item_controller.dart';
import '../../../controllers/bill_stock/bill_stock_items_controller.dart';
import '../../../controllers/factory/bill_factory_item_controller.dart';
import '../../../controllers/reports/day_report_controller.dart';
import '../../../core/print/pdf_day_report.dart';
import '../../../core/print/pdf_day_report_one_table.dart';
import '../../../libraries.dart';
import '../../widgets/bills_factory/bill_factory_table_item.dart';
import '../../widgets/bills_in/bill_in_table_item.dart';
import '../../widgets/bills_out/bill_out_table_item.dart';
import '../../widgets/bills_shortage/bill_shortage_table_item.dart';
import '../../widgets/drawer/expandable_item.dart';
import '../../widgets/lottie/empty.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/stock_reports/report_stock_day_item.dart';

class DayReportsScreen extends StatelessWidget {
  DayReportsScreen({super.key});

  final DayReportsControllerImp dayReportsController =
      Get.find<DayReportsControllerImp>();

  final BillInItemControllerImp billInItemController =
      Get.find<BillInItemControllerImp>();
  final BillOutItemControllerImp billOutItemController =
      Get.find<BillOutItemControllerImp>();
  final BillFactoryItemControllerImp billFactoryController =
      Get.find<BillFactoryItemControllerImp>();
  final BillStockItemControllerImp billStockController =
      Get.find<BillStockItemControllerImp>();
  final BillShortageItemControllerImp billShortageItemController =
      Get.find<BillShortageItemControllerImp>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (dayReportsController.isLoading.value ||
              billInItemController.isLoading.value) {
            return const Center(
              child: MyLottieLoading(),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UpperWidget(isAdminScreen: false, onPressed: () {}),
                Expanded(
                  child: MyContainer(
                    content: ListView(
                      shrinkWrap: false,
                      children: [
                        //plan id and date and numberOfitems
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '${AppStrings.date} : ${dayReportsController.currentDateView.value}',
                              style: context.textTheme.displayLarge,
                            ),
                            MyButton(
                              text: AppStrings.date,
                              onPressed: () async {
                                clearItems();
                                dayReportsController.setDate(context: context);
                              },
                            ),
                            MyButton(
                              text: AppStrings.reports,
                              onPressed: () async {
                                getAllItems();
                              },
                            ),
                            MyButton(
                              text: AppStrings.print,
                              onPressed: printFunction,
                            ),
                          ],
                        ),
                        //for height
                        SizedBox(
                          height: AppSizes.h04,
                        ),
                        // Bill Stock Items
                        MyExpandapleItem(
                          label: AppStrings.stockComponents,
                          child: BillStockItems(
                              dayReportsController: dayReportsController),
                        ),
                        // bills Facory
                        MyExpandapleItem(
                          label: AppStrings.theFactory,
                          child: Column(
                            children: [
                              Text(
                                AppStrings.components,
                                style: context.textTheme.displayLarge,
                              ),
                              SizedBox(height: AppSizes.h02),
                              BillsFactoryComponents(
                                  dayReportsController: dayReportsController),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: AppSizes.h02,
                                ),
                                child: Divider(
                                  thickness: 2,
                                  color: context.theme.primaryColorLight,
                                ),
                              ),
                              Text(
                                AppStrings.products,
                                style: context.textTheme.displayLarge,
                              ),
                              SizedBox(height: AppSizes.h02),
                              BillsFactoryProudcts(
                                  dayReportsController: dayReportsController),
                            ],
                          ),
                        ),
                        // Bill In
                        MyExpandapleItem(
                          label: AppStrings.billIn,
                          child: BillInItems(
                              dayReportsController: dayReportsController),
                        ),
                        // Bill Out Items
                        MyExpandapleItem(
                          label: AppStrings.billOut,
                          child: Column(
                            children: [
                              Text(
                                AppStrings.products,
                                style: context.textTheme.displayLarge,
                              ),
                              SizedBox(
                                height: AppSizes.h02,
                              ),
                              BillsOutProudcts(
                                dayReportsController: dayReportsController,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: AppSizes.h02,
                                ),
                                child: Divider(
                                  thickness: 2,
                                  color: context.theme.primaryColorLight,
                                ),
                              ),
                              Text(
                                AppStrings.components,
                                style: context.textTheme.displayLarge,
                              ),
                              SizedBox(
                                height: AppSizes.h02,
                              ),
                              BillsOutComponents(
                                  dayReportsController: dayReportsController)
                            ],
                          ),
                        ),
                        // Bill Shortage
                        MyExpandapleItem(
                          label: AppStrings.theShortage,
                          child: Column(
                            children: [
                              Text(AppStrings.products,
                                  style: context.textTheme.displayLarge),
                              SizedBox(
                                height: AppSizes.h02,
                              ),
                              BillsShortageProudcts(
                                dayReportsController: dayReportsController,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: AppSizes.h02,
                                ),
                                child: Divider(
                                  thickness: 2,
                                  color: context.theme.primaryColorLight,
                                ),
                              ),
                              Text(
                                AppStrings.components,
                                style: context.textTheme.displayLarge,
                              ),
                              SizedBox(
                                height: AppSizes.h02,
                              ),
                              BillsShortageComponents(
                                  dayReportsController: dayReportsController),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<void> getAllItems() async {
    clearItems();
    // Bills In Items
    await billInItemController.getAllItemsInDay(
      date: dayReportsController.currentDate.value,
    );
    await dayReportsController.updateBillsInItems(
      items: billInItemController.billInItemsInDay,
    );
    // Bills Stock Items
    await billStockController.getAllItemsInDay(
      date: dayReportsController.currentDate.value,
    );
    await dayReportsController.updateBillsStockItems(
      items: billStockController.billStockItemsInDay,
    );
    // Bills Out
    await billOutItemController.getAllItemsInDay(
      date: dayReportsController.currentDate.value,
    );
    await dayReportsController.updateBillsOutItems(
        items: billOutItemController.billOutItemsInDay);
    // Bills Factory
    await billFactoryController.getAllItemsInDay(
      date: dayReportsController.currentDate.value,
    );
    await dayReportsController.updateBillsFactoryItems(
        items: billFactoryController.billFactoryItemsInDay);
    // Bills Shortage
    await billShortageItemController.getAllItemsInDay(
      date: dayReportsController.currentDate.value,
    );
    await dayReportsController.updateBillsShortageItems(
        items: billShortageItemController.billShortageItemsInDay);
  }

  clearItems() {
    dayReportsController.clearAllCart();
    billInItemController.billInItemsInDay.clear();
    billOutItemController.billOutItemsInDay.clear();
    billFactoryController.billFactoryItemsInDay.clear();
    billStockController.billStockItemsInDay.clear();
    billShortageItemController.billShortageItemsInDay.clear();
  }

  void printFunction() {
    dayReportsController.clearAllPrintsList();
    //*******************************Bills In************************************
    List billsIn = dayReportsController.billsInCarts.values.toList();
    for (int i = 0; i < billsIn.length; i++) {
      dayReportsController.billsInPrintList.add(
        [
          (double.parse(billsIn[i].itemMax) *
                  double.parse(billsIn[i].itemPriceIn))
              .toStringAsFixed(2),
          double.parse(billsIn[i].itemMax).toStringAsFixed(2),
          (double.parse(billsIn[i].itemMin) *
                  double.parse(billsIn[i].itemPriceIn))
              .toStringAsFixed(2),
          double.parse(billsIn[i].itemMin).toStringAsFixed(2),
          double.parse(billsIn[i].itemPriceIn).toStringAsFixed(2),
          billsIn[i].itemNum,
          billsIn[i].itemName,
        ],
      );
    }
    //*******************************Bills Out************************************
    List billsOutCom = dayReportsController.billsOutComCarts.values.toList();
    for (int i = 0; i < billsOutCom.length; i++) {
      dayReportsController.billsOutComPrintList.add(
        [
          (double.parse(billsOutCom[i].itemMax) *
                  double.parse(billsOutCom[i].itemPriceOut))
              .toStringAsFixed(2),
          double.parse(billsOutCom[i].itemMax).toStringAsFixed(2),
          (double.parse(billsOutCom[i].itemMin) *
                  double.parse(billsOutCom[i].itemPriceOut))
              .toStringAsFixed(2),
          double.parse(billsOutCom[i].itemMin).toStringAsFixed(2),
          double.parse(billsOutCom[i].itemPriceOut).toStringAsFixed(2),
          billsOutCom[i].itemNum,
          billsOutCom[i].itemName,
        ],
      );
    }
    List billsOutProd = dayReportsController.billsOutProdCarts.values.toList();
    for (int i = 0; i < billsOutProd.length; i++) {
      dayReportsController.billsOutProdPrintList.add(
        [
          (double.parse(billsOutProd[i].itemMax) *
                  double.parse(billsOutProd[i].itemPriceOut))
              .toStringAsFixed(2),
          double.parse(billsOutProd[i].itemMax).toStringAsFixed(2),
          (double.parse(billsOutProd[i].itemMin) *
                  double.parse(billsOutProd[i].itemPriceOut))
              .toStringAsFixed(2),
          double.parse(billsOutProd[i].itemMin).toStringAsFixed(2),
          double.parse(billsOutProd[i].itemPriceOut).toStringAsFixed(2),
          billsOutProd[i].itemNum,
          billsOutProd[i].itemName,
        ],
      );
    }
    //*******************************Bills Stock************************************
    List billsStock = dayReportsController.billsStockCarts.values.toList();
    for (int i = 0; i < billsStock.length; i++) {
      dayReportsController.billsStockPrintList.add(
        [
          double.parse(billsStock[i].itemMax).toStringAsFixed(2),
          double.parse(billsStock[i].itemMin).toStringAsFixed(2),
          billsStock[i].itemNum,
          billsStock[i].itemName,
        ],
      );
    }
    //*******************************Bills Factory************************************
    List billsFactoryCom =
        dayReportsController.billsFactoryComCarts.values.toList();
    for (int i = 0; i < billsFactoryCom.length; i++) {
      dayReportsController.billsFactoryComPrintList.add(
        [
          double.parse(billsFactoryCom[i].itemMin).toStringAsFixed(2),
          billsFactoryCom[i].itemNum,
          billsFactoryCom[i].itemName,
        ],
      );
    }
    List billsFactoryProd =
        dayReportsController.billsFactoryProdCarts.values.toList();
    for (int i = 0; i < billsFactoryProd.length; i++) {
      dayReportsController.billsFactoryProdPrintList.add(
        [
          double.parse(billsFactoryProd[i].itemMin).toStringAsFixed(2),
          billsFactoryProd[i].itemNum,
          billsFactoryProd[i].itemName,
        ],
      );
    }
    //*******************************Bills Shortage************************************
    List billsShortageCom =
        dayReportsController.billsShortageComCarts.values.toList();
    for (int i = 0; i < billsShortageCom.length; i++) {
      dayReportsController.billsShortageComPrintList.add(
        [
          double.parse(billsShortageCom[i].itemMax).toStringAsFixed(2),
          double.parse(billsShortageCom[i].itemMin).toStringAsFixed(2),
          billsShortageCom[i].itemNum,
          billsShortageCom[i].itemName,
        ],
      );
    }
    List billsShortageProd =
        dayReportsController.billsShortageProdCarts.values.toList();
    for (int i = 0; i < billsShortageProd.length; i++) {
      dayReportsController.billsShortageProdPrintList.add(
        [
          double.parse(billsShortageProd[i].itemMax).toStringAsFixed(2),
          double.parse(billsShortageProd[i].itemMin).toStringAsFixed(2),
          billsShortageProd[i].itemNum,
          billsShortageProd[i].itemName,
        ],
      );
    }
    printDayReport(
      columsStock: [
        AppStrings.backBillStock,
        AppStrings.billStock,
        AppStrings.itemNum,
        AppStrings.itemName,
      ],
      columsFactory: [
        AppStrings.theValue,
        AppStrings.itemNum,
        AppStrings.itemName,
      ],
      columsBillIn: [
        AppStrings.total,
        AppStrings.back,
        AppStrings.total,
        AppStrings.billIn,
        AppStrings.itemPriceIn,
        AppStrings.itemNum,
        AppStrings.itemName,
      ],
      columsBilOut: [
        AppStrings.total,
        AppStrings.back,
        AppStrings.total,
        AppStrings.billOut,
        AppStrings.itemPriceOut,
        AppStrings.itemNum,
        AppStrings.itemName,
      ],
      columsBillShortage: [
        AppStrings.theMinus,
        AppStrings.thePlus,
        AppStrings.itemNum,
        AppStrings.itemName,
      ],
      label: dayReportsController.currentDateView.value,
      stockCom: dayReportsController.billsStockPrintList,
      factoryCom: dayReportsController.billsFactoryComPrintList,
      factoryProd: dayReportsController.billsFactoryProdPrintList,
      billInCom: dayReportsController.billsInPrintList,
      bilOutCom: dayReportsController.billsOutComPrintList,
      bilOutProd: dayReportsController.billsOutProdPrintList,
      shortageCom: dayReportsController.billsShortageComPrintList,
      shortageProd: dayReportsController.billsShortageProdPrintList,
    );
  }
}

class BillsOutComponents extends StatelessWidget {
  const BillsOutComponents({super.key, required this.dayReportsController});
  final DayReportsControllerImp dayReportsController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text(
        //   AppStrings.components,
        //   style: context.textTheme.displayMedium,
        // ),
        BillOutTableItem(
          isHeader: true,
          isInDayReport: true,
        ),
        dayReportsController.billsOutComCarts.isEmpty
            ? const MyLottieEmpty()
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return BillOutTableItem(
                    item: dayReportsController.billsOutComCarts.values
                        .toList()[index],
                    isHeader: false,
                    isInDayReport: true,
                  );
                },
                itemCount: dayReportsController.billsOutComCarts.length,
              ),
        SizedBox(
          height: AppSizes.h02,
        ),
        MyButton(
          text: AppStrings.print,
          color: context.theme.primaryColorDark,
          onPressed: () {
            dayReportsController.clearAllPrintsList();
            //*******************************Bills Out************************************
            List billsOutCom =
                dayReportsController.billsOutComCarts.values.toList();
            for (int i = 0; i < billsOutCom.length; i++) {
              dayReportsController.billsOutComPrintList.add(
                [
                  (double.parse(billsOutCom[i].itemMax) *
                          double.parse(billsOutCom[i].itemPriceOut))
                      .toStringAsFixed(2),
                  double.parse(billsOutCom[i].itemMax).toStringAsFixed(2),
                  (double.parse(billsOutCom[i].itemMin) *
                          double.parse(billsOutCom[i].itemPriceOut))
                      .toStringAsFixed(2),
                  double.parse(billsOutCom[i].itemMin).toStringAsFixed(2),
                  double.parse(billsOutCom[i].itemPriceOut).toStringAsFixed(2),
                  billsOutCom[i].itemNum,
                  billsOutCom[i].itemName,
                ],
              );
            }
            printDayReportOneTable(
              colums: [
                AppStrings.total,
                AppStrings.back,
                AppStrings.total,
                AppStrings.billOut,
                AppStrings.itemPriceOut,
                AppStrings.itemNum,
                AppStrings.itemName,
              ],
              printList: dayReportsController.billsOutComPrintList,
              subLabel: AppStrings.components,
              label: AppStrings.billOut,
              date: dayReportsController.currentDateView.value,
            );
          },
        )

        //
      ],
    );
  }
}

class BillsOutProudcts extends StatelessWidget {
  const BillsOutProudcts({super.key, required this.dayReportsController});
  final DayReportsControllerImp dayReportsController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text(
        //   AppStrings.products,
        //   style: context.textTheme.displayMedium,
        // ),
        BillOutTableItem(
          isHeader: true,
          isInDayReport: true,
        ),
        dayReportsController.billsOutProdCarts.isEmpty
            ? const MyLottieEmpty()
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return BillOutTableItem(
                    item: dayReportsController.billsOutProdCarts.values
                        .toList()[index],
                    isHeader: false,
                    isInDayReport: true,
                  );
                },
                itemCount: dayReportsController.billsOutProdCarts.length,
              ),
        SizedBox(
          height: AppSizes.h02,
        ),
        MyButton(
          text: AppStrings.print,
          color: context.theme.primaryColorDark,
          onPressed: () {
            dayReportsController.clearAllPrintsList();
            //*******************************Bills Out************************************
            List billsOutProd =
                dayReportsController.billsOutProdCarts.values.toList();
            for (int i = 0; i < billsOutProd.length; i++) {
              dayReportsController.billsOutProdPrintList.add(
                [
                  (double.parse(billsOutProd[i].itemMax) *
                          double.parse(billsOutProd[i].itemPriceOut))
                      .toStringAsFixed(2),
                  double.parse(billsOutProd[i].itemMax).toStringAsFixed(2),
                  (double.parse(billsOutProd[i].itemMin) *
                          double.parse(billsOutProd[i].itemPriceOut))
                      .toStringAsFixed(2),
                  double.parse(billsOutProd[i].itemMin).toStringAsFixed(2),
                  double.parse(billsOutProd[i].itemPriceOut).toStringAsFixed(2),
                  billsOutProd[i].itemNum,
                  billsOutProd[i].itemName,
                ],
              );
            }
            printDayReportOneTable(
              colums: [
                AppStrings.total,
                AppStrings.back,
                AppStrings.total,
                AppStrings.billOut,
                AppStrings.itemPriceOut,
                AppStrings.itemNum,
                AppStrings.itemName,
              ],
              printList: dayReportsController.billsOutProdPrintList,
              subLabel: AppStrings.products,
              label: AppStrings.billOut,
              date: dayReportsController.currentDateView.value,
            );
          },
        ),
      ],
    );
  }
}

class BillsFactoryComponents extends StatelessWidget {
  const BillsFactoryComponents({super.key, required this.dayReportsController});
  final DayReportsControllerImp dayReportsController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text(
        //   AppStrings.components,
        //   style: context.textTheme.displayMedium,
        // ),
        BillFactoryTableItem(
          inDayReport: true,
          isHeader: true,
          kind: AppStrings.components,
        ),
        dayReportsController.billsFactoryComCarts.isEmpty
            ? const MyLottieEmpty()
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return BillFactoryTableItem(
                    inDayReport: true,
                    item: dayReportsController.billsFactoryComCarts.values
                        .toList()[index],
                    isHeader: false,
                    kind: AppStrings.components,
                  );
                },
                itemCount: dayReportsController.billsFactoryComCarts.length,
              ),
        SizedBox(
          height: AppSizes.h02,
        ),
        MyButton(
          text: AppStrings.print,
          color: context.theme.primaryColorDark,
          onPressed: () {
            dayReportsController.clearAllPrintsList();
            List billsFactoryCom =
                dayReportsController.billsFactoryComCarts.values.toList();
            for (int i = 0; i < billsFactoryCom.length; i++) {
              dayReportsController.billsFactoryComPrintList.add(
                [
                  double.parse(billsFactoryCom[i].itemMin).toStringAsFixed(2),
                  billsFactoryCom[i].itemNum,
                  billsFactoryCom[i].itemName,
                ],
              );
            }
            printDayReportOneTable(
              colums: [
                AppStrings.theValue,
                AppStrings.itemNum,
                AppStrings.itemName,
              ],
              printList: dayReportsController.billsFactoryComPrintList,
              label: AppStrings.theFactory,
              subLabel: AppStrings.usedComponents,
              date: dayReportsController.currentDateView.value,
            );
          },
        )
      ],
    );
  }
}

class BillsFactoryProudcts extends StatelessWidget {
  const BillsFactoryProudcts({super.key, required this.dayReportsController});
  final DayReportsControllerImp dayReportsController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BillFactoryTableItem(
          inDayReport: true,
          isHeader: true,
          kind: AppStrings.products,
        ),
        dayReportsController.billsFactoryProdCarts.isEmpty
            ? const MyLottieEmpty()
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return BillFactoryTableItem(
                    inDayReport: true,
                    item: dayReportsController.billsFactoryProdCarts.values
                        .toList()[index],
                    isHeader: false,
                    kind: AppStrings.products,
                  );
                },
                itemCount: dayReportsController.billsFactoryProdCarts.length,
              ),
        SizedBox(
          height: AppSizes.h02,
        ),
        MyButton(
          text: AppStrings.print,
          color: context.theme.primaryColorDark,
          onPressed: () {
            dayReportsController.clearAllPrintsList();
            List billsFactoryProd =
                dayReportsController.billsFactoryProdCarts.values.toList();
            for (int i = 0; i < billsFactoryProd.length; i++) {
              dayReportsController.billsFactoryProdPrintList.add(
                [
                  double.parse(billsFactoryProd[i].itemMin).toStringAsFixed(2),
                  billsFactoryProd[i].itemQuantWight,
                  billsFactoryProd[i].itemNum,
                  billsFactoryProd[i].itemName,
                ],
              );
            }
            printDayReportOneTable(
              colums: [
                AppStrings.theNumber,
                AppStrings.wight,
                AppStrings.itemNum,
                AppStrings.itemName,
              ],
              printList: dayReportsController.billsFactoryProdPrintList,
              label: AppStrings.theFactory,
              subLabel: AppStrings.products,
              date: dayReportsController.currentDateView.value,
            );
          },
        )
      ],
    );
  }
}

class BillsShortageComponents extends StatelessWidget {
  const BillsShortageComponents(
      {super.key, required this.dayReportsController});
  final DayReportsControllerImp dayReportsController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text(
        //   AppStrings.components,
        //   style: context.textTheme.displayMedium,
        // ),
        BillShortageTableItem(
          isHeader: true,
        ),
        dayReportsController.billsShortageComCarts.isEmpty
            ? const MyLottieEmpty()
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return BillShortageTableItem(
                    item: dayReportsController.billsShortageComCarts.values
                        .toList()[index],
                    isHeader: false,
                  );
                },
                itemCount: dayReportsController.billsShortageComCarts.length,
              ),
        SizedBox(
          height: AppSizes.h02,
        ),
        MyButton(
          text: AppStrings.print,
          color: context.theme.primaryColorDark,
          onPressed: () {
            dayReportsController.clearAllPrintsList();
            //*******************************Bills shortage************************************
            List billsShortageCom =
                dayReportsController.billsShortageComCarts.values.toList();
            for (int i = 0; i < billsShortageCom.length; i++) {
              dayReportsController.billsShortageComPrintList.add(
                [
                  double.parse(billsShortageCom[i].itemMax).toStringAsFixed(2),
                  double.parse(billsShortageCom[i].itemMin).toStringAsFixed(2),
                  billsShortageCom[i].itemNum,
                  billsShortageCom[i].itemName,
                ],
              );
            }
            printDayReportOneTable(
              colums: [
                AppStrings.theMinus,
                AppStrings.thePlus,
                AppStrings.itemNum,
                AppStrings.itemName,
              ],
              printList: dayReportsController.billsShortageComPrintList,
              label: AppStrings.theShortage,
              subLabel: AppStrings.components,
              date: dayReportsController.currentDateView.value,
            );
          },
        )
      ],
    );
  }
}

class BillsShortageProudcts extends StatelessWidget {
  const BillsShortageProudcts({super.key, required this.dayReportsController});
  final DayReportsControllerImp dayReportsController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text(
        //   AppStrings.products,
        //   style: context.textTheme.displayMedium,
        // ),
        BillShortageTableItem(
          isHeader: true,
        ),
        dayReportsController.billsShortageProdCarts.isEmpty
            ? const MyLottieEmpty()
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return BillShortageTableItem(
                    item: dayReportsController.billsShortageProdCarts.values
                        .toList()[index],
                    isHeader: false,
                  );
                },
                itemCount: dayReportsController.billsShortageProdCarts.length,
              ),
        SizedBox(
          height: AppSizes.h02,
        ),

        MyButton(
          text: AppStrings.print,
          color: context.theme.primaryColorDark,
          onPressed: () {
            dayReportsController.clearAllPrintsList();
            //*******************************Bills shortage************************************
            List billsShortageProd =
                dayReportsController.billsShortageProdCarts.values.toList();
            for (int i = 0; i < billsShortageProd.length; i++) {
              dayReportsController.billsShortageProdPrintList.add(
                [
                  double.parse(billsShortageProd[i].itemMax).toStringAsFixed(2),
                  double.parse(billsShortageProd[i].itemMin).toStringAsFixed(2),
                  billsShortageProd[i].itemNum,
                  billsShortageProd[i].itemName,
                ],
              );
            }
            printDayReportOneTable(
              colums: [
                AppStrings.theMinus,
                AppStrings.thePlus,
                AppStrings.itemNum,
                AppStrings.itemName,
              ],
              printList: dayReportsController.billsShortageProdPrintList,
              label: AppStrings.theShortage,
              subLabel: AppStrings.products,
              date: dayReportsController.currentDateView.value,
            );
          },
        )
      ],
    );
  }
}

class BillInItems extends StatelessWidget {
  const BillInItems({super.key, required this.dayReportsController});
  final DayReportsControllerImp dayReportsController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Column(
          children: [
            BillInTableItem(
              isInDay: true,
              isHeader: true,
            ),
            dayReportsController.billsInCarts.isEmpty
                ? const MyLottieEmpty()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return BillInTableItem(
                        isInDay: true,
                        item: dayReportsController.billsInCarts.values
                            .toList()[index],
                        isHeader: false,
                      );
                    },
                    itemCount: dayReportsController.billsInCarts.length,
                  ),
            SizedBox(
              height: AppSizes.h02,
            ),
            MyButton(
              text: AppStrings.print,
              color: context.theme.primaryColorDark,
              onPressed: () {
                dayReportsController.clearAllPrintsList();
                //*******************************Bills In************************************
                List billsIn =
                    dayReportsController.billsInCarts.values.toList();
                for (int i = 0; i < billsIn.length; i++) {
                  dayReportsController.billsInPrintList.add(
                    [
                      (double.parse(billsIn[i].itemMax) *
                              double.parse(billsIn[i].itemPriceIn))
                          .toStringAsFixed(2),
                      double.parse(billsIn[i].itemMax).toStringAsFixed(2),
                      (double.parse(billsIn[i].itemMin) *
                              double.parse(billsIn[i].itemPriceIn))
                          .toStringAsFixed(2),
                      double.parse(billsIn[i].itemMin).toStringAsFixed(2),
                      double.parse(billsIn[i].itemPriceIn).toStringAsFixed(2),
                      billsIn[i].itemNum,
                      billsIn[i].itemName,
                    ],
                  );
                }
                printDayReportOneTable(
                  colums: [
                    AppStrings.total,
                    AppStrings.back,
                    AppStrings.total,
                    AppStrings.billIn,
                    AppStrings.itemPriceIn,
                    AppStrings.itemNum,
                    AppStrings.itemName,
                  ],
                  printList: dayReportsController.billsInPrintList,
                  subLabel: '',
                  label: AppStrings.billIn,
                  date: dayReportsController.currentDateView.value,
                );
              },
            )
          ],
        );
      },
    );
  }
}

class BillStockItems extends StatelessWidget {
  const BillStockItems({super.key, required this.dayReportsController});
  final DayReportsControllerImp dayReportsController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Column(
          children: [
            ReporStockItem(
              isHeader: true,
            ),
            dayReportsController.billsStockCarts.isEmpty
                ? const MyLottieEmpty()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ReporStockItem(
                        item: dayReportsController.billsStockCarts.values
                            .toList()[index],
                        isHeader: false,
                      );
                    },
                    itemCount: dayReportsController.billsStockCarts.length,
                  ),
            SizedBox(
              height: AppSizes.h02,
            ),
            MyButton(
              text: AppStrings.print,
              color: context.theme.primaryColorDark,
              onPressed: () {
                dayReportsController.clearAllPrintsList();
                //*******************************Bills In************************************
                List billsStock =
                    dayReportsController.billsStockCarts.values.toList();
                for (int i = 0; i < billsStock.length; i++) {
                  dayReportsController.billsStockPrintList.add(
                    [
                      double.parse(billsStock[i].itemMax).toStringAsFixed(2),
                      double.parse(billsStock[i].itemMin).toStringAsFixed(2),
                      billsStock[i].itemNum,
                      billsStock[i].itemName,
                    ],
                  );
                }
                printDayReportOneTable(
                  colums: [
                    AppStrings.back,
                    AppStrings.billStock,
                    AppStrings.itemNum,
                    AppStrings.itemName,
                  ],
                  printList: dayReportsController.billsStockPrintList,
                  subLabel: '',
                  label: AppStrings.stockComponents,
                  date: dayReportsController.currentDateView.value,
                );
              },
            )
          ],
        );
      },
    );
  }
}
