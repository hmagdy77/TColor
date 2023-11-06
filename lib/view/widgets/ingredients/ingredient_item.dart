import 'package:factori/controllers/ingredients/ingredients_cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/sub_string.dart';
import '../../../data/models/items/item_model.dart';
import '../text_fields/my_number_field.dart';

// ignore: must_be_immutable
class IngredientCartItem extends StatelessWidget {
  IngredientCartItem({
    Key? key,
    required this.index,
    required this.item,
    required this.quantity,
  }) : super(key: key);
  final int index;
  double quantity;
  final Item item;
  final IngredientCartControllerImp cartController =
      Get.find<IngredientCartControllerImp>();

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
        color: AppColorManger.primary,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${AppStrings.itemName} : ${item.itemName.maxLength(8)}',
            style: Get.textTheme.displaySmall,
            textAlign: TextAlign.start,
          ),
          Text(
            '${AppStrings.total} : ${cartController.proudctsIngredintTotalPrice[index].toString().maxLength(6)}',
            style: context.textTheme.displaySmall,
            textAlign: TextAlign.start,
          ),
          Text(
            '${AppStrings.itemPriceIn} : ${item.itemPriceIn}',
            style: context.textTheme.displaySmall,
            textAlign: TextAlign.start,
          ),
          Text(
            '${AppStrings.itemPriceOut} : ${item.itemPriceOut}',
            style: context.textTheme.displaySmall,
            textAlign: TextAlign.start,
          ),
          const Spacer(),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  cartController.removeFromIngredentsCarts(
                    ingredient: item,
                    index: index,
                  );
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
                              cartController.updateProudctsIngredintQuantity(
                                item: item,
                                quantityDigit: int.parse(val),
                                quantity: int.parse(
                                    cartController.controllers![index].text),
                              );
                            }
                          },
                          onSubmit: (val) {
                            if (val.isEmpty ||
                                cartController
                                    .controllers![index].text.isEmpty) {
                            } else {
                              cartController.updateProudctsIngredintQuantity(
                                item: item,
                                quantityDigit: int.parse(val),
                                quantity: int.parse(
                                    cartController.controllers![index].text),
                              );
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
                              cartController.updateProudctsIngredintQuantity(
                                item: item,
                                quantity: int.parse(val),
                                quantityDigit: int.parse(cartController
                                    .controllersDigits![index].text),
                              );
                            }
                          },
                          onSubmit: (val) {
                            if (val.isEmpty ||
                                cartController
                                    .controllersDigits![index].text.isEmpty) {
                            } else {
                              cartController.updateProudctsIngredintQuantity(
                                item: item,
                                quantity: int.parse(val),
                                quantityDigit: int.parse(cartController
                                    .controllersDigits![index].text),
                              );
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
