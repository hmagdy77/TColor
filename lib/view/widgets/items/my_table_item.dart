import '../../../controllers/bill_stock/bill_stock_controller.dart';
import '../../../controllers/bill_stock/bill_stock_items_controller.dart';
import '../../../controllers/ingredients/ingredients_cart_controller.dart';
import '../../../controllers/ingredients/ingredients_controller.dart';
import '../../../controllers/items/item_controller.dart';
import '../../../controllers/supplires/sup_controller.dart';
import '../../../data/models/items/item_model.dart';
import '../../../libraries.dart';
import 'table_ciel.dart';

class MyTableItem extends StatelessWidget {
  MyTableItem({
    super.key,
    this.item,
    required this.isHeader,
    required this.isComponet,
    required this.main,
    // this.bill,
  });
  final Item? item;
  final bool isHeader;
  final bool isComponet;
  final bool main;
  final MyService myService = Get.find();
  final ItemControllerImp itemController = Get.put(ItemControllerImp());
  final SupControllerImp supController = Get.find<SupControllerImp>();
  final IngredientControllerImp ingredientController =
      Get.find<IngredientControllerImp>();
  final BillStockControllerImp billStockController =
      Get.find<BillStockControllerImp>();
  final BillStockItemControllerImp billStockItemController =
      Get.find<BillStockItemControllerImp>();
  final IngredientCartControllerImp ingredientCartController =
      Get.find<IngredientCartControllerImp>();

  @override
  Widget build(BuildContext context) {
    if (isComponet) {
      if (isHeader) {
        return Center(
          child: Row(
            children: [
              const MyCiel(
                isBack: false,
                isHeader: true,
                width: 4,
                text: AppStrings.itemName,
              ),
              const MyCiel(
                isBack: false,
                isHeader: true,
                width: 3,
                text: AppStrings.itemNum,
              ),
              const MyCiel(
                isBack: false,
                isHeader: true,
                width: 3,
                text: AppStrings.supName,
              ),
              const MyCiel(
                isBack: false,
                isHeader: true,
                width: 3,
                text: AppStrings.itemQuantity,
              ),
              myService.sharedPreferences.getInt(AppStrings.adminKey)! != 1
                  ? const SizedBox()
                  : main
                      ? const MyCiel(
                          isBack: false,
                          isHeader: true,
                          width: 2,
                          text: AppStrings.edit,
                        )
                      : const SizedBox(),
            ],
          ),
        );
      } else {
        return Row(
          children: [
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 4,
              text: item!.itemName,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 3,
              text: item!.itemNum,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 3,
              text: item!.itemSup,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 3,
              text: main
                  ? itemController.converter(quant: item!.itemQuant)
                  : itemController.converter(quant: item!.itemSubQuant),
              color: main && (double.parse(item!.itemQuant)) <= 0
                  ? AppColorManger.red
                  : !main && (double.parse(item!.itemSubQuant)) <= 0
                      ? AppColorManger.red
                      : context.theme.primaryColorDark,
            ),
            myService.sharedPreferences.getInt(AppStrings.adminKey)! != 1
                ? const SizedBox()
                : main
                    ? Expanded(
                        flex: 2,
                        child: MyButton(
                          text: AppStrings.edit,
                          onPressed: () {
                            if (main) {
                              itemController.prepareEditScreen(item: item!);
                              supController.prepareSubForUse(
                                  sup: item!.itemSup);
                              Get.offAndToNamed(
                                AppRoutes.editComponentScreen,
                                arguments: [item],
                              );
                            }
                          },
                        ),
                      )
                    : const SizedBox(),
          ],
        );
      }
    } else {
      if (isHeader) {
        return Center(
            child: Row(
          children: [
            const MyCiel(
              isBack: false,
              isHeader: true,
              width: 4,
              text: AppStrings.itemName,
            ),
            const MyCiel(
              isBack: false,
              isHeader: true,
              width: 3,
              text: AppStrings.itemNum,
            ),
            const MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: AppStrings.itemQuantity,
            ),
            myService.sharedPreferences.getInt(AppStrings.adminKey)! == 1 ||
                    myService.sharedPreferences.getInt(AppStrings.adminKey)! ==
                        2
                ? const MyCiel(
                    isBack: false,
                    isHeader: true,
                    width: 2,
                    text: AppStrings.details,
                  )
                : const SizedBox(),
          ],
        ));
      } else {
        return Row(
          children: [
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 4,
              text: item!.itemName,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 3,
              text: item!.itemNum,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 2,
              text: itemController.converter(quant: item!.itemQuant),
              color: (double.parse(item!.itemQuant)) <= 0
                  ? AppColorManger.red
                  : AppColorManger.white,
            ),
            myService.sharedPreferences.getInt(AppStrings.adminKey)! == 1 ||
                    myService.sharedPreferences.getInt(AppStrings.adminKey)! ==
                        2
                ? Expanded(
                    flex: 2,
                    child: MyButton(
                      text: AppStrings.details,
                      onPressed: () {
                        ingredientController.sortIngredients(
                          productId: item!.ingredientsNumber,
                        );
                        ingredientCartController.addAllProudctsIngredint(
                          ingredents:
                              ingredientController.productsIngredientsList,
                        );
                        itemController.prepareEditScreen(item: item!);
                        itemController.searchItemsList.clear();
                        Get.toNamed(
                          AppRoutes.viewProudctDetails,
                          arguments: [item],
                        );
                      },
                    ),
                  )
                : const SizedBox(),
          ],
        );
      }
    }
  }
}
