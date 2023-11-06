import 'controllers/bill_in/bill_in_cart.dart';
import 'controllers/bill_in/bill_in_controller.dart';
import 'controllers/bill_in/bill_in_item_controller.dart';
import 'controllers/bill_in/bill_in_report_controller.dart';
import 'controllers/bill_out/bill_out_cart.dart';
import 'controllers/bill_out/bill_out_controller.dart';
import 'controllers/bill_out/bill_out_item_controller.dart';
import 'controllers/bill_out/bill_out_reports_controller.dart';
import 'controllers/bill_shortage/bill_shortage_cart.dart';
import 'controllers/bill_shortage/bill_shortage_controller.dart';
import 'controllers/bill_shortage/bill_shortage_item_controller.dart';
import 'controllers/bill_stock/bill_stock_cart.dart';
import 'controllers/bill_stock/bill_stock_controller.dart';
import 'controllers/bill_stock/bill_stock_items_controller.dart';
import 'controllers/factory/bill_factory_cart.dart';
import 'controllers/factory/bill_factory_controller.dart';
import 'controllers/factory/bill_factory_item_controller.dart';
import 'controllers/factory/bill_factory_report_controller.dart';
import 'controllers/ingredients/ingredients_cart_controller.dart';
import 'controllers/ingredients/ingredients_controller.dart';
import 'controllers/ip/ip_controller.dart';
import 'controllers/items/item_cart_controller.dart';
import 'controllers/items/item_controller.dart';
import 'controllers/plans/plan_cart.dart';
import 'controllers/plans/plan_controller.dart';
import 'controllers/plans/plan_item_controller.dart';
import 'controllers/reports/day_report_controller.dart';
import 'controllers/reports/stock_report_controller.dart';
import 'controllers/sub_stock/sub_stock_cart.dart';
import 'controllers/supplires/sup_controller.dart';
import 'controllers/users/users_controller.dart';
import 'libraries.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // sup
    Get.put(SupControllerImp());
    Get.put(IpAddressControllerImp());
    // item
    Get.put(ItemControllerImp());
    Get.put(ItemCartControllerImp());
    // Ingredient
    Get.put(IngredientControllerImp());
    Get.put(IngredientCartControllerImp());
    // bill Factory
    Get.put(BillFactoryControllerImp());
    Get.put(BillFactoryItemControllerImp());
    Get.put(BillFactoryCartControllerImp());
    Get.put(BillFactoryReportControllerImp());
    // bill out
    Get.put(BillOutControllerImp());
    Get.put(BillOutItemControllerImp());
    Get.put(BillOutCartControllerImp());
    Get.put(BillOutReportControllerImp());
    // bill in
    Get.put(BillInControllerImp());
    Get.put(BillInItemControllerImp());
    Get.put(BillInCartControllerImp());
    Get.put(BillInReportControllerImp());
    // bill stock
    Get.put(BillStockControllerImp());
    Get.put(BillStockItemControllerImp());
    Get.put(BillStockCartControllerImp());
    // sup Stock
    Get.put(SubStockCartControllerImp());
    // bill shortahge
    Get.put(BillShortageControllerImp());
    Get.put(BillShortageItemControllerImp());
    Get.put(BillShortageCartControllerImp());
    // plan
    Get.put(PlanControllerImp());
    Get.put(PlanItemControllerImp());
    Get.put(PlanCartControllerImp());
    Get.put(DayReportsControllerImp());
    // reports
    Get.put(StockReportControllerImp());
    // users
    Get.put(UsersControllerImp());
  }
}
