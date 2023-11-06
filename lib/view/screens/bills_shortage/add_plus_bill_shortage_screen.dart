import 'package:intl/intl.dart';

import '../../../controllers/bill_shortage/bill_shortage_cart.dart';
import '../../../controllers/bill_shortage/bill_shortage_controller.dart';
import '../../../controllers/bill_shortage/bill_shortage_item_controller.dart';
import '../../../controllers/items/item_controller.dart';
import '../../../controllers/supplires/sup_controller.dart';
import '../../../core/print/pdf_bill.dart';
import '../../../data/models/bills/bill_model.dart';
import '../../../libraries.dart';
import '../../widgets/bills_shortage/bill_plus_shortage_cart_item.dart';
import '../../widgets/drop_menu/drop_menu.dart';
import '../../widgets/items/item_widget.dart';
import '../../widgets/login/snackbar.dart';
import '../../widgets/lottie/empty.dart';
import '../../widgets/menus/upper_widget.dart';

class AddPlusBillShortageScreen extends StatelessWidget {
  AddPlusBillShortageScreen({super.key});
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();
  final SupControllerImp supController = Get.find<SupControllerImp>();
  final BillShortageControllerImp billShortageController =
      Get.find<BillShortageControllerImp>();
  final BillShortageItemControllerImp billItemController =
      Get.find<BillShortageItemControllerImp>();
  final BillShortageCartControllerImp cartController =
      Get.find<BillShortageCartControllerImp>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (billShortageController.isLoading.value ||
              itemController.isLoading.value ||
              supController.isLoading.value ||
              billItemController.isLoading.value ||
              cartController.isLoading.value) {
            return const MyLottieLoading();
          } else {
            var bill = billShortageController.billsShortageListReversed[0];
            return Column(
              children: [
                UpperWidget(
                  isAdminScreen: false,
                  onPressed: () {},
                ),
                Expanded(
                  child: MyContainer(
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // bill details
                        BillDetails(
                            bill: bill,
                            cartController: cartController,
                            billShortageController: billShortageController),
                        Expanded(
                          child: Row(
                            children: [
                              //textfield for items and dropdown for sup
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //items
                                    Items(
                                        itemController: itemController,
                                        cartController: cartController,
                                        billController: billShortageController),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: AppSizes.w02,
                              ),
                              //cart items
                              Expanded(
                                  flex: 5,
                                  child: CartItems(
                                      cartController: cartController)),
                            ],
                          ),
                        ),
                        //save and print buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //clearCart
                            MyButton(
                              text: AppStrings.deleteAll,
                              minWidth: AppSizes.w3,
                              onPressed: () {
                                cartController.clearCart();
                              },
                            ),
                            //  print button
                            MyButton(
                              text: AppStrings.print,
                              minWidth: AppSizes.w3,
                              onPressed: () {
                                printFunc(bill: bill);
                              },
                            ),
                            // save button
                            MyButton(
                              text: AppStrings.save,
                              minWidth: AppSizes.w3,
                              onPressed: save,
                            ),

                            const Spacer(flex: 1),
                            Text(
                              '${AppStrings.total}  :  ${double.parse(cartController.totalCount.toString()).toStringAsFixed(2)}',
                              style: context.textTheme.bodySmall,
                            ),
                            const Spacer(flex: 1),
                          ],
                        )
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

  Future<void> printFunc({required Bill bill}) async {
    await billShortageController.getBillShortage();
    cartController.items.clear();
    List items = cartController.myCarts.keys.toList();
    for (int i = 0; i < items.length; i++) {
      cartController.items.add(
        [
          cartController.myCarts.values.toList()[i].toString(),
          items[i].itemNum.toString(),
          items[i].itemName
        ],
      );
    }
    printBill(
      billDate: billShortageController.billDate.isEmpty
          ? DateFormat.yMMMMEEEEd('ar').format(DateTime.now())
          : DateFormat.yMMMMEEEEd('ar')
              .format(billShortageController.date.value),
      billLenth: cartController.myCarts.length.toString(),
      billNumber: bill.billId.toString(),
      items: cartController.items,
      colums: [
        AppStrings.itemQuantity,
        AppStrings.itemNum,
        AppStrings.itemName,
      ],
      label: '${AppStrings.bill} ${AppStrings.billShortagePlus}',
      total:
          double.parse(cartController.totalCount.toString()).toStringAsFixed(2),
      kind: '1',
      endDate: '',
      startDate: '',
    );
  }

  void save() async {
    await billShortageController.getBillShortage();
    var bill = billShortageController.billsShortageListReversed[0];
    if (cartController.total == 0) {
      MySnackBar.snack(AppStrings.emptyList, '');
    } else {
      List items = cartController.myCarts.keys.toList();
      await billItemController.addBillShortageItemsGroup(
        items: items,
        billId: bill.billId.toString(),
        quantity: cartController.myCarts.values.toList(),
        isBack: false,
        time: billShortageController.billDate.value.isEmpty
            ? '${billShortageController.formatter.format(billShortageController.now)} ${DateTime.now().hour}:${DateTime.now().minute}:00'
            : billShortageController.billDate.value.toString(),
      );
      await itemController.updateStockItemsGroup(
        items: items,
        quantity: cartController.myCarts.values.toList(),
        kind: 1,
      );
      await billShortageController.saveBillShortage(
        id: bill.billId.toString(),
        sup: supController.selectedSup.value,
        total: cartController.totalCount,
        numberOfItems: cartController.myCarts.length.toString(),
        kind: '1',
        planId: '0',
      );
      await billShortageController.addBillShortage();
      await itemController.getItems();
      cartController.clearCart();
      supController.selectedSup.value = '';
      itemController.searchItemsList.clear();
    }
  }
}

class Items extends StatelessWidget {
  const Items({
    super.key,
    required this.itemController,
    required this.cartController,
    required this.billController,
  });

  final ItemControllerImp itemController;
  final BillShortageCartControllerImp cartController;
  final BillShortageControllerImp billController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          //for height
          SizedBox(
            height: AppSizes.h02,
          ),
          // Bill kind
          Row(
            children: [
              Text(
                ' ${AppStrings.itemKind} : ',
                style: context.textTheme.displayLarge,
              ),
              Expanded(
                child: MyDropMenu(
                  label: billController.kindLabel.value,
                  bodyItems: const [AppStrings.components, AppStrings.products],
                  onChanged: (value) {
                    switch (value) {
                      case AppStrings.components:
                        billController.kind.value = 1;
                        break;
                      case AppStrings.products:
                        billController.kind.value = 2;
                        break;
                    }
                    itemController.searchKind(
                      billController.kind.value.toString(),
                    );
                    // cartController.clearCart();
                    billController.kindLabel.value = value as String;
                  },
                ),
              ),
            ],
          ),
          //for height
          SizedBox(
            height: AppSizes.h02,
          ),
          //search  items
          MyTextField(
            controller: itemController.name,
            validate: (val) {},
            label: AppStrings.itemName,
            onChanged: (val) {
              itemController.search(
                  searchName: val, kind: billController.kind.value);
            },
            onSubmite: (val) {
              itemController.search(
                  searchName: val, kind: billController.kind.value);
            },
            hidePassword: false,
          ),
          //for height
          SizedBox(
            height: AppSizes.h02,
          ),

          Expanded(
            child: Obx(
              () {
                if (itemController.isLoading.value) {
                  return const MyLottieLoading();
                } else {
                  var list = itemController.searchItemsList;
                  if (list.isEmpty && itemController.name.text.isNotEmpty) {
                    return const MyLottieEmpty();
                  } else {
                    return ListView.separated(
                      itemCount: list.length,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          thickness: 2,
                        );
                      },
                      itemBuilder: (context, index) {
                        var item = list[index];

                        return GestureDetector(
                          onTap: () {
                            cartController.addToCarts(item: item);
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
    );
  }
}

class CartItems extends StatelessWidget {
  const CartItems({
    super.key,
    required this.cartController,
  });

  final BillShortageCartControllerImp cartController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (cartController.myCarts.isEmpty) {
          return Center(
            child: Text(
              AppStrings.emptyList,
              style: context.textTheme.titleSmall,
            ),
          );
        } else {
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: AppSizes.w25),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return BillPlusShortageCartItem(
                  index: index,
                  billItem: cartController.myCarts.keys.toList()[index],
                  quantity: double.parse(
                    cartController.myCarts.values.toList()[index].toString(),
                  ),
                );
              },
              itemCount: cartController.myCarts.length);
        }
      },
    );
  }
}

class BillDetails extends StatelessWidget {
  const BillDetails({
    super.key,
    required this.bill,
    required this.cartController,
    required this.billShortageController,
  });

  final Bill bill;
  final BillShortageCartControllerImp cartController;
  final BillShortageControllerImp billShortageController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Column(
          children: [
            Text(
              AppStrings.billShortagePlus,
              style: context.textTheme.displayLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  ' ${AppStrings.billNumper} : ${bill.billId.toString()}',
                  style: context.textTheme.displayLarge,
                ),
                Text(
                  ' ${AppStrings.numberOfitems} : ${cartController.myCarts.length.toString()}',
                  style: context.textTheme.displayLarge,
                ),
                Text(
                  '${AppStrings.billDate} : ${billShortageController.billDate}',
                  //${DateFormat.yMEd().format(DateTime.now())}',
                  style: context.textTheme.displayLarge,
                ),
                IconButton(
                  onPressed: () {
                    billShortageController.setBillDate(context: context);
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            ),

            SizedBox(
              height: AppSizes.h01,
            ),
            // Notes TextField
            MyTextField(
              hidePassword: false,
              validate: (v) {},
              label: AppStrings.notes,
              controller: billShortageController.billNotes,
            ),
            SizedBox(
              height: AppSizes.h01,
            ),
          ],
        );
      },
    );
  }
}
