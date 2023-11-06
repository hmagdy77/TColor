import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/bill_in/bill_in_cart.dart';
import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/sub_string.dart';
import '../../../data/models/items/item_model.dart';
import '../text_fields/my_number_field.dart';

// ignore: must_be_immutable
class BillInCartItem extends StatelessWidget {
  BillInCartItem({
    Key? key,
    required this.index,
    required this.billInItem,
    required this.quantity,
    required this.inEdit,
    required this.isBack,
  }) : super(key: key);
  final BillInCartControllerImp cartController =
      Get.find<BillInCartControllerImp>();
  final int index;
  final bool inEdit;
  final bool isBack;
  final Item billInItem;
  double quantity;
  @override
  Widget build(BuildContext context) {
    // int? isAdmin =
    //     cartController.myService.sharedPreferences.getInt(AppStrings.adminKey);
    return Container(
      margin: EdgeInsets.only(
        left: AppSizes.w01,
        top: AppSizes.w01,
      ),
      padding: EdgeInsets.only(top: AppSizes.w01, right: AppSizes.w01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: cartController.isOverd![index]
            ? AppColorManger.greyLight
            : AppColorManger.primary,
      ),
      width: AppSizes.w25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            billInItem.itemName.maxLength(18),
            style: Get.textTheme.displaySmall,
            textAlign: TextAlign.start,
          ),
          inEdit
              ? Text(
                  billInItem.itemNum.maxLength(18),
                  style: Get.textTheme.displaySmall,
                  textAlign: TextAlign.start,
                )
              : Text(
                  '${AppStrings.avilable} : ${billInItem.itemQuant.maxLength(6)}',
                  style: Get.textTheme.displaySmall,
                  textAlign: TextAlign.start,
                ),
          inEdit
              ? Text(
                  '${AppStrings.itemQuantity} : ${billInItem.itemCount}',
                  style: Get.textTheme.displaySmall,
                  textAlign: TextAlign.start,
                )
              : const SizedBox(),
          Text(
            '${AppStrings.itemPriceIn} : ${billInItem.itemPriceIn.maxLength(6)}',
            style: context.textTheme.displaySmall,
            textAlign: TextAlign.start,
          ),
          inEdit
              ? Text(
                  '${AppStrings.itemQuantity} : ${(double.parse(billInItem.itemPriceIn) * double.parse(billInItem.itemCount))}',
                  style: Get.textTheme.displaySmall,
                  textAlign: TextAlign.start,
                )
              : Text(
                  '${AppStrings.total} : ${(double.parse(billInItem.itemPriceIn) * quantity)}',
                  style: context.textTheme.displaySmall,
                  textAlign: TextAlign.start,
                ),
          const Spacer(),
          inEdit
              ? const SizedBox()
              : Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        cartController.removeOneProduct(billInItem, index);
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
                                controller:
                                    cartController.controllersDigits![index],
                                onChange: (val) {
                                  if (val.isEmpty ||
                                      cartController
                                          .controllers![index].text.isEmpty) {
                                  } else {
                                    cartController.updateQuantity(
                                      item: billInItem,
                                      quantityDigit: int.parse(val),
                                      quantity: int.parse(cartController
                                          .controllers![index].text),
                                    );
                                  }
                                },
                                onSubmit: (val) {
                                  if (val.isEmpty ||
                                      cartController
                                          .controllers![index].text.isEmpty) {
                                  } else {
                                    cartController.updateQuantity(
                                      item: billInItem,
                                      quantityDigit: int.parse(val),
                                      quantity: int.parse(cartController
                                          .controllers![index].text),
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
                                      cartController.controllersDigits![index]
                                          .text.isEmpty) {
                                  } else {
                                    cartController.updateQuantity(
                                      item: billInItem,
                                      quantity: int.parse(val),
                                      quantityDigit: int.parse(cartController
                                          .controllersDigits![index].text),
                                    );
                                  }
                                },
                                onSubmit: (val) {
                                  if (val.isEmpty ||
                                      cartController.controllersDigits![index]
                                          .text.isEmpty) {
                                  } else {
                                    cartController.updateQuantity(
                                      item: billInItem,
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
