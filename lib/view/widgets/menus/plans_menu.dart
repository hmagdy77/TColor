import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/ingredients/ingredients_cart_controller.dart';
import '../../../controllers/ingredients/ingredients_controller.dart';
import '../../../controllers/items/item_controller.dart';
import '../../../controllers/plans/plan_cart.dart';
import '../../../controllers/plans/plan_controller.dart';
import '../../../controllers/sub_stock/sub_stock_cart.dart';
import '../../../core/constants/app_strings.dart';
import '../../../routes.dart';
import '../drop_menu/drop_menu.dart';

class PlansMenu extends StatelessWidget {
  PlansMenu({super.key});

  final List bodyItems = [
    AppStrings.addPlan,
    AppStrings.plansView,
    AppStrings.dayReports,
  ];
  final PlanControllerImp planController = Get.find<PlanControllerImp>();
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();
  final PlanCartControllerImp planCartController =
      Get.find<PlanCartControllerImp>();
  final SubStockCartControllerImp subStockCartController =
      Get.find<SubStockCartControllerImp>();
  final IngredientCartControllerImp ingredientCartController =
      Get.find<IngredientCartControllerImp>();
  final IngredientControllerImp ingredientController =
      Get.find<IngredientControllerImp>();

  @override
  Widget build(BuildContext context) {
    return MyDropMenu(
      label: AppStrings.plans,
      bodyItems: bodyItems,
      onChanged: (value) async {
        await itemController.getItems();
        await ingredientController.getIngredients();
        ingredientCartController.clearCart();
        planCartController.clearCart();
        subStockCartController.clearCart();
        itemController.getItems();
        switch (value) {
          case AppStrings.addPlan:
            Get.offAllNamed(AppRoutes.addPlanScreen);
            break;
          case AppStrings.plansView:
            await planController.getPlans();
            Get.offAllNamed(AppRoutes.searchPlansScreen);
            break;
          case AppStrings.dayReports:
            Get.offAllNamed(AppRoutes.dayReportsScreen);
            break;
          default:
            Get.offAllNamed(AppRoutes.mainScreen);
        }
      },
    );
  }
}
