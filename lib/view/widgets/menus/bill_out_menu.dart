import '../../../controllers/bill_out/bill_out_cart.dart';
import '../../../controllers/bill_out/bill_out_controller.dart';
import '../../../controllers/items/item_controller.dart';
import '../../../libraries.dart';
import '../drop_menu/drop_menu.dart';

class BillOutMenu extends StatelessWidget {
  BillOutMenu({
    super.key,
  });
  final List bodyItems = [
    AppStrings.addBillOut,
    AppStrings.backBillOut,
    AppStrings.viewTheBills,
    AppStrings.billOutReports,
  ];
  final BillOutControllerImp billOutController =
      Get.find<BillOutControllerImp>();
  final BillOutCartControllerImp cartController =
      Get.find<BillOutCartControllerImp>();
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();
  @override
  Widget build(BuildContext context) {
    return MyDropMenu(
      label: AppStrings.billOut,
      bodyItems: bodyItems,
      onChanged: (value) async {
        await itemController.getItems();
        cartController.clearCart();
        switch (value) {
          case AppStrings.addBillOut:
            Get.offAllNamed(AppRoutes.addBillOutScreen);
            break;
          case AppStrings.backBillOut:
            Get.offAllNamed(AppRoutes.addBackBillOutScreen);
            break;
          case AppStrings.viewTheBills:
            await billOutController.getBillsOut();
            Get.offAllNamed(AppRoutes.searchBillOutScreen);
            break;
          case AppStrings.billOutReports:
            Get.offAllNamed(AppRoutes.reportBillOutScreen);
            break;
          default:
            Get.offAllNamed(AppRoutes.mainScreen);
        }
      },
    );
  }
}
