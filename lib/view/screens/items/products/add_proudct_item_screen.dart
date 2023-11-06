import '../../../../controllers/ingredients/ingredients_cart_controller.dart';
import '../../../../controllers/ingredients/ingredients_controller.dart';
import '../../../../controllers/items/item_controller.dart';
import '../../../../controllers/supplires/sup_controller.dart';
import '../../../../libraries.dart';
import '../../../widgets/login/snackbar.dart';
import '../../../widgets/menus/upper_widget.dart';
import '../../ingredients/chose_ingredients.dart';

class AddProudctItemScreen extends StatelessWidget {
  AddProudctItemScreen({super.key});
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();
  final IngredientControllerImp ingredientController =
      Get.find<IngredientControllerImp>();
  final IngredientCartControllerImp ingrediantCart =
      Get.find<IngredientCartControllerImp>();

  final SupControllerImp supController = Get.find<SupControllerImp>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UpperWidget(isAdminScreen: false, onPressed: () {}),
          Expanded(
            child: Form(
              key: itemController.addItemKey,
              child: Obx(
                () {
                  if (itemController.isLoading.value) {
                    return const MyLottieLoading();
                  } else {
                    return MyContainer(
                      content: Column(
                        children: [
                          Text('${AppStrings.addItems} ${AppStrings.products}',
                              style: context.textTheme.titleSmall),
                          //for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          // name and num
                          Row(
                            children: [
                              //name textfield
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 10,
                                  ),
                                  child: MyTextField(
                                    controller: itemController.name,
                                    validate: (val) {
                                      return validInput(
                                        max: 80,
                                        min: 1,
                                        type: AppStrings.validateAdmin,
                                        val: val,
                                      );
                                    },
                                    label: AppStrings.itemName,
                                    hidePassword: false,
                                  ),
                                ),
                              ),
                              //code textfield
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: MyTextField(
                                    controller: itemController.num,
                                    validate: (val) {
                                      return validInput(
                                        max: 80,
                                        min: 1,
                                        type: AppStrings.validateAdmin,
                                        val: val,
                                      );
                                    },
                                    label: AppStrings.itemNum,
                                    hint: 'P18129898',
                                    hidePassword: false,
                                  ),
                                ),
                              ),
                              // priceout textfield
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: MyNumberField(
                                    withDot: true,
                                    controller: itemController.priceOut,
                                    label: AppStrings.itemPriceOut,
                                    hint: '',
                                    padding: 8,
                                  ),
                                ),
                              ),
                              // priceout textfield
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: MyNumberField(
                                    withDot: false,
                                    controller: itemController.min,
                                    label: AppStrings.min,
                                    hint: '',
                                    padding: 8,
                                  ),
                                ),
                              ),
                              // priceout textfield
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: MyNumberField(
                                    withDot: false,
                                    controller: itemController.max,
                                    label: AppStrings.max,
                                    hint: '',
                                    padding: 8,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //for height
                          SizedBox(
                            height: AppSizes.h02,
                          ),
                          ChoseIngredients(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MyButton(
                                // minWidth: true,
                                text: AppStrings.deleteAll,
                                onPressed: () {
                                  ingrediantCart.clearCart();
                                },
                              ),
                              MyButton(
                                // minWidth: true,
                                text: AppStrings.addItems,
                                onPressed: saveProudct,
                              ),
                              Text(
                                  '${AppStrings.cost} : ${ingrediantCart.proudctsIngredintTotalPrice}'),
                              Text(
                                  '${AppStrings.wight} ${double.parse(ingrediantCart.proudctsIngredintWight.toString()).toStringAsFixed(3)}')
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> saveProudct() async {
    if (itemController.priceOut.text.isEmpty ||
        itemController.name.text.isEmpty ||
        itemController.num.text.isEmpty ||
        itemController.min.text.isEmpty ||
        itemController.max.text.isEmpty ||
        itemController.priceOut.text.endsWith('.')) {
      MySnackBar.snack(AppStrings.pleaseEnterWantedValues, '');
    } else if (ingrediantCart.myIngredentsCarts.isEmpty) {
      MySnackBar.snack(AppStrings.emptyList, '');
    } else {
      await ingredientController.addAllIngredient(
        myCarts: ingrediantCart.myIngredentsCarts.values.toList(),
        ingrediantNum: itemController.num.text,
      );
      await itemController.addItem(
        sup: 'mine',
        kind: 2,
        cost: ingrediantCart.proudctsIngredintTotalPrice.toString(),
        ingredientsNumber: itemController.num.text,
        itemWight: double.parse(
          ingrediantCart.proudctsIngredintWight.toString(),
        ).toString(),
      );
      ingrediantCart.clearCart();
      await itemController.getItems();
      await ingredientController.getIngredients();
    }
  }
}
