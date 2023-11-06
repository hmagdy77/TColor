import 'package:intl/intl.dart';

import '../../../controllers/bill_stock/bill_stock_cart.dart';
import '../../../controllers/bill_stock/bill_stock_controller.dart';
import '../../../controllers/bill_stock/bill_stock_items_controller.dart';
import '../../../controllers/items/item_controller.dart';
import '../../../controllers/plans/plan_controller.dart';
import '../../../controllers/plans/plan_item_controller.dart';
import '../../../core/print/pdf_bill.dart';
import '../../../data/models/bills/bill_model.dart';
import '../../../libraries.dart';
import '../../widgets/admin/dialouge.dart';
import '../../widgets/bills_shortage/bill_shortage_view_cart_item.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/public/bill_details_local.dart';

class EditBillStockScreen extends StatelessWidget {
  EditBillStockScreen({super.key});

  final BillStockItemControllerImp billStockItemController =
      Get.find<BillStockItemControllerImp>();
  final BillStockCartControllerImp cartController =
      Get.find<BillStockCartControllerImp>();
  final BillStockControllerImp billStockController =
      Get.find<BillStockControllerImp>();
  final PlanItemControllerImp planItemController =
      Get.find<PlanItemControllerImp>();
  final PlanControllerImp planController = Get.find<PlanControllerImp>();

  final ItemControllerImp itemController = Get.find<ItemControllerImp>();
  final MyService myService = Get.find();

  final Bill bill = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (billStockItemController.isLoading.value ||
              cartController.isLoading.value ||
              billStockController.isLoading.value) {
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
                        BillDetailsLocal(
                          bill: bill,
                          label: bill.kind == 1
                              ? AppStrings.billStockView
                              : AppStrings.backBillStockView,
                        ),
                        //for height
                        SizedBox(
                          height: AppSizes.h04,
                        ),

                        //cart items
                        Expanded(
                          flex: 3,
                          // height: AppSizes.h18,

                          child: cartController.myCarts.isEmpty
                              ? Text(
                                  AppStrings.emptyList,
                                  style: context.textTheme.titleSmall,
                                )
                              : Column(
                                  children: [
                                    Expanded(
                                      child: GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: AppSizes.h25,
                                        ),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                bottom: AppSizes.h02),
                                            child: BillLocalCartItem(
                                              // isOvered: false,

                                              item: cartController.myCarts.keys
                                                  .toList()[index],
                                            ),
                                          );
                                        },
                                        itemCount:
                                            cartController.myCarts.length,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        // //save and print buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //print button
                            MyButton(
                              text: AppStrings.print,
                              minWidth: AppSizes.w3,
                              onPressed: () {
                                printFunc();
                              },
                            ),

                            //do dialouge
                            //do dialouge
                            myService.sharedPreferences
                                        .getInt(AppStrings.adminKey)! !=
                                    1
                                ? const SizedBox()
                                : MyButton(
                                    text: AppStrings.deleteBillStock,
                                    minWidth: AppSizes.w3,
                                    onPressed: () {
                                      myDialuge(
                                          cancel: () {
                                            Get.back();
                                            cartController.myCarts.clear();
                                            cartController.controllers!.clear();
                                          },
                                          confirm: () {
                                            deleteFunc();
                                          },
                                          title: AppStrings.deleteBillStock,
                                          middleText: '');
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

  printFunc() {
    cartController.items.clear();
    List items = cartController.myCarts.keys.toList();
    for (int i = 0; i < items.length; i++) {
      cartController.items.add(
        [
          cartController.myCarts.values.toList()[i].toString(),
          items[i].itemNum.toString(),
          items[i].itemName,
        ],
      );
    }

    printBill(
      billDate: DateFormat.yMMMMEEEEd('ar').format(bill.billTimestamp),
      billLenth: cartController.myCarts.length.toString(),
      billNumber: bill.billId.toString(),
      items: cartController.items,
      colums: [
        AppStrings.itemQuantity,
        AppStrings.itemNum,
        AppStrings.itemName,
      ],
      label: AppStrings.backBillStock,
      kind: '1',
      endDate: '',
      startDate: '',
      total: '0',
    );
  }

  deleteFunc() async {
    List items = cartController.myCarts.keys.toList();
    if (bill.kind == 1) {
      for (int i = 0; i < items.length; i++) {
        await itemController.updateStock(
          itemNum: items[i].itemNum.toString(),
          quantity: (double.parse(items[i].itemCount)).toString(),
        );
        await itemController.updateSubStock(
          itemNum: items[i].itemNum.toString(),
          subQuantity: (-double.parse(items[i].itemCount)).toString(),
        );
        await planItemController.updatePlanItem(
            itemNum: items[i].itemNum,
            planId: bill.planId.toString(),
            exCahnge: (-double.parse(items[i].itemCount)).toString(),
            used: '0',
            done: '0',
            itemQuantWight: '0.0');
      }
    } else {
      for (int i = 0; i < items.length; i++) {
        await itemController.updateStock(
          itemNum: items[i].itemNum.toString(),
          quantity: (-double.parse(items[i].itemCount)).toString(),
        );
        await itemController.updateSubStock(
          itemNum: items[i].itemNum.toString(),
          subQuantity: double.parse(items[i].itemCount).toString(),
        );
      }
    }
    await planController.updatePlan(
      id: bill.planId.toString(),
      exghange: double.parse(bill.billTotal).toString(),
      componentsDone: '0.0',
      proudctsDone: '0.0',
    );
    await billStockItemController.deleteAllBillItems(bill.billId.toString());
    await billStockController.deleteBill(billId: bill.billId.toString());
    await itemController.getItems();
    cartController.clearCart();
    Get.offAndToNamed(
      AppRoutes.loadingScreen,
      arguments: [
        AppRoutes.viewStockBillsScreen,
        () {},
      ],
    );
  }
}
