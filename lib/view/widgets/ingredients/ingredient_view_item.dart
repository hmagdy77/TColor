import '../../../controllers/ingredients/ingredients_cart_controller.dart';
import '../../../controllers/ingredients/ingredients_controller.dart';
import '../../../controllers/items/item_controller.dart';
import '../../../data/models/items/item_model.dart';
import '../../../libraries.dart';

// ignore: must_be_immutable
class IngredientViewItem extends StatelessWidget {
  IngredientViewItem({
    Key? key,
    required this.ingredient,
    required this.index,
  }) : super(key: key);

  final int index;
  final Item ingredient;
  final IngredientCartControllerImp cartController =
      Get.find<IngredientCartControllerImp>();
  final IngredientControllerImp ingredientController =
      Get.find<IngredientControllerImp>();
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: AppSizes.w01,
        left: AppSizes.w01,
        top: AppSizes.w01,
      ),
      padding: EdgeInsets.only(top: AppSizes.w01, right: AppSizes.w01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColorManger.primary,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ingredient.itemName,
            style: Get.textTheme.displayMedium,
            textAlign: TextAlign.start,
          ),
          Text(
            '${AppStrings.code} : ${ingredient.itemNum.maxLength(8)}',
            style: Get.textTheme.displayMedium,
            textAlign: TextAlign.start,
          ),
          Text(
            '${AppStrings.itemQuantity} : ${ingredient.itemCount}',
            style: context.textTheme.displayMedium,
            textAlign: TextAlign.start,
          ),
          Text(
            '${AppStrings.itemPriceIn} : ${ingredient.itemPriceIn}',
            style: context.textTheme.displayMedium,
            textAlign: TextAlign.start,
          ),
          Text(
            '${AppStrings.cost} : ${(double.parse(ingredient.itemPriceIn) * double.parse(ingredient.itemCount)).toStringAsFixed(2)}',
            style: context.textTheme.displayMedium,
            textAlign: TextAlign.start,
          ),
          const Spacer(),
          SizedBox(
            height: AppSizes.h04,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    cartController.removeFromIngredentsCarts(
                      ingredient: ingredient,
                      index: index,
                    );
                  },
                  icon: Icon(
                    Icons.delete,
                    color: context.theme.primaryColorDark,
                    size: AppSizes.h03,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: MyNumberField(
                    withDot: false,
                    label: '',
                    hint: '0',
                    controller: cartController.controllersDigits![index],
                    onChange: (val) {
                      if (val.isEmpty ||
                          cartController.controllers![index].text.isEmpty) {
                      } else {
                        int quantity1 =
                            int.parse(cartController.controllers![index].text);
                        cartController.updateProudctsIngredintQuantity(
                          item: ingredient,
                          quantityDigit: int.parse(val),
                          quantity: quantity1,
                        );
                      }
                    },
                    onSubmit: (val) {
                      if (val.isEmpty ||
                          cartController.controllers![index].text.isEmpty) {
                      } else {
                        int quantity1 =
                            int.parse(cartController.controllers![index].text);
                        cartController.updateProudctsIngredintQuantity(
                          item: ingredient,
                          quantityDigit: int.parse(val),
                          quantity: quantity1,
                        );
                      }
                    },
                  ),
                ),
                Text(
                  ' / ',
                  style: TextStyle(color: AppColorManger.black, fontSize: 10),
                ),
                Expanded(
                  flex: 2,
                  child: MyNumberField(
                    withDot: false,
                    label: '',
                    hint: '1',
                    controller: cartController.controllers![index],
                    onChange: (val) {
                      if (val.isEmpty ||
                          cartController
                              .controllersDigits![index].text.isEmpty) {
                      } else {
                        int quantity1 = int.parse(
                            cartController.controllersDigits![index].text);
                        cartController.updateProudctsIngredintQuantity(
                          item: ingredient,
                          quantity: int.parse(val),
                          quantityDigit: quantity1,
                        );
                      }
                    },
                    onSubmit: (val) {
                      if (val.isEmpty ||
                          cartController
                              .controllersDigits![index].text.isEmpty) {
                      } else {
                        cartController.updateProudctsIngredintQuantity(
                            item: ingredient,
                            quantity: int.parse(val),
                            quantityDigit: int.parse(
                                cartController.controllersDigits![index].text));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
