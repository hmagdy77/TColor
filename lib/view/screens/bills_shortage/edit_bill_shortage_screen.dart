import 'package:intl/intl.dart';

import '../../../controllers/bill_shortage/bill_shortage_cart.dart';
import '../../../controllers/bill_shortage/bill_shortage_controller.dart';
import '../../../controllers/bill_shortage/bill_shortage_item_controller.dart';
import '../../../controllers/items/item_controller.dart';
import '../../../core/print/pdf_bill.dart';
import '../../../data/models/bills/bill_model.dart';
import '../../../libraries.dart';
import '../../widgets/admin/dialouge.dart';
import '../../widgets/bills_shortage/bill_shortage_view_cart_item.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/public/bill_details_local.dart';

class EditBillShortageScreen extends StatelessWidget {
  EditBillShortageScreen({super.key});

  final BillShortageItemControllerImp billOutItemController =
      Get.find<BillShortageItemControllerImp>();
  final BillShortageControllerImp billOutController =
      Get.find<BillShortageControllerImp>();
  final BillShortageCartControllerImp cartController =
      Get.find<BillShortageCartControllerImp>();
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();
  final MyService myService = Get.find();

  final Bill bill = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      if (billOutItemController.isLoading.value ||
          billOutController.isLoading.value ||
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
                    BillDetailsLocal(
                      label: bill.kind == 1
                          ? AppStrings.billShortagePlus
                          : AppStrings.billShortageMinus,
                      bill: bill,
                    ),
                    //for height
                    SizedBox(
                      height: AppSizes.h04,
                    ),

                    //cart items
                    Expanded(
                      flex: 3,
                      // height: AppSizes.h18,

                      child: billOutItemController.billShortageItemsList.isEmpty
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
                                      List items = billOutItemController
                                          .billShortageItemsList;
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            bottom: AppSizes.h02),
                                        child: BillLocalCartItem(
                                          item: items[index],
                                        ),
                                      );
                                    },
                                    itemCount: billOutItemController
                                        .billShortageItemsList.length,
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
                                onPressed: deleteBill,
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
    List items = billOutItemController.billShortageItemsList;
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

      billLenth: billOutItemController.billShortageItemsList.length.toString(),
      billNumber: bill.billId.toString(),
      items: cartController.items,
      colums: [
        AppStrings.total,
        AppStrings.itemPriceOut,
        AppStrings.itemQuantity,
        AppStrings.itemNum,
        AppStrings.itemName,
      ],
      label: '',
      // bill.kind == 1
      //     ? AppStrings.billOut
      //     : AppStrings.backBillShortage,
      total: double.parse(bill.billTotal.toString()).toStringAsFixed(2),
      kind: '1',
      endDate: '',
      startDate: '',
    );
  }

  void deleteBill() {
    myDialuge(
        cancel: () {
          Get.back();
        },
        confirm: () async {
          List items = billOutItemController.billShortageItemsList;
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
          await billOutItemController.deleteAllBillItems(
            billId: bill.billId.toString(),
          );
          await billOutController.deleteBill(
            billId: bill.billId.toString(),
          );
          await itemController.getItems();
        },
        title: AppStrings.deleteBill,
        middleText: '');
  }
}
