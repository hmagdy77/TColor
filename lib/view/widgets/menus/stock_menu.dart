import '../../../controllers/ingredients/ingredients_controller.dart';
import '../../../controllers/items/item_controller.dart';
import '../../../libraries.dart';
import '../drop_menu/drop_menu.dart';

class StockMenu extends StatelessWidget {
  StockMenu({super.key, required this.kind});
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();
  final IngredientControllerImp ingredientController =
      Get.find<IngredientControllerImp>();

  final String kind;
  final List bodyItems = [
    AppStrings.sup,
    AppStrings.components,
    AppStrings.products,
    AppStrings.subStock,
    AppStrings.stockReports
  ];
  final List bodyItemsSecond = [
    AppStrings.components,
    AppStrings.products,
    AppStrings.subStock,
    AppStrings.stockReports
  ];

  @override
  Widget build(BuildContext context) {
    return MyDropMenu(
      label: AppStrings.stock,
      bodyItems: kind == AppStrings.allPrimisons ? bodyItems : bodyItemsSecond,
      onChanged: (value) async {
        await itemController.getItems();
        switch (value) {
          case AppStrings.sup:
            Get.offNamed(AppRoutes.searchSupScreen);
            break;
          case AppStrings.products:
            ingredientController.getIngredients();
            Get.offNamed(AppRoutes.productsScreen);
            break;
          case AppStrings.components:
            Get.offNamed(AppRoutes.componetsScreen);
            break;
          case AppStrings.subStock:
            Get.offAllNamed(AppRoutes.supStockScreen);
            break;
          case AppStrings.stockReports:
            Get.offAllNamed(AppRoutes.reportsStockScreen);
            break;
          default:
            Get.offAllNamed(AppRoutes.mainScreen);
        }
      },
    );
  }
}
