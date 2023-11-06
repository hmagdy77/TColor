import 'package:intl/intl.dart';

import '../../../../controllers/items/item_controller.dart';
import '../../../../controllers/plans/plan_item_controller.dart';
import '../../../../controllers/supplires/sup_controller.dart';
import '../../../../data/models/items/item_model.dart';
import '../../../../libraries.dart';
import '../../../controllers/bill_stock/bill_stock_cart.dart';
import '../../../controllers/bill_stock/bill_stock_controller.dart';
import '../../../controllers/bill_stock/bill_stock_items_controller.dart';
import '../../../controllers/plans/plan_controller.dart';
import '../../../core/print/pdf_bill.dart';
import '../../../data/models/bills/bill_model.dart';
import '../../../data/models/plans/plan_model.dart';
import '../../widgets/drop_menu/drop_menu.dart';
import '../../widgets/items/item_cart_item.dart';
import '../../widgets/items/item_widget.dart';
import '../../widgets/items/wanted_item.dart';
import '../../widgets/login/snackbar.dart';
import '../../widgets/lottie/empty.dart';
import '../../widgets/menus/upper_widget.dart';

class AddBillStockScreen extends StatelessWidget {
  AddBillStockScreen({super.key});
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();
  final BillStockCartControllerImp billStockCartController =
      Get.find<BillStockCartControllerImp>();
  final BillStockControllerImp billStockController =
      Get.find<BillStockControllerImp>();
  final BillStockItemControllerImp billStockItemController =
      Get.find<BillStockItemControllerImp>();

