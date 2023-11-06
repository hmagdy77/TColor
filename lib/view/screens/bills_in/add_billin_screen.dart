import 'package:intl/intl.dart';

import '../../../controllers/bill_in/bill_in_cart.dart';
import '../../../controllers/bill_in/bill_in_controller.dart';
import '../../../controllers/bill_in/bill_in_item_controller.dart';
import '../../../controllers/items/item_controller.dart';
import '../../../controllers/supplires/sup_controller.dart';
import '../../../core/print/pdf_bill.dart';
import '../../../data/models/bills/bill_model.dart';
import '../../../libraries.dart';
import '../../widgets/bills_in/bill_in_cart_item.dart';
import '../../widgets/drop_menu/drop_menu.dart';
import '../../widgets/items/item_widget.dart';
import '../../widgets/login/snackbar.dart';
import '../../widgets/lottie/empty.dart';
import '../../widgets/menus/upper_widget.dart';

class AddBillInScreen extends StatelessWidget {
  AddBillInScreen({super.key});
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();
  final SupControllerImp supController = Get.find<SupControllerImp>();
  final BillInControllerImp billInController = Get.find<BillInControllerImp>();
  final BillInItemControllerImp billItemController =
      Get.find<BillInItemControllerImp>();
  final BillInCartControllerImp cartController =
      Get.find<BillInCartControllerImp>();
  @override
  Widget build(BuildContext context) {
    // billInController.billsInSearchList.clear();
    // itemController.getItems();
    // int? isAdmin =
    //     cartController.myService.sharedPreferences.getInt(AppStrings.adminKey);
    return Scaffold(
      body: Obx(
        () {
          if (billInController.isLoading.value ||
              itemController.isLoading.value ||
              supController.isLoading.value ||
              billItemController.isLoading.value ||
              cartController.isLoading.value) {
            return const MyLottieLoading();
          } else {
            var bill = billInController.billsInListReversed[0];
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
                            billInController: billInController),

                        Expanded(
                          child: Row(
                            children: [
                              //textfield for items and dropdown for sup
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //search  items
                                    SearchTextFiel(
                                      itemController: itemController,
                                      cartController: cartController,
                                      supController: supController,
                                    ),
                                    //for height
                                    SizedBox(
                                      height: AppSizes.h02,
                                    ),
                                    //items
                                    Expanded(
                                      child: Items(
                                        itemController: itemController,
                                        cartController: cartController,
                                      ),
                                    ),
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
                                  printFun(bill: bill);
                                }),
                            // save button
                            MyButton(
                              text: AppStrings.save,
                              minWidth: AppSizes.w3,
                              onPressed: save,
                            ),

                            const Spacer(flex: 1),
                            Text(
                              '${AppStrings.total}  :  ${double.parse(cartController.total.toString()).toStringAsFixed(2)}',
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

  Future<void> printFun({required Bill bill}) async {
    await billInController.getBillsIn();
    cartController.items.clear();
    List items = cartController.myCarts.keys.toList();
    for (int i = 0; i < items.length; i++) {
      cartController.items.add(
        [
          (double.parse(items[i].itemPriceIn) *
                  double.parse(
                      cartController.myCarts.values.toList()[i].toString()))
              .toString(),
          items[i].itemPriceIn,
          cartController.myCarts.values.toList()[i].toString(),
          items[i].itemNum.toString(),
          items[i].itemName
        ],
      );
    }
    printBill(
      //
      billDate: billInController.billDate.isEmpty
          ? DateFormat.yMMMMEEEEd('ar').format(DateTime.now())
          : DateFormat.yMMMMEEEEd('ar').format(billInController.date.value),
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
      label: AppStrings.billIn,
      total: double.parse(cartController.total.toString()).toStringAsFixed(2),
      kind: '1',
      endDate: '',
      startDate: '',
    );
  }

  void save() async {
    await billInController.getBillsIn();
    var sup = supController.selectedSup.value;
    var bill = billInController.billsInListReversed[0];
    if (sup.isEmpty) {
      MySnackBar.snack(AppStrings.choseSup, '');
    } else if (cartController.total == 0) {
      MySnackBar.snack(AppStrings.emptyList, '');
    } else {
      List items = cartController.myCarts.keys.toList();
      await billItemController.addBillInItemsGroup(
        items: items,
        billId: bill.billId.toString(),
        quantity: cartController.myCarts.values.toList(),
        kind: '1',
        time: billInController.billDate.value.isEmpty
            ? '${billInController.formatter.format(billInController.now)} ${DateTime.now().hour}:${DateTime.now().minute}:00'
            : billInController.billDate.value.toString(),
      );
      await itemController.updateStockItemsGroup(
        items: items,
        quantity: cartController.myCarts.values.toList(),
        kind: 1,
      );
      await billInController.saveBillIn(
        id: bill.billId.toString(),
        sup: supController.selectedSup.value,
        total: cartController.total,
        numberOfItems: cartController.myCarts.length.toString(),
        kind: '1',
      );
      await billInController.addBillIn();
      await itemController.getItems();
      cartController.clearCart();
      supController.selectedSup.value = '';
      itemController.searchItemsList.clear();
    }
  }
}

class SearchTextFiel extends StatelessWidget {
  const SearchTextFiel({
    super.key,
    required this.itemController,
    required this.cartController,
    required this.supController,
  });

  final ItemControllerImp itemController;
  final BillInCartControllerImp cartController;
  final SupControllerImp supController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              ' ${AppStrings.supName} : ',
              style: context.textTheme.displayLarge,
            ),
            Expanded(
              child: MyDropMenu(
                label: supController.selectedSup.value,
                bodyItems: supController.supListNames,
                onChanged: (value) {
                  itemController.search(searchName: value.toString(), kind: 1);
                  cartController.myCarts.clear();
                  cartController.controllers!.clear();
                  cartController.isOverd!.clear();

                  supController.selectedSup.value = value as String;
                },
              ),
            ),
          ],
        ),
        //for height
        SizedBox(
          height: AppSizes.h02,
        ),
        MyTextField(
          controller: itemController.name,
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
            itemController.search(searchName: val, kind: 1);
          },
          onSubmite: (val) {
            itemController.search(searchName: val, kind: 1);
          },
          hidePassword: false,
        ),
      ],
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
  final BillInCartControllerImp cartController;

  @override
  Widget build(BuildContext context) {
    return Obx(
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
    );
  }
}

class CartItems extends StatelessWidget {
  const CartItems({
    super.key,
    required this.cartController,
  });

