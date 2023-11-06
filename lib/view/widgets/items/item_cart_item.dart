import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/bill_stock/bill_stock_cart.dart';
import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/sub_string.dart';
import '../../../data/models/items/item_model.dart';
import '../text_fields/my_number_field.dart';

// ignore: must_be_immutable
class ItemCart extends StatelessWidget {
  ItemCart({
    Key? key,
    required this.index,
    required this.item,
    required this.quantity,
    required this.isMain,
  }) : super(key: key);
  final BillStockCartControllerImp cartController =
      Get.find<BillStockCartControllerImp>();
  final int index;
  final Item item;
  final bool isMain;
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
            ? AppColorManger.grey
            : AppColorManger.primary,
      ),
      width: AppSizes.w25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.itemName.maxLength(18),
            style: Get.textTheme.displayMedium,
            textAlign: TextAlign.start,
          ),
          Text(
            item.itemNum,
            style: Get.textTheme.displayMedium,
            textAlign: TextAlign.start,
          ),
          // Text(
          //   '${AppStrings.itemPriceIn} : ${item.itemPriceIn}',
          //   style: context.textTheme.displayMedium,
          //   textAlign: TextAlign.start,
          // ),
          // Text(
          //   '${AppStrings.total} : ${cartController.supTotal[index].toString().maxLength(6)}',
          //   style: context.textTheme.displayMedium,
          //   textAlign: TextAlign.start,
          // ),
          Text(
            '${AppStrings.avilable} : ${isMain ? item.itemQuant.maxLength(6) : item.itemSubQuant.maxLength(6)}',
            style: context.textTheme.displayMedium,
            textAlign: TextAlign.start,
          ),
          const Spacer(),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  cartController.removeOneProduct(item, index);
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
                                item: item,
                                quantityDigit: int.parse(val),
                                quantity: quantity1,
                              );
                              var quantityValue =
                                  double.parse('$quantity1.$val');
                              var quantity = 0.0;
                              if (isMain) {
                                quantity = double.parse(item.itemQuant);
                              } else {
                                quantity = double.parse(item.itemSubQuant);
                              }
                              if (quantity < quantityValue) {
                                cartController.isOverd![index] = true;
                              } else if (quantity >= quantityValue) {
                                cartController.isOverd![index] = false;
                              }
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
                                item: item,
                                quantityDigit: int.parse(val),
                                quantity: quantity1,
                              );
                              var quantityValue =
                                  double.parse('$quantity1.$val');
                              // var quantity = double.parse(item.itemQuant);
                              var quantity = 0.0;
                              if (isMain) {
                                quantity = double.parse(item.itemQuant);
                              } else {
                                quantity = double.parse(item.itemSubQuant);
                              }
                              if (quantity < quantityValue) {
                                cartController.isOverd![index] = true;
                              } else if (quantity >= quantityValue) {
                                cartController.isOverd![index] = false;
                              }
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
                                item: item,
                                quantity: int.parse(val),
                                quantityDigit: quantity1,
                              );
                              var quantityValue =
                                  double.parse('$val.$quantity1');
                              // var quantity = double.parse(item.itemQuant);
                              var quantity = 0.0;
                              if (isMain) {
                                quantity = double.parse(item.itemQuant);
                              } else {
                                quantity = double.parse(item.itemSubQuant);
                              }
                              if (quantity < quantityValue) {
                                cartController.isOverd![index] = true;
                              } else if (quantity >= quantityValue) {
                                cartController.isOverd![index] = false;
                              }
                            }
                          },
                          onSubmit: (val) {
                            if (val.isEmpty ||
                                cartController
                                    .controllersDigits![index].text.isEmpty) {
                            } else {
                              cartController.updateQuantity(
                                  item: item,
                                  quantity: int.parse(val),
                                  quantityDigit: int.parse(cartController
                                      .controllersDigits![index].text));
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
