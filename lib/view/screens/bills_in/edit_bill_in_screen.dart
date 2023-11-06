import 'package:intl/intl.dart';

import '../../../controllers/bill_in/bill_in_cart.dart';
import '../../../controllers/bill_in/bill_in_controller.dart';
import '../../../controllers/bill_in/bill_in_item_controller.dart';
import '../../../controllers/items/item_controller.dart';
import '../../../controllers/supplires/sup_controller.dart';
import '../../../core/print/pdf_bill.dart';
import '../../../data/models/bills/bill_model.dart';
import '../../../libraries.dart';
import '../../widgets/admin/dialouge.dart';
import '../../widgets/bills_in/bill_in_cart_item.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/public/bill_details_public.dart';

class EditBillInScreen extends StatelessWidget {
  EditBillInScreen({super.key});

  final BillInItemControllerImp billInItemController =
      Get.find<BillInItemControllerImp>();
  final SupControllerImp supController = Get.find<SupControllerImp>();
  final BillInCartControllerImp cartController =
      Get.find<BillInCartControllerImp>();
  final BillInControllerImp billInController = Get.find<BillInControllerImp>();
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();
  final Bill bill = Get.arguments[0];
  final MyService myService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      if (billInItemController.isLoading.value ||
          supController.isLoading.value ||
          billInController.isLoading.value ||
          itemController.isLoading.value) {
        return const Center(
          child: MyLottieLoading(),
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UpperWidget(isAdminScreen: false, onPressed: () {}),
            Expanded(
              child: MyContainer(
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BillDetailsPublic(bill: bill, kind: AppStrings.billIn),
                    //for height
                    SizedBox(
                      height: AppSizes.h03,
                    ),
                    //cart items
                    Expanded(
                      flex: 3,
                      // height: AppSizes.h18,

                      child: cartController.myCarts.isEmpty
                          ? Text(
                              AppStrings.emptyList,
                              style: context.textTheme.titleSmall,
                            )
                          : Column(
                              children: [
                                Expanded(
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: AppSizes.h25,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            bottom: AppSizes.h02),
                                        child: BillInCartItem(
                                          // isOvered: false,
                                          isBack: false,
                                          inEdit: true,
                                          index: index,
                                          billInItem: cartController
                                              .myCarts.keys
                                              .toList()[index],
                                          quantity: cartController
                                              .myCarts.values
                                              .toList()[index],
                                        ),
                                      );
                                    },
                                    itemCount: cartController.myCarts.length,
                                  ),
                                ),
                              ],
                            ),
                    ),
                    // //save and print buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //  print button
                        MyButton(
                          text: AppStrings.print,
                          minWidth: AppSizes.w3,
                          onPressed: printFunc,
                        ),

                        //do dialouge
                        myService.sharedPreferences
                                    .getInt(AppStrings.adminKey)! !=
                                1
                            ? const SizedBox()
                            : MyButton(
                                text: AppStrings.deleteBill,
                                minWidth: AppSizes.w3,
                                onPressed: () {
                                  deleteBill();
                                },
                              ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }
    }));
  }

  void printFunc() {
    cartController.items.clear();
    List items = cartController.myCarts.keys.toList();
    for (int i = 0; i < items.length; i++) {
      cartController.items.add(
        [
          (double.parse(items[i].itemPriceIn) *
                  double.parse(items[i].itemCount))
              .toString(),
          items[i].itemPriceIn,
          items[i].itemCount,
          items[i].itemNum.toString(),
          items[i].itemName
        ],
      );
    }
    printBill(
      billDate: DateFormat.yMMMMEEEEd('ar').format(bill.billTimestamp),
      billLenth: cartController.myCarts.length.toString(),
      billNumber: bill.billId.toString(),
      items: cartController.items,
      colums: [
        AppStrings.total,
        AppStrings.itemPriceIn,
        AppStrings.itemQuantity,
        AppStrings.itemNum,
        AppStrings.itemName,
      ],
      label: bill.kind == 1 ? AppStrings.billIn : AppStrings.backBillIn,
      total: double.parse(bill.billTotal.toString()).toStringAsFixed(2),
      kind: '1',
      endDate: '',
      startDate: '',
    );
  }

  deleteBill() {
    myDialuge(
        cancel: () {
          Get.back();
          cartController.myCarts.clear();
          cartController.controllers!.clear();
        },
        confirm: () async {
          List items = cartController.myCarts.keys.toList();
          if (bill.kind == 1) {
            for (int i = 0; i < items.length; i++) {
              await itemController.updateStock(
                  itemNum: items[i].itemNum.toString(),
                  quantity: (-double.parse(items[i].itemCount)).toString());
            }
          } else {
            for (int i = 0; i < items.length; i++) {
              await itemController.updateStock(
                  itemNum: items[i].itemNum.toString(),
                  quantity: double.parse(items[i].itemCount).toString());
            }
          }
          await billInItemController.deleteAllBillItems(
            bill.billId.toString(),
          );
          await billInController.deleteBill(
            billId: bill.billId.toString(),
          );
          await itemController.getItems();
          cartController.clearCart();
        },
        title: AppStrings.deleteBill,
        middleText: '');
  }
}
