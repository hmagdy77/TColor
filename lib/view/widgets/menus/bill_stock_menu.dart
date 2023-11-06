import '../../../controllers/bill_shortage/bill_shortage_cart.dart';
import '../../../controllers/bill_shortage/bill_shortage_controller.dart';
import '../../../controllers/bill_stock/bill_stock_cart.dart';
import '../../../controllers/bill_stock/bill_stock_controller.dart';
import '../../../controllers/items/item_controller.dart';
import '../../../controllers/plans/plan_controller.dart';
import '../../../controllers/plans/plan_item_controller.dart';
import '../../../libraries.dart';
import '../drop_menu/drop_menu.dart';

class BillStockMenu extends StatelessWidget {
  BillStockMenu({
    super.key,
    required this.kind,
  });
  final List bodyItems = [
    AppStrings.exChange,
    AppStrings.backBillStock,
    AppStrings.billShortagePlus,
    AppStrings.billShortageMinus,
    AppStrings.viewTheBills,
  ];
  final List bodyItemsSecond = [
    AppStrings.backBillStock,
    AppStrings.billShortagePlus,
    AppStrings.billShortageMinus,
    AppStrings.viewTheBills,
  ];
  final String kind;
  final BillShortageControllerImp billShortageController =
      Get.find<BillShortageControllerImp>();
  final BillShortageCartControllerImp billShortageCartController =
      Get.find<BillShortageCartControllerImp>();
  final BillStockCartControllerImp billStockCartController =
      Get.find<BillStockCartControllerImp>();
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();
  final PlanControllerImp planController = Get.find<PlanControllerImp>();
  final PlanItemControllerImp planItemController =
      Get.find<PlanItemControllerImp>();
  final BillStockControllerImp billStockController =
      Get.find<BillStockControllerImp>();

  @override
  Widget build(BuildContext context) {
    return MyDropMenu(
      label: AppStrings.stockMovement,
      bodyItems: kind == AppStrings.allPrimisons ? bodyItems : bodyItemsSecond,
      onChanged: (value) async {
        await itemController.getItems();
        switch (value) {
          case AppStrings.exChange:
            billStockCartController.clearCart();
            await planController.getPlans();
            await planItemController.getItemsByIndex(
              planId: planController.plansListReversed[1].id.toString(),
            );
            Get.offAllNamed(
              AppRoutes.addBillStockScreen,
              arguments: [planController.plansListReversed[1]],
            );
            break;
          case AppStrings.backBillStock:
            billStockCartController.clearCart();
            Get.offAllNamed(
              AppRoutes.addBackBillStockScreen,
            );
            break;
          case AppStrings.billShortagePlus:
            billShortageCartController.clearCart();
            Get.offAllNamed(AppRoutes.addPlusBillShortageScreen);
            break;
          case AppStrings.billShortageMinus:
            billShortageCartController.clearCart();
            Get.offAllNamed(AppRoutes.addMinusBillShortageScreen);
            break;
          case AppStrings.viewTheBills:
            await billStockController.getBillsStock();
            await billShortageController.getBillShortage();
            Get.offAllNamed(AppRoutes.viewStockBillsScreen);
            break;
          default:
            Get.offAllNamed(AppRoutes.mainScreen);
        }
      },
    );
  }
}
