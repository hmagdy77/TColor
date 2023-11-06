import '../../../controllers/factory/bill_factory_cart.dart';
import '../../../controllers/ingredients/ingredients_cart_controller.dart';
import '../../../controllers/ingredients/ingredients_controller.dart';
import '../../../controllers/items/item_controller.dart';
import '../../../controllers/plans/plan_controller.dart';
import '../../../controllers/plans/plan_item_controller.dart';
import '../../../controllers/sub_stock/sub_stock_cart.dart';
import '../../../libraries.dart';
import '../drop_menu/drop_menu.dart';

class BillFactoryMenu extends StatelessWidget {
  BillFactoryMenu({super.key});

  final List bodyItems = [
    AppStrings.addBillFactory,
    AppStrings.viewTheBills,
    AppStrings.billFactoryReports,
  ];

  final PlanControllerImp planController = Get.find<PlanControllerImp>();
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();
  final PlanItemControllerImp planItemController =
      Get.find<PlanItemControllerImp>();
  final SubStockCartControllerImp subStockCart =
      Get.find<SubStockCartControllerImp>();
  final BillFactoryCartControllerImp billFactoryCartController =
      Get.find<BillFactoryCartControllerImp>();
  final IngredientCartControllerImp ingredientCartController =
      Get.find<IngredientCartControllerImp>();
  final IngredientControllerImp ingredientController =
      Get.find<IngredientControllerImp>();

  @override
  Widget build(BuildContext context) {
    return MyDropMenu(
      label: AppStrings.theFactory,
      bodyItems: bodyItems,
      onChanged: (value) async {
        subStockCart.clearCart();
        billFactoryCartController.clearCart();
        ingredientCartController.clearCart();
        await ingredientController.getIngredients();
        await itemController.getItems();
        await planController.getPlans();
        switch (value) {
          case AppStrings.addBillFactory:
            await itemController.getItems();
            await planController.getPlans();
            await planItemController.getItemsByIndex(
              planId: planController.plansListReversed[1].id.toString(),
            );
            Get.offAllNamed(AppRoutes.addBillFactoryScreen);
            break;
          case AppStrings.viewTheBills:
            Get.offAllNamed(AppRoutes.searchBillFactoryScreen);
            break;
          case AppStrings.billFactoryReports:
            Get.offAllNamed(AppRoutes.reportBillFactoryScreen);
            break;
          default:
            Get.offAllNamed(AppRoutes.mainScreen);
        }
      },
    );
  }
}
