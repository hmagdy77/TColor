import 'package:intl/intl.dart';

import '../../../../controllers/items/item_cart_controller.dart';
import '../../../../controllers/items/item_controller.dart';
import '../../../../controllers/supplires/sup_controller.dart';
import '../../../../core/print/pdf_bill.dart';
import '../../../../libraries.dart';
import '../../../widgets/drop_menu/drop_menu.dart';
import '../../../widgets/items/my_table_item.dart';
import '../../../widgets/lottie/empty.dart';
import '../../../widgets/menus/upper_widget.dart';

class ComponetsScreen extends StatelessWidget {
  ComponetsScreen({super.key});
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();
  final SupControllerImp supController = Get.find<SupControllerImp>();
  final ItemCartControllerImp itemCartController =
      Get.find<ItemCartControllerImp>();
  final MyService myService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
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
                          AppStrings.componentsStock,
                          style: context.textTheme.displayLarge,
                        ),
                        Row(
                          children: [
                            // kinds
                            Text(
                              ' ${AppStrings.itemKind} : ',
                              style: context.textTheme.displayLarge,
                            ),
                            Expanded(
                              child: MyDropMenu(
                                label: itemController.selectedKind.value,
                                bodyItems: AppStrings.stockSearchList,
                                onChanged: (value) {
                                  itemController.selectedKind.value =
                                      value as String;
                                  switch (value) {
                                    case AppStrings.stockMax:
                                      itemController.searchMinAndMax(
                                          kind: 2, isComponent: true);
                                      break;
                                    case AppStrings.stockMin:
                                      itemController.searchMinAndMax(
                                          kind: 1, isComponent: true);
                                      break;
                                    case AppStrings.notFoundItems:
                                      itemController.searchAvilableQuant(
                                          kind: 0, isComponets: true);
                                      break;
                                    case AppStrings.currentItems:
                                      itemController.searchAvilableQuant(
                                          kind: 1, isComponets: true);
                                      break;
                                    case AppStrings.allItems:
                                      itemController.searchKind('1');
                                      break;
                                  }
                                },
                              ),
                            ),
                            // supName

                            Text(
                              ' ${AppStrings.supName} : ',
                              style: context.textTheme.displayLarge,
                            ),
                            Expanded(
                              child: MyDropMenu(
                                label: supController.selectedSup.value,
                                bodyItems: supController.supListNames,
                                onChanged: (value) {
                                  itemController.search(
                                      searchName: value.toString(), kind: 1);
                                  supController.selectedSup.value =
                                      value as String;
                                },
                              ),
                            ),

                            MyButton(
                              minWidth: AppSizes.w25,
                              text: AppStrings.print,
                              onPressed: () {
                                printFun();
                              },
                            ),

                            myService.sharedPreferences
                                        .getInt(AppStrings.adminKey)! !=
                                    1
                                ? const SizedBox()
                                : MyButton(
                                    minWidth: AppSizes.w25,
                                    text: AppStrings.add,
                                    onPressed: () {
                                      itemController.clearTextFields();
                                      Get.offAllNamed(
                                          AppRoutes.addComponentItemScreen);
                                    },
                                  ),
                          ],
                        ),
                        MyTextField(
                          hidePassword: false,
                          controller: itemController.searchTextField,
                          validate: (val) {},
                          label: AppStrings.search,
                          onChanged: (val) {
                            itemController.selectedKind.value = '';
                            itemController.search(searchName: val, kind: 1);
                          },
                          onSubmite: (val) {
                            itemController.search(searchName: val, kind: 1);
                          },
                        ),
                        SizedBox(
                          height: AppSizes.h02,
                        ),
                        MyTableItem(
                          isHeader: true,
                          isComponet: true,
                          main: true,
                        ),
                        SizedBox(
                          height: AppSizes.h02,
                        ),
                        Expanded(
                          child: Obx(
                            () {
                              if (itemController.isLoading.value) {
                                return const MyLottieLoading();
                              } else {
                                if (itemController.searchItemsList.isEmpty &&
                                    itemController
                                        .searchTextField.text.isEmpty) {
                                  return Container();
                                } else if (itemController
                                        .searchItemsList.isEmpty &&
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
                                      return MyTableItem(
                                        item: item,
                                        isHeader: false,
                                        isComponet: true,
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
      ),
    );
  }

  void printFun() {
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
