import 'package:intl/intl.dart';

import '../../../../controllers/items/item_controller.dart';
import '../../../controllers/ingredients/ingredients_cart_controller.dart';
import '../../../controllers/ingredients/ingredients_controller.dart';
import '../../../controllers/plans/plan_cart.dart';
import '../../../controllers/plans/plan_controller.dart';
import '../../../controllers/plans/plan_item_controller.dart';
import '../../../controllers/sub_stock/sub_stock_cart.dart';
import '../../../core/print/pdf_plan.dart';
import '../../../data/models/items/item_model.dart';
import '../../../data/models/plans/plan_model.dart';
import '../../../libraries.dart';
import '../../widgets/items/item_widget.dart';
import '../../widgets/login/snackbar.dart';
import '../../widgets/lottie/empty.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/plans/plan_cart_item.dart';
import '../../widgets/plans/wanted_item_widget.dart';

class AddPlanScreen extends StatelessWidget {
  AddPlanScreen({super.key});
// items
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();
  final IngredientControllerImp ingredientController =
      Get.find<IngredientControllerImp>();
  final IngredientCartControllerImp ingredientCartController =
      Get.find<IngredientCartControllerImp>();
//Plan
  final PlanControllerImp planController = Get.find<PlanControllerImp>();
  final PlanItemControllerImp planItemController =
      Get.find<PlanItemControllerImp>();
  final PlanCartControllerImp planCartController =
      Get.find<PlanCartControllerImp>();
// sub Stock
  final SubStockCartControllerImp subStockCartController =
      Get.find<SubStockCartControllerImp>();

// myservice
  final MyService myService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (itemController.isLoading.value ||
              planController.isLoading.value ||
              planItemController.isLoading.value ||
              planCartController.isLoading.value) {
            return const MyLottieLoading();
          } else {
            var plan = planController.plansListReversed[0];
            return Column(
              children: [
                UpperWidget(isAdminScreen: true, onPressed: () {}),
                Expanded(
                  child: MyContainer(
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //work details
                        PlanDetails(
                            plan: plan,
                            cartController: planCartController,
                            planController: planController),
                        //for height
                        SizedBox(
                          height: AppSizes.h02,
                        ),
                        // agent phone and number
                        PlanInfo(
                          planController: planController,
                          planCartController: planCartController,
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
                                  cartController: planCartController,
                                  ingredientCartController:
                                      ingredientCartController,
                                  subStockCartController:
                                      subStockCartController,
                                ),
                              ),
                              SizedBox(
                                width: AppSizes.w01,
                              ),
                              // cart items
                              Expanded(
                                  flex: 2,
                                  child: CartItems(
                                      cartController: planCartController)),
                              SizedBox(
                                width: AppSizes.w01,
                              ),
                              // ingredient Cart items
                              Expanded(
                                flex: 3,
                                child: WantedIngrediant(
                                  subStockCartControllerImp:
                                      subStockCartController,
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
                                printFunction(plan: plan);
                              },
                            ),
                            // deleteAll   buttons
                            MyButton(
                              text: AppStrings.deleteAll,
                              minWidth: AppSizes.w25,
                              onPressed: () {
                                ingredientCartController.clearCart();
                                planCartController.clearCart();
                                subStockCartController.clearCart();
                              },
                            ),
                            MyButton(
                              text: AppStrings.prepareComponents,
                              minWidth: AppSizes.w25,
                              onPressed: () {
                                if (planCartController.myCarts.isEmpty ||
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

  Future<void> printFunction({required Plans plan}) async {
    await planController.getPlans();
    planController.itemsProd.clear();
    planController.itemsCom.clear();
    List itemsF = planCartController.myCarts.keys.toList();
    List itemsS = subStockCartController.myFinalUniqeCarts.values.toList();
    for (int i = 0; i < itemsF.length; i++) {
      planController.itemsProd.add(
        [
          double.parse(planCartController.myCarts.values.toList()[i].toString())
              .toStringAsFixed(3),
          itemsF[i].itemNum,
          itemsF[i].itemName
        ],
      );
    }
    for (int i = 0; i < itemsS.length; i++) {
      planController.itemsCom.add(
        [
          double.parse(itemsS[i].itemQuant).toStringAsFixed(3),
          double.parse(itemsS[i].itemSubQuant).toStringAsFixed(3),
          double.parse(itemsS[i].itemCount).toStringAsFixed(3),
          itemsS[i].itemNum,
          itemsS[i].itemName,
        ],
      );
    }
    printPlan(
      billDate: DateFormat.yMMMMEEEEd('ar').format(DateTime.now()),
      billNumber: '0',
      itemsF: planController.itemsProd,
      columsF: [
        AppStrings.wanted,
        AppStrings.itemNum,
        AppStrings.itemName,
      ],
      columsS: [
        AppStrings.main,
        AppStrings.subStock,
        AppStrings.wanted,
        AppStrings.itemNum,
        AppStrings.itemName,
      ],
      itemsS: planController.itemsCom,
      label: '${AppStrings.planNumper} ${plan.id}',
      kind: '2',
      total: '0',
    );
  }

  Future<void> saveFunction() async {
    {
      await planController.getPlans();
      var plan = planController.plansListReversed[0];
      if (planCartController.myCarts.isEmpty) {
        MySnackBar.snack(AppStrings.emptyList, '');
      } else if (planCartController.isOverd!.contains(true)) {
        MySnackBar.snack(AppStrings.orderdQuantityNotFound, '');
      } else if (!subStockCartController.prepared.value) {
        MySnackBar.snack(AppStrings.pleasePrepareList, '');
        // subStockCartControllerImp
        //                             .myFinalUniqeCarts
      } else {
        // add proudcts
        List items = planCartController.myCarts.keys.toList();
        for (int i = 0; i < items.length; i++) {
          await planItemController.addPlanItem(
            planId: plan.id.toString(),
            item: items[i],
            itemCount: planCartController.myCarts.values.toList()[i],
            kind: 2,
          );
        }

        // add ingredient
        List ingredientItems =
            subStockCartController.myFinalUniqeCarts.values.toList();
        for (int i = 0; i < ingredientItems.length; i++) {
          await planItemController.addPlanItem(
            planId: plan.id.toString(),
            item: ingredientItems[i],
            itemCount: double.parse(ingredientItems[i].itemCount),
            kind: 1,
          );
        }
        // savePlan
        await planController.savePlan(
          id: plan.id.toString(),
          components: subStockCartController.finalCartsWanted.toString(),
          proudcts:
              double.parse(planCartController.getNumberOfPieces.toString())
                  .toString(),
        );
        // add new Plan
        await planController.addPlan();
        subStockCartController.clearCart();
        ingredientCartController.clearCart();
        planCartController.clearCart();
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
  final PlanCartControllerImp cartController;
  final SubStockCartControllerImp subStockCartController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //search  items
        MyTextField(
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

  final PlanCartControllerImp cartController;

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
                    maxCrossAxisExtent: AppSizes.w25,
                  ),
                  // scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return PlanCartItem(
                      index: index,
                      planItem: cartController.myCarts.keys.toList()[index],
                      quantity: cartController.myCarts.values.toList()[index],
                    );
                  },
                  itemCount: cartController.myCarts.length),
            ),
          ],
        );
      }
    });
  }
}