  final BillInCartControllerImp cartController;

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
                  maxCrossAxisExtent: AppSizes.w3),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return BillInCartItem(
                  isBack: false,
                  inEdit: false,
                  index: index,
                  billInItem: cartController.myCarts.keys.toList()[index],
                  quantity: double.parse(
                      cartController.myCarts.values.toList()[index].toString()),
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
    required this.billInController,
  });

  final Bill bill;
  final BillInCartControllerImp cartController;
  final BillInControllerImp billInController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  ' ${AppStrings.billInNumper} : ${bill.billId.toString()}',
                  style: context.textTheme.displayLarge,
                ),
                Text(
                  ' ${AppStrings.numberOfitems} : ${cartController.myCarts.length.toString()}',
                  style: context.textTheme.displayLarge,
                ),
                Text(
                  '${AppStrings.billDate} : ${billInController.billDate}',
                  //${DateFormat.yMEd().format(DateTime.now())}',
                  style: context.textTheme.displayLarge,
                ),
                IconButton(
                  onPressed: () {
                    billInController.setBillDate(context: context);
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            ),
            SizedBox(
              height: AppSizes.h01,
            ),
            MyTextField(
              hidePassword: false,
              validate: (v) {},
              label: AppStrings.notes,
              controller: billInController.billNotes,
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
