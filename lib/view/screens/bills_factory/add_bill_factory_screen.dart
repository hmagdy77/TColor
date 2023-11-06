import 'package:intl/intl.dart';

import '../../../../controllers/items/item_controller.dart';
import '../../../controllers/factory/bill_factory_cart.dart';
import '../../../controllers/factory/bill_factory_controller.dart';
import '../../../controllers/factory/bill_factory_item_controller.dart';
import '../../../controllers/ingredients/ingredients_cart_controller.dart';
import '../../../controllers/ingredients/ingredients_controller.dart';
import '../../../controllers/plans/plan_controller.dart';
import '../../../controllers/plans/plan_item_controller.dart';
import '../../../controllers/sub_stock/sub_stock_cart.dart';
import '../../../core/print/pdf_plan.dart';
import '../../../data/models/bills/bill_model.dart';
import '../../../data/models/items/item_model.dart';
import '../../../libraries.dart';
import '../../widgets/bills_factory/bill_factory_cart_item.dart';
import '../../widgets/bills_factory/wanted_bill_factory_item.dart';
import '../../widgets/items/item_widget.dart';
import '../../widgets/login/snackbar.dart';
import '../../widgets/lottie/empty.dart';
import '../../widgets/menus/upper_widget.dart';

class AddBillFactoryScreen extends StatelessWidget {
  AddBillFactoryScreen({super.key});
// items
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();
  final IngredientControllerImp ingredientController =
      Get.find<IngredientControllerImp>();
  final IngredientCartControllerImp ingredientCartController =
      Get.find<IngredientCartControllerImp>();
// bill factory
  final BillFactoryControllerImp billFactoryController =
      Get.find<BillFactoryControllerImp>();
  final BillFactoryItemControllerImp billFactoryItemController =
      Get.find<BillFactoryItemControllerImp>();
  final BillFactoryCartControllerImp billFactoryCartController =
      Get.find<BillFactoryCartControllerImp>();
// sub Stock
  final SubStockCartControllerImp subStockCartController =
      Get.find<SubStockCartControllerImp>();
// plan
  final PlanItemControllerImp planItemController =
      Get.find<PlanItemControllerImp>();
  final PlanControllerImp planController = Get.find<PlanControllerImp>();

// myservice
  final MyService myService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (itemController.isLoading.value ||
              billFactoryController.isLoading.value ||
              billFactoryItemController.isLoading.value ||
              billFactoryCartController.isLoading.value) {
            return const MyLottieLoading();
          } else {
            var bill = billFactoryController.billsFactoryListReversed[0];
            return Column(
              children: [
                UpperWidget(isAdminScreen: true, onPressed: () {}),
                Expanded(
                  child: MyContainer(
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //work details
                        BillDetails(
                          bill: bill,
                          cartController: billFactoryCartController,
                          billFactoryController: billFactoryController,
                        ),
                        //for height
                        SizedBox(
                          height: AppSizes.h02,
                        ),
                        //Midller Area
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: SearchAndSelectItems(
                                  itemController: itemController,
                                  ingredientController: ingredientController,
                                  cartController: billFactoryCartController,
                                  ingredientCartController:
                                      ingredientCartController,
                                  subStockCartController:
                                      subStockCartController,
                                ),
                              ),

                              Expanded(
                                flex: 2,
                                child: CartItems(
                                  cartController: billFactoryCartController,
                                ),
                              ),

                              // ingredient Cart items
                              Expanded(
                                flex: 3,
                                child: WantedIngrediant(
                                  subStockCartControllerImp:
                                      subStockCartController,
                                  planItemControllerImp: planItemController,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //save and print buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // MyButton save
                            MyButton(
                              text: AppStrings.save,
                              minWidth: AppSizes.w25,
                              onPressed: () {
                                saveFunction();
                              },
                            ),
                            // print button
                            MyButton(
                              text: AppStrings.print,
                              minWidth: AppSizes.w25,
                              onPressed: () {
                                printBill(bill: bill);
                              },
                            ),
                            // deleteAll   buttons
                            MyButton(
                              text: AppStrings.deleteAll,
                              minWidth: AppSizes.w25,
                              onPressed: () {
                                ingredientCartController.clearCart();
                                billFactoryCartController.clearCart();
                                subStockCartController.clearCart();
                              },
                            ),
                            // prepareComponents button
                            MyButton(
                              text: AppStrings.prepareComponents,
                              minWidth: AppSizes.w25,
                              onPressed: () {
                                if (billFactoryCartController.myCarts.isEmpty ||
                                    ingredientCartController.myCarts.isEmpty) {
                                  MySnackBar.snack(AppStrings.emptyList, '');
                                } else {
                                  subStockCartController.addListToUniqeCart(
                                    items: ingredientCartController.myCarts,
                                  );
                                  subStockCartController
                                      .prepareStockListToUniqeCart(
                                    items: itemController.componetsItemsList,
                                  );
                                }
                              },
                            ),
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

  Future<void> printBill({required Bill bill}) async {
    await billFactoryController.getBillsFactory();
    planController.itemsProd.clear();
    planController.itemsCom.clear();
    List itemsF = billFactoryCartController.myCarts.keys.toList();
    List itemsS = subStockCartController.myFinalUniqeCarts.values.toList();
    for (int i = 0; i < itemsF.length; i++) {
      planController.itemsProd.add(
        [
          double.parse(billFactoryCartController.myCarts.values
                  .toList()[i]
                  .toString())
              .toStringAsFixed(3),
          itemsF[i].itemNum,
          itemsF[i].itemName
        ],
      );
    }
    for (int i = 0; i < itemsS.length; i++) {
      planController.itemsCom.add(
        [
          double.parse(itemsS[i].itemCount.toString()).toStringAsFixed(3),
          itemsS[i].itemNum,
          itemsS[i].itemName,
        ],
      );
    }
    printPlan(
      billDate: billFactoryController.billDate.isEmpty
          ? DateFormat.yMMMMEEEEd('ar').format(DateTime.now())
          : DateFormat.yMMMMEEEEd('ar')
              .format(billFactoryController.date.value),
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

  Future<void> saveFunction() async {
    {
      await billFactoryController.getBillsFactory();
      var bill = billFactoryController.billsFactoryListReversed[0];
      var plan = planController.plansListReversed[1];
      if (billFactoryCartController.myCarts.isEmpty) {
        MySnackBar.snack(AppStrings.emptyList, '');
      } else if (subStockCartController.isFound!.contains(true)) {
        MySnackBar.snack(AppStrings.orderdQuantityNotFound, '');
      } else if (!subStockCartController.prepared.value) {
        MySnackBar.snack(AppStrings.pleasePrepareList, '');
      } else if (double.parse(
              billFactoryCartController.getTotalWight.toString()) <=
          0) {
        MySnackBar.snack(AppStrings.emptyWigt, '');
      } else {
        //*************************add proudcts***********************
        List items = billFactoryCartController.myCarts.values.toList();
        for (int i = 0; i < items.length; i++) {
          await billFactoryItemController.addItems(
            billId: bill.billId.toString(),
            item: items[i],
            kind: '2',
            planId: plan.id.toString(),
            time: billFactoryController.billDate.value.isEmpty
                ? '${billFactoryController.formatter.format(billFactoryController.now)} ${DateTime.now().hour}:${DateTime.now().minute}:00'
                : billFactoryController.billDate.value.toString(),
          );
          await itemController.updateWightStock(
            itemNum: items[i].itemNum,
            quantity:
                '${billFactoryCartController.controllersWight![i]}.${billFactoryCartController.controllersDigitsWight![i]}',
          );
        }
        await itemController.updateStockItemsGroupForUniqList(
          items: items,
          kind: 1,
        );
        //*************************add ingredient***********************
        List ingredientItems =
            subStockCartController.myFinalUniqeCarts.values.toList();
        for (int i = 0; i < ingredientItems.length; i++) {
          await billFactoryItemController.addItems(
            planId: plan.id.toString(),
            item: ingredientItems[i],
            kind: '1',
            billId: bill.billId.toString(),
            time: billFactoryController.billDate.value.isEmpty
                ? '${billFactoryController.formatter.format(billFactoryController.now)} ${DateTime.now().hour}:${DateTime.now().minute}:00'
                : billFactoryController.billDate.value.toString(),
          );
        }
        await itemController.updateSubStockItemsGroupForUniqList(
          items: ingredientItems,
          kind: 2,
        );

        //*************************update plan***********************
        await planController.updatePlan(
          id: plan.id.toString(),
          exghange: '0.0',
          componentsDone:
              subStockCartController.finalCartsWanted.value.toString(),
          proudctsDone: items.length.toString(),
        );
        // compontents
        for (int index = 0; index < ingredientItems.length; index++) {
          await planItemController.updatePlanItem(
            itemNum: ingredientItems[index].itemNum,
            planId: plan.id.toString(),
            exCahnge: '0.0',
            used: double.parse(ingredientItems[index].itemCount).toString(),
            done: '0.0',
            itemQuantWight: '0.0',
          );
        }
        // proudcts
        for (int index = 0; index < items.length; index++) {
          await planItemController.updatePlanItem(
            itemNum: items[index].itemNum,
            planId: plan.id.toString(),
            exCahnge: '0.0',
            used: '0.0',
            done: billFactoryCartController.myCarts.values
                .toList()[index]
                .itemCount
                .toString(),
            itemQuantWight: billFactoryCartController.myCarts.values
                .toList()[index]
                .itemQuantWight
                .toString(),
          );
        }
        //*************************save Bill***********************
        await billFactoryController.saveBillFactory(
          id: bill.billId.toString(),
          total: double.parse(
                  billFactoryCartController.getNumberOfPieces.toString())
              .toString(),
          numberOfItems: billFactoryCartController.myCarts.length.toString(),
          kind: '1',
          planId: plan.id.toString(),
        );
        //*************************add new Bill***********************
        await billFactoryController.addBillFactory();
        await planController.getPlans();
        subStockCartController.clearCart();
        ingredientCartController.clearCart();
        billFactoryCartController.clearCart();
      }
    }
  }
}

class SearchAndSelectItems extends StatelessWidget {
  const SearchAndSelectItems({
    super.key,
    required this.itemController,
    required this.ingredientController,
    required this.cartController,
    required this.ingredientCartController,
    required this.subStockCartController,
  });

  final ItemControllerImp itemController;
  final IngredientControllerImp ingredientController;
  final IngredientCartControllerImp ingredientCartController;
  final BillFactoryCartControllerImp cartController;
  final SubStockCartControllerImp subStockCartController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //search  items
        SizedBox(
          child: MyTextField(
            controller: itemController.searchTextField,
            validate: (val) {},
            label: AppStrings.itemName,
            hidePassword: false,
            onChanged: (val) {
              itemController.search(searchName: val, kind: 2);
            },
            onSubmite: (val) {
              itemController.search(searchName: val, kind: 2);
            },
          ),
        ),
        //for height
        SizedBox(
          height: AppSizes.h02,
        ),
        //items
        Expanded(
          child: Obx(
            () {
              if (itemController.isLoading.value) {
                return const MyLottieLoading();
              } else {
                if (itemController.searchItemsList.isEmpty &&
                    itemController.name.text.isNotEmpty) {
                  return const MyLottieEmpty();
                } else {
                  return ListView.separated(
                    itemCount: itemController.searchItemsList.length,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        thickness: 2,
                      );
                    },
                    itemBuilder: (context, index) {
                      var item = itemController.searchItemsList[index];
                      return GestureDetector(
                        onTap: () {
                          if (item.kind == 2) {
                            ingredientController.sortIngredients(
                                productId: item.ingredientsNumber);
                            ingredientCartController.addAllToCarts(
                                ingredientController.productsIngredientsList);
                            cartController.addToCarts(item: item);
                            subStockCartController.clearCart();
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
      ],
    );
  }
}

class CartItems extends StatelessWidget {
  const CartItems({
    super.key,
    required this.cartController,
  });

  final BillFactoryCartControllerImp cartController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (cartController.myCarts.isEmpty) {
        return Center(
          child: Text(
            AppStrings.emptyList,
            style: context.textTheme.titleSmall,
          ),
        );
      } else {
        return Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: AppSizes.w3,
                ),
                // scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return BillFactoryCartItem(
                    index: index,
                    billFactoryItem:
                        cartController.myCarts.values.toList()[index],
                    // quantity: cartController.myCarts.values.toList()[index],
                  );
                },
                itemCount: cartController.myCarts.length,
              ),
            ),
          ],
        );
      }
    });
  }
}

class WantedIngrediant extends StatelessWidget {
  const WantedIngrediant(
      {super.key,
      required this.subStockCartControllerImp,
      required this.planItemControllerImp});
  final SubStockCartControllerImp subStockCartControllerImp;
  final PlanItemControllerImp planItemControllerImp;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
          color: context.theme.primaryColorLight,
        ),
      ),
      child: ListView(
        children: [
          // proudcts
          Column(
            children: [
              Text(
                AppStrings.products,
                style: Get.textTheme.displayLarge,
              ),
              WantedBillFactoryItem(
                isHeader: true,
                isProudct: true,
                index: 0,
              ),
              Obx(
                () {
                  if (planItemControllerImp.isLoading.value) {
                    return const MyLottieLoading();
                  } else {
                    if (planItemControllerImp.planItemsProuducts.isEmpty) {
                      return const SizedBox();
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            planItemControllerImp.planItemsProuducts.length,
                        itemBuilder: (context, index) {
                          Item item =
                              planItemControllerImp.planItemsProuducts[index];
                          return WantedBillFactoryItem(
                            item: item,
                            isHeader: false,
                            isProudct: true,
                            index: index,
                          );
                        },
                      );
                    }
                  }
                },
              ),
            ],
          ),
          // components
          Column(
            children: [
              Text(
                AppStrings.wantedComponents,
                style: Get.textTheme.displayLarge,
              ),
              WantedBillFactoryItem(
                isHeader: true,
                isProudct: false,
                index: 0,
              ),
              Obx(
                () {
                  if (subStockCartControllerImp.isLoading.value) {
                    return const MyLottieLoading();
                  } else {
                    if (subStockCartControllerImp.myFinalUniqeCarts.isEmpty) {
                      return const SizedBox();
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: subStockCartControllerImp
                            .myFinalUniqeCarts.keys
                            .toList()
                            .length,
                        itemBuilder: (context, index) {
                          Item item = subStockCartControllerImp
                              .myFinalUniqeCarts.values
                              .toList()[index];

                          return WantedBillFactoryItem(
                            item: item,
                            isHeader: false,
                            isProudct: false,
                            index: index,
                          );
                        },
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BillDetails extends StatelessWidget {
  const BillDetails({
    super.key,
    required this.bill,
    required this.cartController,
    required this.billFactoryController,
  });

  final Bill bill;
  final BillFactoryCartControllerImp cartController;
  final BillFactoryControllerImp billFactoryController;

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
                  '${AppStrings.billFactoryNumper} : ${bill.billId}',
                  style: context.textTheme.displayLarge,
                ),
                Text(
                  ' ${AppStrings.numberOfitems} : ${cartController.myCarts.length}',
                  style: context.textTheme.displayLarge,
                ),
                Text(
                  '${AppStrings.date} : ${billFactoryController.billDate}',
                  style: context.textTheme.displayLarge,
                ),
                IconButton(
                  onPressed: () {
                    billFactoryController.setBillDate(context: context);
                  },
                  icon: const Icon(Icons.calendar_month),
                )
              ],
            ),
            SizedBox(
              height: AppSizes.h01,
            ),
            Row(
              children: [
                Expanded(
                  child: MyTextField(
                    controller: billFactoryController.billNotesController,
                    validate: (val) {},
                    label: AppStrings.notes,
                    hidePassword: false,
                    onChanged: (val) {},
                    onSubmite: (val) {},
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${AppStrings.total}  :  ${double.parse(cartController.getNumberOfPieces.toString())} ${AppStrings.product}',
                        style: context.textTheme.bodySmall,
                      ),
                      Text(
                        '${AppStrings.wight}  :  ${double.parse(cartController.getTotalWight.toString())} ${AppStrings.kgm}',
                        style: context.textTheme.bodySmall,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