  final SupControllerImp supController = Get.find<SupControllerImp>();
  final PlanControllerImp planController = Get.find<PlanControllerImp>();
  final PlanItemControllerImp planItemController =
      Get.find<PlanItemControllerImp>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (planItemController.isLoading.value ||
              itemController.isLoading.value ||
              supController.isLoading.value ||
              billStockController.isLoading.value) {
            return const MyLottieLoading();
          } else {
            var bill = billStockController.billsStockListReversed[0];
            final Plans plan = planController.plansListReversed[1];
            return Column(
              children: [
                UpperWidget(
                  isAdminScreen: false,
                  onPressed: () {},
                ),
                Expanded(
                  child: MyContainer(
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // bill details
                        BillDetails(
                            bill: bill,
                            cartController: billStockCartController,
                            billStockController: billStockController),
                        Expanded(
                          child: Row(
                            children: [
                              //textfield for items and dropdown for sup
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          ' ${AppStrings.supName} : ',
                                          style: context.textTheme.displayLarge,
                                        ),
                                        Expanded(
                                          child: MyDropMenu(
                                            label:
                                                supController.selectedSup.value,
                                            bodyItems:
                                                supController.supListNames,
                                            onChanged: (value) {
                                              itemController.search(
                                                  searchName: value.toString(),
                                                  kind: 1);
                                              supController.selectedSup.value =
                                                  value as String;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    //for height
                                    SizedBox(
                                      height: AppSizes.h02,
                                    ),
                                    //search  items
                                    SearchTextFiels(
                                        itemController: itemController,
                                        cartController:
                                            billStockCartController),
                                    //for height
                                    SizedBox(
                                      height: AppSizes.h02,
                                    ),
                                    //items
                                    Items(
                                      itemController: itemController,
                                      cartController: billStockCartController,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: AppSizes.w01),
                              //cart items
                              Expanded(
                                flex: 3,
                                child: CartItems(
                                  cartController: billStockCartController,
                                ),
                              ),
                              // for hieght
                              SizedBox(width: AppSizes.w01),
                              // Wanted Items
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${AppStrings.planNumper} : ${plan.id}',
                                      style: Get.textTheme.displayLarge,
                                    ),
                                    // WantedItems
                                    Expanded(
                                      child: WantedItems(
                                        planItemController: planItemController,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        //save and print buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //clearCart
                            MyButton(
                              text: AppStrings.deleteAll,
                              minWidth: AppSizes.w3,
                              onPressed: () {
                                billStockCartController.clearCart();
                              },
                            ),
                            //  print button
                            MyButton(
                              text: AppStrings.print,
                              minWidth: AppSizes.w3,
                              onPressed: () {
                                printFunc(bill: bill);
                              },
                            ),
                            // save button
                            MyButton(
                              text: AppStrings.save,
                              minWidth: AppSizes.w3,
                              onPressed: save,
                            ),

                            const Spacer(),
                            Text(
                              '${AppStrings.total}  :  ${double.parse(billStockCartController.getNumberOfPieces.toString())} ${AppStrings.kgm}',
                              style: context.textTheme.bodySmall,
                            ),
                            const Spacer(),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }

  Future<void> printFunc({required Bill bill}) async {
    await billStockController.getBillsStock();
    billStockCartController.items.clear();
    List items = billStockCartController.myCarts.keys.toList();
    for (int i = 0; i < items.length; i++) {
      billStockCartController.items.add(
        [
          billStockCartController.myCarts.values.toList()[i].toString(),
          items[i].itemNum.toString(),
          items[i].itemName
        ],
      );
    }
    printBill(
      billDate: billStockController.billDate.isEmpty
          ? DateFormat.yMMMMEEEEd('ar').format(DateTime.now())
          : DateFormat.yMMMMEEEEd('ar').format(billStockController.date.value),
      billLenth: billStockCartController.myCarts.length.toString(),
      billNumber: bill.billId.toString(),
      items: billStockCartController.items,
      colums: [
        AppStrings.itemQuantity,
        AppStrings.itemNum,
        AppStrings.itemName,
      ],
      label: AppStrings.billStock,
      kind: '1',
      endDate: '',
      startDate: '',
      total: '0',
    );
  }

  void save() async {
    await billStockController.getBillsStock();
    var bill = billStockController.billsStockListReversed[0];
    if (billStockCartController.total == 0) {
      MySnackBar.snack(AppStrings.emptyList, '');
    } else if (billStockCartController.isOverd!.contains(true)) {
      MySnackBar.snack(AppStrings.orderdQuantityNotFound, '');
    } else {
      List items = billStockCartController.myCarts.keys.toList();
      List quantities = billStockCartController.myCarts.values.toList();
      final Plans plan = planController.plansListReversed[1];
      // upload bill stock items
      await billStockItemController.addBillStockItemsGroup(
        items: items,
        billId: bill.billId.toString(),
        quantity: quantities,
        kind: '1',
        time: billStockController.billDate.value.isEmpty
            ? '${billStockController.formatter.format(billStockController.now)} ${DateTime.now().hour}:${DateTime.now().minute}:00'
            : billStockController.billDate.value.toString(),
      );
      // minus from main stock
      await itemController.updateStockItemsGroup(
        items: items,
        quantity: quantities,
        kind: 2,
      );
      // add to sub stock
      await itemController.updateSubStockItemsGroup(
        items: items,
        subQuantity: quantities,
        kind: 1,
      );
      // update plan items
      await planItemController.updateGroupPlanItemsExchange(
        items: items,
        planId: plan.id.toString(),
        exCahnge: quantities,
      );
      await planController.updatePlan(
        id: plan.id.toString(),
        exghange: billStockCartController.getNumberOfPieces.toString(),
        componentsDone: '0.0',
        proudctsDone: '0.0',
      );
      // save bill stock
      await billStockController.saveBillStock(
        id: bill.billId.toString(),
        sup: supController.selectedSup.value,
        total: billStockCartController.getNumberOfPieces.toString(),
        numberOfItems: billStockCartController.myCarts.length.toString(),
        kind: '1',
        planId: plan.id.toString(),
      );
      await planItemController.getItemsByIndex(
        planId: plan.id.toString(),
      );
      // add new bill
      await billStockController.addBill();
      await itemController.getItems();
      billStockController.billStockSearchController.clear();
      billStockCartController.clearCart();
      supController.selectedSup.value = '';
      itemController.searchItemsList.clear();
    }
  }
}

class SearchTextFiels extends StatelessWidget {
  const SearchTextFiels({
    super.key,
    required this.itemController,
    required this.cartController,
  });

  final ItemControllerImp itemController;
  final BillStockCartControllerImp cartController;

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      controller: itemController.name,
      validate: (val) {
        return validInput(
          max: 50,
          min: 0,
          type: AppStrings.validateAdmin,
          val: val,
        );
      },
      label: AppStrings.itemName,
      onChanged: (val) {
        itemController.search(searchName: val, kind: 4);
      },
      onSubmite: (val) {
        itemController.search(searchName: val, kind: 4);
      },
      hidePassword: false,
    );
  }
}

class Items extends StatelessWidget {
  const Items({
    super.key,
    required this.itemController,
    required this.cartController,
  });

  final ItemControllerImp itemController;
  final BillStockCartControllerImp cartController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        // width: AppSizes.h6,
        // height: AppSizes.h3,
        child: Obx(
          () {
            if (itemController.isLoading.value) {
              return const MyLottieLoading();
            } else {
              var list = itemController.searchItemsList;
              if (list.isEmpty && itemController.name.text.isNotEmpty) {
                return const MyLottieEmpty();
              } else {
                return ListView.separated(
                  itemCount: list.length,
                  separatorBuilder: (context, index) {
                    return const Divider(
                      thickness: 2,
                    );
                  },
                  itemBuilder: (context, index) {
                    var item = list[index];

                    return GestureDetector(
                      onTap: () {
                        if (double.parse(item.itemQuant) <= 0) {
                          MySnackBar.snack(AppStrings.emptyQuantity, '');
                        } else {
                          cartController.addToCarts(item: item);
                        }
                      },
                      child: MyItemWidget(
                        item: item,
                      ),
                    );
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }
}

class CartItems extends StatelessWidget {
  const CartItems({
    super.key,
    required this.cartController,
  });

  final BillStockCartControllerImp cartController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (cartController.myCarts.isEmpty) {
          return Center(
            child: Text(
              AppStrings.emptyList,
              style: context.textTheme.titleSmall,
            ),
          );
        } else {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: AppSizes.w3),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return ItemCart(
                index: index,
                item: cartController.myCarts.keys.toList()[index],
                quantity: double.parse(
                  cartController.myCarts.values.toList()[index].toString(),
                ),
                isMain: true,
              );
            },
            itemCount: cartController.myCarts.length,
          );
        }
      },
    );
  }
}

class WantedItems extends StatelessWidget {
  const WantedItems({
    super.key,
    required this.planItemController,
  });
  final PlanItemControllerImp planItemController;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColorManger.greyLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 2, color: AppColorManger.black),
      ),
      child: SizedBox(
        // height: AppSizes.h3,
        child: Obx(
          () {
            if (planItemController.isLoading.value) {
              return const MyLottieLoading();
            } else {
              if (planItemController.planItemsWanted.isEmpty) {
                return const SizedBox();
              } else {
                return Column(
                  children: [
                    const Text(AppStrings.wantedComponents),
                    const WantedItem(index: 1, lenth: 1, isHeader: true),
                    Expanded(
                      child: ListView.builder(
                        itemCount: planItemController.planItemsWanted.length,
                        itemBuilder: (context, index) {
                          Item item = planItemController.planItemsWanted[index];
                          return Builder(
                            builder: (context) {
                              return WantedItem(
                                item: item,
                                index: index,
                                lenth:
                                    planItemController.planItemsWanted.length,
                                isHeader: false,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}

// bill Details
class BillDetails extends StatelessWidget {
  const BillDetails({
    super.key,
    required this.bill,
    required this.cartController,
    required this.billStockController,
  });

  final Bill bill;
  final BillStockCartControllerImp cartController;
  final BillStockControllerImp billStockController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  ' ${AppStrings.billStockNumper} : ${bill.billId.toString()}',
                  style: context.textTheme.displayLarge,
                ),
                Text(
                  ' ${AppStrings.numberOfitems} : ${cartController.myCarts.length.toString()}',
                  style: context.textTheme.displayLarge,
                ),
                Text(
                  '${AppStrings.date} : ${billStockController.billDate.value}',
                  //${DateFormat.yMEd().format(DateTime.now())}',
                  style: context.textTheme.displayLarge,
                ),
                IconButton(
                  onPressed: () {
                    billStockController.setBillDate(context: context);
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            ),
            SizedBox(
              height: AppSizes.h01,
            ),
            MyTextField(
              hidePassword: false,
              validate: (v) {},
              label: AppStrings.notes,
              controller: billStockController.billNotes,
            ),
            SizedBox(
              height: AppSizes.h01,
            ),
          ],
        );
      },
    );
  }
}
