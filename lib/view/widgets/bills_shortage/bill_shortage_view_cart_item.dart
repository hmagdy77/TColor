import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/sub_string.dart';
import '../../../data/models/items/item_model.dart';

// ignore: must_be_immutable
class BillLocalCartItem extends StatelessWidget {
  const BillLocalCartItem({
    Key? key,
    required this.item,
  }) : super(key: key);
  final Item item;
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
        color: item.kind == 1 || item.kind == 3
            ? AppColorManger.primary
            : AppColorManger.grey,
      ),
      width: AppSizes.w25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            item.itemName.maxLength(18),
            style: Get.textTheme.displaySmall,
            textAlign: TextAlign.start,
          ),
          Text(
            item.itemNum.maxLength(18),
            style: Get.textTheme.displaySmall,
            textAlign: TextAlign.start,
          ),
          Text(
            '${AppStrings.itemQuantity} : ${item.itemCount} ${AppStrings.kgm}',
            style: context.textTheme.displaySmall,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