class WantedIngrediant extends StatelessWidget {
  const WantedIngrediant({super.key, required this.subStockCartControllerImp});
  final SubStockCartControllerImp subStockCartControllerImp;

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
      child: Column(
        children: [
          Text(
            AppStrings.wantedComponents,
            style: Get.textTheme.displayLarge,
          ),
          WantedItemWidget(
            isHeader: true,
            isProudct: false,
            index: 0,
            inView: false,
          ),
          Obx(
            () {
              if (subStockCartControllerImp.isLoading.value) {
                return const MyLottieLoading();
              } else {
                if (subStockCartControllerImp.myFinalUniqeCarts.isEmpty) {
                  return const SizedBox();
                } else {
                  return Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: subStockCartControllerImp
                                .myFinalUniqeCarts.keys
                                .toList()
                                .length,
                            itemBuilder: (context, index) {
                              Item item = subStockCartControllerImp
                                  .myFinalUniqeCarts.values
                                  .toList()[index];
                              return WantedItemWidget(
                                item: item,
                                isHeader: false,
                                isProudct: false,
                                index: index,
                                inView: false,
                              );
                            },
                          ),
                        ),
                        WantedItemWidget(
                          isHeader: true,
                          isProudct: false,
                          index: 0,
                          name: AppStrings.total,
                          code: subStockCartControllerImp
                              .myFinalUniqeCarts.length
                              .toString(),
                          wanted: subStockCartControllerImp.finalCartsWanted
                              .toStringAsFixed(3),
                          sub: subStockCartControllerImp.finalCartsSubQuant
                              .toStringAsFixed(3),
                          main: subStockCartControllerImp.finalCartsMainQuant
                              .toStringAsFixed(3),
                          inView: false,
                        ),
                      ],
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}

class PlanInfo extends StatelessWidget {
  const PlanInfo({
    super.key,
    required this.planController,
    required this.planCartController,
  });

  final PlanControllerImp planController;
  final PlanCartControllerImp planCartController;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // agentNameController
            Expanded(
              flex: 2,
              child: MyTextField(
                controller: planController.nameTextField,
                validate: (val) {
                  return validInput(
                    max: 80,
                    min: 1,
                    type: AppStrings.validateAdmin,
                    val: val,
                  );
                },
                label: AppStrings.planName,
                hidePassword: false,
              ),
            ),
            //  for width
            SizedBox(
              width: AppSizes.w05,
            ),
            Expanded(
              flex: 3,
              child: MyTextField(
                controller: planController.descriptionTextField,
                validate: (val) {
                  return validInput(
                    max: 80,
                    min: 1,
                    type: AppStrings.validateAdmin,
                    val: val,
                  );
                },
                label: AppStrings.plandesc,
                hidePassword: false,
              ),
            ),
            SizedBox(
              width: AppSizes.w05,
            ),
            Text(
              '${AppStrings.total}  :  ${double.parse(planCartController.getNumberOfPieces.toString())} ${AppStrings.product}',
              style: context.textTheme.bodySmall,
            ),
            SizedBox(
              width: AppSizes.w05,
            ),
          ],
        ));
  }
}

class PlanDetails extends StatelessWidget {
  const PlanDetails({
    super.key,
    required this.plan,
    required this.cartController,
    required this.planController,
  });

  final Plans plan;
  final PlanCartControllerImp cartController;
  final PlanControllerImp planController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '${AppStrings.planNumper} : ${plan.id}',
              style: context.textTheme.displayLarge,
            ),
            Text(
              ' ${AppStrings.numberOfitems} : ${cartController.myCarts.length}',
              style: context.textTheme.displayLarge,
            ),
            Text(
              '${AppStrings.date} : ${planController.formatter.format(DateTime.now())}',
              style: context.textTheme.displayLarge,
            ),
          ],
        );
      },
    );
  }
}
