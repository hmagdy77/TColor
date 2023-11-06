import '../../../../controllers/items/item_controller.dart';
import '../../../controllers/ingredients/ingredients_cart_controller.dart';
import '../../../libraries.dart';
import '../../widgets/ingredients/ingredient_view_item.dart';
import '../../widgets/items/item_widget.dart';
import '../../widgets/lottie/empty.dart';

class ChoseIngredients extends StatelessWidget {
  ChoseIngredients({
    super.key,
  });

  final ItemControllerImp itemController = Get.find<ItemControllerImp>();
  final IngredientCartControllerImp ingredientCart =
      Get.find<IngredientCartControllerImp>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
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
                                itemCount:
                                    itemController.searchItemsList.length,
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    thickness: 2,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  var item =
                                      itemController.searchItemsList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      ingredientCart.addProudctsIngredint(
                                          ingredents: item);
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
                ),
              ),
              Expanded(
                flex: 5,
                child: ingredientCart.myIngredentsCarts.isEmpty
                    ? Center(
                        child: Text(
                          AppStrings.emptyList,
                          style: context.textTheme.titleSmall,
                        ),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: AppSizes.w3,
                              ),
                              itemBuilder: (context, index) {
                                return IngredientViewItem(
                                  index: index,
                                  ingredient: ingredientCart
                                      .myIngredentsCarts.values
                                      .toList()[index],
                                );
                              },
                              itemCount:
                                  ingredientCart.myIngredentsCarts.length,
                            ),
                          ),
                        ],
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}
