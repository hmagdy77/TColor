import 'package:intl/intl.dart';

import '../../../controllers/bill_out/bill_out_cart.dart';
import '../../../controllers/bill_out/bill_out_controller.dart';
import '../../../controllers/bill_out/bill_out_item_controller.dart';
import '../../../controllers/items/item_controller.dart';
import '../../../controllers/supplires/sup_controller.dart';
import '../../../core/print/pdf_bill.dart';
import '../../../data/models/bills/bill_model.dart';
import '../../../libraries.dart';
import '../../widgets/bills_out/bill_out_back_cart_item.dart';
import '../../widgets/drop_menu/drop_menu.dart';
import '../../widgets/items/item_widget.dart';
import '../../widgets/login/snackbar.dart';
import '../../widgets/lottie/empty.dart';
import '../../widgets/menus/upper_widget.dart';

class AddBackBillOutScreen extends StatelessWidget {
  AddBackBillOutScreen({super.key});
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();
  final SupControllerImp supController = Get.find<SupControllerImp>();
  final BillOutControllerImp billOutController =
      Get.find<BillOutControllerImp>();
  final BillOutItemControllerImp billItemController =
      Get.find<BillOutItemControllerImp>();
  final BillOutCartControllerImp cartController =
      Get.find<BillOutCartControllerImp>();
  @override
  Widget build(BuildContext context) {
    // int? isAdmin =
    //     cartController.myService.sharedPreferences.getOutt(AppStrings.adminKey);
    return Scaffold(
      body: Obx(
        () {
          if (billOutController.isLoading.value ||
              itemController.isLoading.value ||
              supController.isLoading.value ||
              billItemController.isLoading.value ||
              cartController.isLoading.value) {
            return const MyLottieLoading();
          } else {
            var bill = billOutController.billsOutListReversed[0];
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
                            billOutController: billOutController),

                        Expanded(
                          child: Row(
                            children: [
                              //textfield for items and dropdown for sup
                              Expanded(
                                flex: 3,
                                child: Items(
                                  itemController: itemController,
                                  cartController: cartController,
                                  billController: billOutController,
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

  Future<void> printFunc({required Bill bill}) async {
    await billOutController.getBillsOut();
    cartController.items.clear();
    List items = cartController.myCarts.keys.toList();
    for (int i = 0; i < items.length; i++) {
      cartController.items.add(
        [
          (double.parse(items[i].itemPriceOut) *
                  double.parse(
                      cartController.myCarts.values.toList()[i].toString()))
              .toString(),
          items[i].itemPriceOut,
          cartController.myCarts.values.toList()[i].toString(),
          items[i].itemNum.toString(),
          items[i].itemName
        ],
      );
    }
    printBill(
      billDate: billOutController.billDate.isEmpty
          ? DateFormat.yMMMMEEEEd('ar').format(DateTime.now())
          : DateFormat.yMMMMEEEEd('ar').format(billOutController.date.value),
      billLenth: cartController.myCarts.length.toString(),
      billNumber: bill.billId.toString(),
      items: cartController.items,
      colums: [
        AppStrings.total,
        AppStrings.itemPriceOut,
        AppStrings.itemQuantity,
        AppStrings.itemNum,
        AppStrings.itemName,
      ],
      label: AppStrings.backBillOut,
      total: double.parse(cartController.total.toString()).toStringAsFixed(2),
      kind: '1',
      endDate: '',
      startDate: '',
    );
  }

  void save() async {
    await billOutController.getBillsOut();
    var bill = billOutController.billsOutListReversed[0];
    if (cartController.total == 0) {
      MySnackBar.snack(AppStrings.emptyList, '');
    } else {
      List items = cartController.myCarts.keys.toList();
      await billItemController.addBillOutItemsGroup(
        items: items,
        billId: bill.billId.toString(),
        quantity: cartController.myCarts.values.toList(),
        isBack: true,
        time: billOutController.billDate.value.isEmpty
            ? '${billOutController.formatter.format(billOutController.now)} ${DateTime.now().hour}:${DateTime.now().minute}:00'
            : billOutController.billDate.value.toString(),
      );
      await itemController.updateStockItemsGroup(
        items: items,
        quantity: cartController.myCarts.values.toList(),
        kind: 1,
      );
      await billOutController.saveBillOut(
        id: bill.billId.toString(),
        sup: supController.selectedSup.value,
        total: cartController.total,
        numberOfItems: cartController.myCarts.length.toString(),
        kind: '2',
        planId: '0',
      );
      await billOutController.addBillOut();
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
  final BillOutCartControllerImp cartController;
  final BillOutControllerImp billController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Bill kind
        Row(
          children: [
            Text(
              ' ${AppStrings.billKind} : ',
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
    );
  }
}

class CartItems extends StatelessWidget {
  const CartItems({
    super.key,
    required this.cartController,
  });

  final BillOutCartControllerImp cartController;

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
              return BillOutBackCartItem(
                index: index,
                billItem: cartController.myCarts.keys.toList()[index],
                quantity: double.parse(
                    cartController.myCarts.values.toList()[index].toString()),
              );
            },
            itemCount: cartController.myCarts.length,
          );
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
    required this.billOutController,
  });

  final Bill bill;
  final BillOutCartControllerImp cartController;
  final BillOutControllerImp billOutController;

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
                  ' ${AppStrings.billOutBackNumper} : ${bill.billId.toString()}',
                  style: context.textTheme.displayLarge,
                ),
                Text(
                  ' ${AppStrings.numberOfitems} : ${cartController.myCarts.length.toString()}',
                  style: context.textTheme.displayLarge,
                ),
                Text(
                  '${AppStrings.billDate} : ${billOutController.billDate}',
                  //${DateFormat.yMEd().format(DateTime.now())}',
                  style: context.textTheme.displayLarge,
                ),
                IconButton(
                  onPressed: () {
                    billOutController.setBillDate(context: context);
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            ),

            SizedBox(
              height: AppSizes.h01,
            ),
            // Notes TextField
            Row(
              children: [
                Expanded(
                  child: MyTextField(
                    hidePassword: false,
                    validate: (v) {},
                    label: AppStrings.agentName,
                    controller: billOutController.agentName,
                  ),
                ),
                SizedBox(
                  width: AppSizes.h02,
                ),
                Expanded(
                  child: MyTextField(
                    hidePassword: false,
                    validate: (v) {},
                    label: AppStrings.agentPhone,
                    controller: billOutController.agentPhone,
                  ),
                ),
                SizedBox(
                  width: AppSizes.h02,
                ),
                Expanded(
                  flex: 2,
                  child: MyTextField(
                    hidePassword: false,
                    validate: (v) {},
                    label: AppStrings.notes,
                    controller: billOutController.billNotes,
                  ),
                ),
              ],
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
