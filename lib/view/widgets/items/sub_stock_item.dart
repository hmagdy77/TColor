import '../../../controllers/ingredients/ingredients_controller.dart';
import '../../../controllers/items/item_controller.dart';
import '../../../controllers/supplires/sup_controller.dart';
import '../../../data/models/items/item_model.dart';
import '../../../libraries.dart';
import 'table_ciel.dart';

class MyTableSubStock extends StatelessWidget {
  MyTableSubStock({
    super.key,
    this.ingredient,
    required this.isHeader,
  });
  final Item? ingredient;
  final bool isHeader;
  final MyService myService = Get.find();
  final ItemControllerImp itemController = Get.put(ItemControllerImp());
  final SupControllerImp supController = Get.find<SupControllerImp>();
  final IngredientControllerImp ingredientController =
      Get.find<IngredientControllerImp>();

  @override
  Widget build(BuildContext context) {
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
            myService.sharedPreferences.getInt(AppStrings.adminKey) == 1
                ? const MyCiel(
                    isBack: false,
                    isHeader: true,
                    width: 2,
                    text: AppStrings.itemPriceIn,
                  )
                : Container(),
            const MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: AppStrings.itemPriceOut,
            ),
            const MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: AppStrings.edit,
            ),
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
            text: ingredient!.itemName,
          ),
          MyCiel(
            isBack: false,
            isHeader: false,
            width: 3,
            text: ingredient!.itemNum,
          ),
          MyCiel(
            isBack: false,
            isHeader: false,
            width: 3,
            text: ingredient!.itemSup,
          ),
          MyCiel(
            isBack: false,
            isHeader: false,
            width: 3,
            text: ingredient!.itemCount,
          ),
          myService.sharedPreferences.getInt(AppStrings.adminKey) == 1
              ? MyCiel(
                  isBack: false,
                  isHeader: false,
                  width: 2,
                  text: ingredient!.itemPriceIn.toString(),
                )
              : Container(),
          MyCiel(
            isBack: false,
            isHeader: false,
            width: 2,
            text: ingredient!.itemPriceOut.toString(),
          ),
          Expanded(
            flex: 2,
            child: MyButton(
              text: AppStrings.edit,
              onPressed: () {},
            ),
          ),
        ],
      );
    }
  }
}
