import '../../../../controllers/ingredients/ingredients_cart_controller.dart';
import '../../../../controllers/ingredients/ingredients_controller.dart';
import '../../../../controllers/items/item_controller.dart';
import '../../../../data/models/items/item_model.dart';
import '../../../../libraries.dart';
import '../../../widgets/admin/dialouge.dart';
import '../../../widgets/ingredients/ingredient_view_item.dart';
import '../../../widgets/items/item_widget.dart';
import '../../../widgets/login/snackbar.dart';
import '../../../widgets/lottie/empty.dart';
import '../../../widgets/menus/upper_widget.dart';

class ViewProudctDetails extends StatelessWidget {
  ViewProudctDetails({super.key});
  final Item item = Get.arguments[0];
  final IngredientControllerImp ingredientController =
      Get.find<IngredientControllerImp>();
  final IngredientCartControllerImp cartController =
      Get.find<IngredientCartControllerImp>();
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UpperWidget(isAdminScreen: false, onPressed: () {}),
          Expanded(
            child: Obx(() {
              if (ingredientController.isLoading.value ||
                  cartController.isLoading.value ||
                  itemController.isLoading.value) {
                return const MyLottieLoading();
              } else {
                return MyContainer(
                  content: Column(
                    children: [
                      Text(
                        AppStrings.productDetails,
                        style: Get.textTheme.displayMedium,
                      ),
                      SizedBox(
                        height: AppSizes.h02,
                      ),
                      ProductDetails(
                          itemController: itemController,
                          item: item,
                          cartController: cartController),
                      SizedBox(
                        height: AppSizes.h02,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Items(
                                itemController: itemController,
                                cartController: cartController,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Ingredents(
                                cartController: cartController,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: AppSizes.h02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MyButton(
                            text: AppStrings.edit,
                            onPressed: edit,
                          ),
                          MyButton(
                            text: AppStrings.delete,
                            onPressed: delete,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            }),
          )
        ],
      ),
    );
  }

  void delete() {
    myDialuge(
      confirm: () {
        List ingreds = ingredientController.productsIngredientsList;
        for (int index = 0; index < ingreds.length; index++) {
          ingredientController.deleteIngredient(
              id: ingreds[index].itemId.toString());
        }
        itemController.deleteItem(
          id: item.itemId.toString(),
        );
      },
      cancel: () {},
      title: AppStrings.confirm,
      middleText: '',
    );
  }

  void edit() async {
    if (itemController.priceOut.text.endsWith('.') ||
        itemController.priceOut.text.isEmpty ||
        itemController.name.text.isEmpty) {
      MySnackBar.snack(AppStrings.pleaseEnterWantedValues, '');
    } else {
      List ingreds = cartController.myIngredentsCarts.values.toList();
      await ingredientController.deleteAllProudctIngredient(
        proudcttId: item.itemNum,
      );
      await itemController.editProudct(
        item: item,
        priceIn: double.parse(
          cartController.proudctsIngredintTotalPrice.toString(),
        ).toStringAsFixed(2),
      );
      await ingredientController.addAllIngredient(
        myCarts: ingreds,
        ingrediantNum: item.itemNum,
      );
      cartController.clearCart();
      await itemController.getItems();
      await ingredientController.getIngredients();
    }
  }
}

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    super.key,
    required this.itemController,
    required this.item,
    required this.cartController,
  });

  final ItemControllerImp itemController;
  final Item item;
  final IngredientCartControllerImp cartController;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: MyTextField(
                hidePassword: false,
                validate: (v) {},
                label: AppStrings.itemName,
                controller: itemController.name,
              ),
            ),
            SizedBox(
              width: AppSizes.h05,
            ),
            Expanded(
              flex: 1,
              child: MyNumberField(
                withDot: true,
                validate: (v) {},
                label: AppStrings.itemPriceOut,
                controller: itemController.priceOut,
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '${AppStrings.itemNum} : ${item.itemNum}',
                    style: Get.textTheme.displayMedium,
                  ),
                  Text(
                    '${AppStrings.componentsNumber} : ${cartController.myIngredentsCarts.length}',
                    style: Get.textTheme.displayMedium,
                  ),
                  Text(
                    '${AppStrings.wight} : ${cartController.proudctsIngredintWight}',
                    style: Get.textTheme.displayMedium,
                  ),
                  Text(
                    '${AppStrings.cost} : ${cartController.proudctsIngredintTotalPrice}',
                    style: Get.textTheme.displayMedium,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class Ingredents extends StatelessWidget {
  const Ingredents({
    super.key,
    required this.cartController,
  });

  final IngredientCartControllerImp cartController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: AppSizes.w35,
          ),
          itemCount: cartController.myIngredentsCarts.values.toList().length,
          itemBuilder: (context, index) {
            var ingredient =
                cartController.myIngredentsCarts.values.toList()[index];
            return IngredientViewItem(
              index: index,
              ingredient: ingredient,
            );
          },
        );
      },
    );
  }
}

class Items extends StatelessWidget {
  const Items({
    super.key,
    required this.itemController,
    required this.cartController,
  });

  final ItemControllerImp itemController;
  final IngredientCartControllerImp cartController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //search  items
        MyTextField(
          controller: itemController.searchTextField,
          validate: (val) {
            return validInput(
              max: 50,
              min: 0,
              type: AppStrings.validateAdmin,
              val: val,
            );
          },
          label: AppStrings.search,
          onChanged: (val) {
            itemController.search(searchName: val, kind: 4);
          },
          onSubmite: (val) {
            itemController.search(searchName: val, kind: 4);
          },
          hidePassword: false,
        ),
        //for height
        SizedBox(
          height: AppSizes.h02,
        ),
        //items
        Expanded(
          child: Obx(
            () {
              if (itemController.isLoading.value) {
                return const MyLottieLoading();
              } else {
                if (itemController.searchItemsList.isEmpty &&
                    itemController.name.text.isNotEmpty) {
                  return const MyLottieEmpty();
                } else {
                  return ListView.separated(
                    itemCount: itemController.searchItemsList.length,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        thickness: 2,
                      );
                    },
                    itemBuilder: (context, index) {
                      var item = itemController.searchItemsList[index];
                      return GestureDetector(
                        onTap: () {
                          cartController.addProudctsIngredint(
                            ingredents: item,
                          );
                        },
                        child: MyItemWidget(
                          item: item,
                        ),
                      );
                    },
                  );
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
