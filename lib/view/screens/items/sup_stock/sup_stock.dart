import 'package:intl/intl.dart';

import '../../../../controllers/items/item_cart_controller.dart';
import '../../../../controllers/items/item_controller.dart';
import '../../../../core/print/pdf_bill.dart';
import '../../../../libraries.dart';
import '../../../widgets/items/my_table_item.dart';
import '../../../widgets/lottie/empty.dart';
import '../../../widgets/menus/upper_widget.dart';

class SubStock extends StatelessWidget {
  SubStock({super.key});
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();
  final ItemCartControllerImp itemCartController =
      Get.find<ItemCartControllerImp>();

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
                          AppStrings.subStock,
                          style: context.textTheme.displayLarge,
                        ),
                        SizedBox(
                          height: AppSizes.h02,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: MyTextField(
                                hidePassword: false,
                                controller: itemController.searchTextField,
                                validate: (val) {},
                                label: AppStrings.search,
                                onChanged: (val) {
                                  itemController.search(
                                      searchName: val, kind: 3);
                                },
                                onSubmite: (val) {
                                  itemController.search(
                                      searchName: val, kind: 3);
                                },
                              ),
                            ),
                            SizedBox(
                              width: AppSizes.w02,
                            ),
                            MyButton(
                              // minWidth: AppSizes.w25,
                              text: AppStrings.print,
                              onPressed: () {
                                itemCartController.items.clear();
                                List items;
                                if (itemController.searchItemsList.isEmpty) {
                                  items = itemController.componetsItemsList;
                                } else {
                                  items = itemController.searchItemsList;
                                }
                                for (int i = 0; i < items.length; i++) {
                                  itemCartController.items.add(
                                    [
                                      items[i].itemSubQuant,
                                      items[i].itemNum,
                                      items[i].itemName
                                    ],
                                  );
                                }
                                printBill(
                                  billDate:
                                      DateFormat.yMEd().format(DateTime.now()),
                                  billLenth: items.length.toString(),
                                  billNumber: '0',
                                  total: '0',
                                  items: itemCartController.items,
                                  colums: [
                                    AppStrings.itemQuantity,
                                    AppStrings.itemNum,
                                    AppStrings.itemName,
                                  ],
                                  label: AppStrings.subStock,
                                  kind: '0',
                                  endDate: '',
                                  startDate: '',
                                );
                              },
                            ),
                            // MyButton(
                            //   minWidth: AppSizes.w25,
                            //   text: AppStrings.backBillStock,
                            //   onPressed: () {
                            //     Get.offAllNamed(
                            //       AppRoutes.addBackBillStockScreen,
                            //     );
                            //   },
                            // ),
                          ],
                        ),
                        // for height
                        SizedBox(
                          height: AppSizes.h02,
                        ),
                        // items
                        MyTableItem(
                          isHeader: true,
                          isComponet: true,
                          main: false,
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
                                    itemController
                                        .searchTextField.text.isNotEmpty) {
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
                                        main: false,
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
}
