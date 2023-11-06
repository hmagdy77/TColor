import '../../../controllers/ingredients/ingredients_cart_controller.dart';
import '../../../controllers/ingredients/ingredients_controller.dart';
import '../../../controllers/plans/plan_cart.dart';
import '../../../controllers/sub_stock/sub_stock_cart.dart';
import '../../../data/models/items/item_model.dart';
import '../../../libraries.dart';

// ignore: must_be_immutable
class PlanCartItem extends StatelessWidget {
  PlanCartItem({
    Key? key,
    required this.index,
    required this.planItem,
    required this.quantity,
  }) : super(key: key);
  final int index;
  double quantity;
  final Item planItem;
  final PlanCartControllerImp cartController =
      Get.find<PlanCartControllerImp>();
  final IngredientCartControllerImp ingredientCartController =
      Get.find<IngredientCartControllerImp>();
  final IngredientControllerImp ingredientController =
      Get.find<IngredientControllerImp>();
  final SubStockCartControllerImp subStockCartController =
      Get.find<SubStockCartControllerImp>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: AppSizes.w01,
        left: AppSizes.w01,
        top: AppSizes.w01,
      ),
      padding: EdgeInsets.only(top: AppSizes.w01, right: AppSizes.w01),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: cartController.isOverd![index]
              ? AppColorManger.greyLight
              : AppColorManger.primary),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${AppStrings.itemName} : ${planItem.itemName.maxLength(8)}',
            style: Get.textTheme.displayMedium!.copyWith(fontSize: 12),
            textAlign: TextAlign.start,
          ),
          Text(
            '${AppStrings.itemNum} : ${planItem.itemNum.maxLength(8)}',
            style: Get.textTheme.displayMedium!.copyWith(fontSize: 12),
            textAlign: TextAlign.start,
          ),
          const Spacer(),
          Row(
            children: [
              IconButton(
                // onPressed: () {
                //   cartController.removeOneProduct(PlanItem, index);
                // },
                onPressed: () {
                  ingredientController.sortIngredients(
                      productId: planItem.ingredientsNumber);
                  ingredientCartController.removeGroupProduct(
                      ingredients:
                          ingredientController.productsIngredientsList);
                  cartController.removeOneProduct(item: planItem, index: index);
                  subStockCartController.clearCart();
                },
                icon: Icon(
                  Icons.delete,
                  color: context.theme.primaryColorDark,
                  size: AppSizes.h03,
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: AppSizes.h03,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: MyNumberField(
                          withDot: false,
                          label: '',
                          hint: '0',
                          controller: cartController.controllersDigits![index],
                          onChange: (val) {
                            if (val.isEmpty ||
                                cartController
                                    .controllers![index].text.isEmpty) {
                            } else {
                              int quantity1 = int.parse(
                                  cartController.controllers![index].text);
                              cartController.updateQuantity(
                                item: planItem,
                                quantityDigit: int.parse(val),
                                quantity: quantity1,
                              );
                              ingredientController.sortIngredients(
                                  productId: planItem.ingredientsNumber);
                              ingredientCartController
                                  .updateQuantityForAllCarts(
                                ingredients: ingredientController
                                    .productsIngredientsList,
                                quantity: quantity1,
                                digitQuantity: int.parse(val),
                              );
                              subStockCartController.clearCart();
                            }
                          },
                          onSubmit: (val) {
                            if (val.isEmpty ||
                                cartController
                                    .controllers![index].text.isEmpty) {
                            } else {
                              int quantity1 = int.parse(
                                  cartController.controllers![index].text);
                              cartController.updateQuantity(
                                item: planItem,
                                quantityDigit: int.parse(val),
                                quantity: quantity1,
                              );
                              ingredientController.sortIngredients(
                                  productId: planItem.ingredientsNumber);
                              ingredientCartController
                                  .updateQuantityForAllCarts(
                                ingredients: ingredientController
                                    .productsIngredientsList,
                                quantity: quantity1,
                                digitQuantity: int.parse(val),
                              );
                              subStockCartController.clearCart();
                            }
                          },
                        ),
                      ),
                      Text(
                        ' / ',
                        style: TextStyle(
                            color: AppColorManger.black, fontSize: 10),
                      ),
                      Expanded(
                        flex: 2,
                        child: MyNumberField(
                          withDot: false,
                          label: '',
                          hint: '1',
                          controller: cartController.controllers![index],
                          onChange: (val) {
                            if (val.isEmpty ||
                                cartController
                                    .controllersDigits![index].text.isEmpty) {
                            } else {
                              int quantity1 = int.parse(cartController
                                  .controllersDigits![index].text);
                              cartController.updateQuantity(
                                item: planItem,
                                quantity: int.parse(val),
                                quantityDigit: quantity1,
                              );
                              ingredientController.sortIngredients(
                                  productId: planItem.ingredientsNumber);
                              ingredientCartController
                                  .updateQuantityForAllCarts(
                                ingredients: ingredientController
                                    .productsIngredientsList,
                                quantity: int.parse(val),
                                digitQuantity: quantity1,
                              );
                              subStockCartController.clearCart();
                            }
                          },
                          onSubmit: (val) {
                            if (val.isEmpty ||
                                cartController
                                    .controllersDigits![index].text.isEmpty) {
                            } else {
                              var quantity1 = int.parse(cartController
                                  .controllersDigits![index].text);
                              cartController.updateQuantity(
                                item: planItem,
                                quantity: int.parse(val),
                                quantityDigit: quantity1,
                              );
                              ingredientController.sortIngredients(
                                  productId: planItem.ingredientsNumber);
                              ingredientCartController
                                  .updateQuantityForAllCarts(
                                ingredients: ingredientController
                                    .productsIngredientsList,
                                quantity: int.parse(val),
                                digitQuantity: quantity1,
                              );
                              subStockCartController.clearCart();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



  // 
  //         inEdit
  //             ? Center(
  //                 child: Container(
  //                   margin: const EdgeInsets.only(bottom: 10),
  //                   height: AppSizes.h03,
  //                   width: AppSizes.w1,
  //                   child: MyNumberField(
  //                     label: '',
  //                     hint: '1',
  //                     controller: cartController.controllers![index],
  //                     onChange: (val) {
  //                       if (val.isNum) {
  //                         cartController.updateQuantity(
  //                             PlanItem, int.parse(val));
  //                       } else {}
  //                     },
  //                     onSubmit: (val) {
  //                       if (val.isEmpty) {
  //                       } else {
  //                         cartController.updateQuantity(
  //                             PlanItem, int.parse(val));
  //                       }
  //                     },
  //                   ),
  //                 ),
  //               )
  //             : Row(
  //                 children: [
  //                   IconButton(
  //                     onPressed: () {
  //                       ingredientController.sortIngredients(
  //                           productId: PlanItem.ingredientsNumber);
  //                       ingredientCartController.removeGroupProduct(
  //                           ingredients:
  //                               ingredientController.productsIngredientsList);
  //                       cartController.removeOneProduct(PlanItem, index);
  //                     },
  //                     icon: Icon(
  //                       Icons.delete,
  //                       color: context.theme.primaryColorDark,
  //                       size: AppSizes.h03,
  //                     ),
  //                   ),
  //                   kind
  //                       ? SizedBox(
  //                           height: AppSizes.h03,
  //                           width: AppSizes.w1,
  //                           child: MyNumberField(
  //                             label: '',
  //                             hint: '1',
  //                             controller: cartController.controllers![index],
  //                             onChange: (val) {
  //                               if (val.isEmpty) {
  //                               } else {
  //                                 cartController.updateQuantity(
  //                                     PlanItem, int.parse(val));
  //                               }
  //                             },
  //                             onSubmit: (val) {
  //                               if (val.isEmpty) {
  //                               } else {
  //                                 cartController.updateQuantity(
  //                                     PlanItem, int.parse(val));
  //                               }
  //                             },
  //                           ),
  //                         )
  //                       : SizedBox(
  //                           height: AppSizes.h03,
  //                           width: AppSizes.w1,
  //                           child: MyNumberField(
  //                             label: '',
  //                             hint: quantity.toString(),
  //                             controller: cartController.controllers![index],
  //                             onChange: (val) {
  //                               if (val.isNum) {
  //                                 var quantityValue = int.parse(val);
  //                                 var quantity =
  //                                     double.parse(PlanItem.itemQuant);
  //                                 cartController.updateQuantity(
  //                                   PlanItem,
  //                                   int.parse(val),
  //                                 );
  //                                 // ingredientCartController
                                  
  //                                 if (quantity < quantityValue) {
  //                                   cartController.isOverd![index] = true;
  //                                 } else if (quantity >= quantityValue) {
  //                                   cartController.isOverd![index] = false;
  //                                 }
  //                               }
  //                             },
  //                             onSubmit: (val) {
  //                               if (val.isNum) {
  //                                 var quantityValue = int.parse(val);
  //                                 var quantity =
  //                                     double.parse(PlanItem.itemQuant);
  //                                 cartController.updateQuantity(
  //                                     PlanItem, int.parse(val));
  //                                 if (quantity < quantityValue) {
  //                                   cartController.isOverd![index] = true;
  //                                 } else if (quantity >= quantityValue) {
  //                                   cartController.isOverd![index] = false;
  //                                 }
  //                               }
  //                             },
  //                           ),
  //                         ),
  //                 ],
  //               ),
        