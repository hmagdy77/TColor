import 'package:intl/intl.dart';

import '../../../controllers/factory/bill_factory_controller.dart';
import '../../../controllers/factory/bill_factory_item_controller.dart';
import '../../../controllers/items/item_controller.dart';
import '../../../controllers/plans/plan_controller.dart';
import '../../../controllers/plans/plan_item_controller.dart';
import '../../../core/print/pdf_plan.dart';
import '../../../data/models/bills/bill_model.dart';
import '../../../data/models/items/item_model.dart';
import '../../../libraries.dart';
import '../../widgets/admin/dialouge.dart';
import '../../widgets/bills_factory/view_bill_item.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/public/bill_details_local.dart';

class ViewBillFactoryScreen extends StatelessWidget {
  ViewBillFactoryScreen({super.key});

  final BillFactoryControllerImp billFactoryController =
      Get.find<BillFactoryControllerImp>();
  final BillFactoryItemControllerImp billFactoryItemController =
      Get.find<BillFactoryItemControllerImp>();
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();
  final PlanItemControllerImp planItemController =
      Get.find<PlanItemControllerImp>();
  final PlanControllerImp planController = Get.find<PlanControllerImp>();
  final MyService myService = Get.find();

  final Bill bill = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (billFactoryItemController.isLoading.value ||
              billFactoryController.isLoading.value) {
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
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // //bill id and date and numberOfitems
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     Text(
                        //       ' ${AppStrings.billNumper} : ${bill.billId.toString()}',
                        //       style: context.textTheme.displayLarge,
                        //     ),
                        //     Text(
                        //       '${AppStrings.date} : ${DateFormat.yMEd().format(bill.billTimestamp)}',
                        //       style: context.textTheme.displayLarge,
                        //     ),
                        //     Text(
                        //       '${AppStrings.empName} : ${bill.workName.toString()}',
                        //       style: context.textTheme.displayLarge,
                        //     ),
                        //     Text(
                        //       ' ${AppStrings.notes} : ${bill.billNotes.toString()}',
                        //       style: context.textTheme.displayLarge,
                        //     ),
                        //   ],
                        // ),

                        BillDetailsLocal(
                          bill: bill,
                          label: AppStrings.billFactory,
                        ),
                        //for height
                        SizedBox(
                          height: AppSizes.h04,
                        ),
                        // middle Area
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Proudcts(
                                  billFactoryItemControllerImp:
                                      billFactoryItemController,
                                ),
                              ),
                              VerticalDivider(
                                thickness: 2,
                                color: AppColorManger.greyLight,
                              ),
                              Expanded(
                                child: Components(
                                  billFactoryItemController:
                                      billFactoryItemController,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MyButton(
                              text: AppStrings.print,
                              minWidth: AppSizes.w3,
                              onPressed: printBill,
                            ),
                            myService.sharedPreferences
                                        .getInt(AppStrings.adminKey)! !=
                                    1
                                ? const SizedBox()
                                : MyButton(
                                    text: AppStrings.deleteBill,
                                    minWidth: AppSizes.w3,
                                    onPressed: () {
                                      myDialuge(
                                        cancel: () {
                                          Get.back();
                                        },
                                        confirm: delete,
                                        title: AppStrings.deleteBill,
                                        middleText: '',
                                      );
                                    },
                                  ),
                          ],
                        )
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

  delete() async {
    //*************************Bill Factory and Items***********************
    List<Item> proudcts = billFactoryItemController.allBillFactoryItems;
    List<Item> components = billFactoryItemController.allBillFactoryItems;
    double proudctsCountVal = 0.0;
    double componentsCountVal = 0.0;

    //*************************update stock***********************
    for (int index = 0; index < proudcts.length; index++) {
      await itemController.updateStock(
        itemNum: proudcts[index].itemNum,
        quantity: (-double.parse(proudcts[index].itemQuantWight)).toString(),
      );
      proudctsCountVal += double.parse(proudcts[index].itemQuantWight);
    }
    //*************************update sub stock***********************
    for (int index = 0; index < components.length; index++) {
      await itemController.updateSubStock(
        itemNum: components[index].itemNum,
        subQuantity: (double.parse(components[index].itemCount)).toString(),
      );
      componentsCountVal += double.parse(components[index].itemCount);
    }
    //*************************update plan***********************
    await planController.updatePlan(
      id: bill.planId.toString(),
      exghange: '0.0',
      componentsDone: (-componentsCountVal).toString(),
      proudctsDone: (-proudctsCountVal).toString(),
    );
    // erase compontents count
    for (int index = 0; index < components.length; index++) {
      await planItemController.updatePlanItem(
        itemNum: components[index].itemNum,
        planId: bill.planId.toString(),
        exCahnge: '0.0',
        used: (-double.parse(components[index].itemCount)).toString(),
        done: '0.0',
        itemQuantWight: '0.0',
      );
    }
    //erase proudcts count
    for (int index = 0; index < proudcts.length; index++) {
      await planItemController.updatePlanItem(
        itemNum: proudcts[index].itemNum,
        planId: bill.planId.toString(),
        exCahnge: '0.0',
        used: '0.0',
        done: (-double.parse(proudcts[index].itemCount)).toString(),
        itemQuantWight:
            (-double.parse(proudcts[index].itemQuantWight)).toString(),
      );
    }
    await billFactoryItemController.deleteItems(
      billId: bill.billId.toString(),
    );
    await billFactoryController.deleteBill(
      billId: bill.billId.toString(),
    );
    await itemController.getItems();
    await planController.getPlans();
  }

  printBill() {
    planController.itemsProd.clear();
    planController.itemsCom.clear();
    List itemsF = billFactoryItemController.billItemsProudcts;
    List itemsS = billFactoryItemController.billItemsComponents;
    for (int i = 0; i < itemsF.length; i++) {
      planController.itemsProd.add(
        [itemsF[i].itemCount, itemsF[i].itemNum, itemsF[i].itemName],
      );
    }
    for (int i = 0; i < itemsS.length; i++) {
      planController.itemsCom.add(
        [itemsS[i].itemCount, itemsS[i].itemNum, itemsS[i].itemName],
      );
    }
    printPlan(
      billDate: DateFormat.yMMMMEEEEd('ar').format(bill.billTimestamp),
      billNumber: bill.billId.toString(),
      itemsF: planController.itemsProd,
      columsF: [
        AppStrings.doneFactory,
        AppStrings.itemNum,
        AppStrings.itemName,
      ],
      label: AppStrings.billFactory,
      kind: '2',
      total: '0',
      columsS: [
        AppStrings.usedFactory,
        AppStrings.itemNum,
        AppStrings.itemName,
      ],
      itemsS: planController.itemsCom,
    );
  }
}

class Components extends StatelessWidget {
  const Components({super.key, required this.billFactoryItemController});
  final BillFactoryItemControllerImp billFactoryItemController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.components,
          style: context.textTheme.titleSmall,
        ),
        const ViewBillFactoryItem(
          isHeader: true,
          isProudct: false,
          index: 0,
        ),
        billFactoryItemController.billItemsComponents.isEmpty
            ? Text(
                AppStrings.emptyList,
                style: context.textTheme.titleSmall,
              )
            : Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ViewBillFactoryItem(
                      item:
                          billFactoryItemController.billItemsComponents[index],
                      isHeader: false,
                      isProudct: false,
                      index: index,
                    );
                  },
                  itemCount:
                      billFactoryItemController.billItemsComponents.length,
                ),
              ),
      ],
    );
  }
}

class Proudcts extends StatelessWidget {
  const Proudcts({super.key, required this.billFactoryItemControllerImp});
  final BillFactoryItemControllerImp billFactoryItemControllerImp;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.products,
          style: context.textTheme.titleSmall,
        ),
        const ViewBillFactoryItem(
          isHeader: true,
          isProudct: true,
          index: 0,
        ),
        billFactoryItemControllerImp.billItemsProudcts.isEmpty
            ? Text(
                AppStrings.emptyList,
                style: context.textTheme.titleSmall,
              )
            : Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ViewBillFactoryItem(
                      item:
                          billFactoryItemControllerImp.billItemsProudcts[index],
                      isHeader: false,
                      isProudct: true,
                      index: index,
                    );
                  },
                  itemCount:
                      billFactoryItemControllerImp.billItemsProudcts.length,
                ),
              ),
      ],
    );
  }
}
