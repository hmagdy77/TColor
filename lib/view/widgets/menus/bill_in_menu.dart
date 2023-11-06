import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/bill_in/bill_in_cart.dart';
import '../../../controllers/bill_in/bill_in_controller.dart';
import '../../../controllers/items/item_controller.dart';
import '../../../core/constants/app_strings.dart';
import '../../../routes.dart';
import '../drop_menu/drop_menu.dart';

class BillInMenu extends StatelessWidget {
  BillInMenu({
    super.key,
  });
  final List bodyItems = [
    AppStrings.addBillIn,
    AppStrings.backBillIn,
    AppStrings.viewTheBills,
    AppStrings.billInReports,
  ];
  final BillInControllerImp billInController = Get.find<BillInControllerImp>();
  final BillInCartControllerImp cartController =
      Get.find<BillInCartControllerImp>();
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();

  @override
  Widget build(BuildContext context) {
    return MyDropMenu(
      label: AppStrings.billIn,
      bodyItems: bodyItems,
      onChanged: (value) async {
        await itemController.getItems();
        cartController.clearCart();
        switch (value) {
          case AppStrings.addBillIn:
            Get.offAllNamed(AppRoutes.addBillInScreen);
            break;
          case AppStrings.backBillIn:
            Get.offAllNamed(AppRoutes.addBackBillInScreen);
            break;
          case AppStrings.viewTheBills:
            await billInController.getBillsIn();
            Get.offAllNamed(AppRoutes.searchBillInScreen);
            break;
          case AppStrings.billInReports:
            Get.offAllNamed(AppRoutes.reportBillInScreen);
            break;
          default:
            Get.offAllNamed(AppRoutes.mainScreen);
        }
      },
    );
  }
}
