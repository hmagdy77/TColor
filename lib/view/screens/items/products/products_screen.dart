import 'package:intl/intl.dart';

import '../../../../controllers/ingredients/ingredients_cart_controller.dart';
import '../../../../controllers/ingredients/ingredients_controller.dart';
import '../../../../controllers/items/item_cart_controller.dart';
import '../../../../controllers/items/item_controller.dart';
import '../../../../core/print/pdf_bill.dart';
import '../../../../libraries.dart';
import '../../../widgets/drop_menu/drop_menu.dart';
import '../../../widgets/items/my_table_item.dart';
import '../../../widgets/lottie/empty.dart';
import '../../../widgets/menus/upper_widget.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({super.key});
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();
  final IngredientControllerImp ingredientController =
      Get.find<IngredientControllerImp>();
  final IngredientCartControllerImp ingredientCartController =
      Get.find<IngredientCartControllerImp>();

  final ItemCartControllerImp itemCartController =
      Get.find<ItemCartControllerImp>();
  final MyService myService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(
      () {
        if (itemController.isLoading.value) {
          return const MyLottieLoading();
        } else {
          return Column(
            children: [
              UpperWidget(
                isAdminScreen: false,
                onPressed: () {},
              ),
              Expanded(
                child: MyContainer(
                  content: Column(
                    children: [
                      Text(
                        AppStrings.productStock,
                        style: context.textTheme.displayLarge,
                      ),
                      // search options
                      Row(
                        children: [
                          // search Text Field
                          Expanded(
                            child: MyTextField(
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
                                itemController.search(searchName: val, kind: 2);
                              },
                              onSubmite: (val) {
                                itemController.search(searchName: val, kind: 2);
                              },
                              hidePassword: false,
                            ),
                          ),
                          //for width
                          SizedBox(
                            width: AppSizes.w02,
                          ),
                          // itemKind
                          Row(
                            children: [
                              Text(
                                ' ${AppStrings.itemKind} : ',
                                style: context.textTheme.displayLarge,
                              ),
                              MyDropMenu(
                                label: itemController.selectedKind.value,
                                bodyItems: AppStrings.stockSearchList,
                                onChanged: (value) {
                                  itemController.selectedKind.value =
                                      value as String;
                                  switch (value) {
                                    case AppStrings.allItems:
                                      itemController.searchKind('2');
                                      break;
                                    case AppStrings.stockMax:
                                      itemController.searchMinAndMax(
                                          kind: 2, isComponent: false);
                                      break;
                                    case AppStrings.stockMin:
                                      itemController.searchMinAndMax(
                                          kind: 1, isComponent: false);
                                      break;
                                    case AppStrings.notFoundItems:
                                      itemController.searchAvilableQuant(
                                          kind: 0, isComponets: false);
                                      break;
                                    case AppStrings.currentItems:
                                      itemController.searchAvilableQuant(
                                          kind: 1, isComponets: false);
                                      break;
                                  }
                                },
                              ),
                            ],
                          ), // addItems
                          // print button
                          MyButton(
                            // minWidth: AppSizes.w25,
                            text: AppStrings.print,
                            onPressed: () {
                              printFunc();
                            },
                          ),
                          // new item button
                          MyButton(
                            text: AppStrings.add,
                            onPressed: () {
                              itemController.searchItemsList.clear();
                              itemController.clearTextFields();
                              ingredientCartController.clearCart();
                              Get.offAllNamed(AppRoutes.addProudctItemScreen);
                            },
                          )
                        ],
                      ),
                      // for height
                      SizedBox(
                        height: AppSizes.h02,
                      ),
                      // items
                      MyTableItem(
                        isHeader: true,
                        isComponet: false,
                        main: true,
                      ),
                      Expanded(
                        child: Obx(
                          () {
                            if (itemController.isLoading.value) {
                              return const MyLottieLoading();
                            } else {
                              if (itemController.searchItemsList.isEmpty &&
                                  itemController.name.text.isEmpty) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: itemController.itemsList.length,
                                  itemBuilder: (context, index) {
                                    return Container();
                                  },
                                );
                              } else if (itemController
                                      .searchItemsList.isEmpty &&
                                  itemController.name.text.isNotEmpty) {
                                return const MyLottieEmpty();
                              } else if (itemController.searchItemsList.isEmpty
                                  // supController.selectedSup.value.isNotEmpty
                                  ) {
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
                                    return MyTableItem(
                                      isHeader: false,
                                      isComponet: false,
                                      item: item,
                                      main: true,
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
              )
            ],
          );
        }
      },
    ));
  }

  void printFunc() {
    itemCartController.items.clear();
    List items;
    if (itemController.searchItemsList.isEmpty) {
      items = itemController.componetsItemsList;
    } else {
      items = itemController.searchItemsList;
    }
    for (int i = 0; i < items.length; i++) {
      itemCartController.items.add(
        [items[i].itemQuant, items[i].itemNum, items[i].itemName],
      );
    }
    printBill(
      billDate: DateFormat.yMMMMEEEEd('ar').format(DateTime.now()),
      billLenth: items.length.toString(),
      billNumber: '0',
      items: itemCartController.items,
      colums: [
        AppStrings.itemQuantity,
        AppStrings.itemNum,
        AppStrings.itemName,
      ],
      label: '${itemController.selectedKind.value} ${AppStrings.components}',
      kind: '0',
      endDate: '',
      startDate: '',
      total: '0',
    );
  }
}
