import 'package:intl/intl.dart';

import '../../../../controllers/supplires/sup_controller.dart';
import '../../../../libraries.dart';
import '../../../controllers/bill_stock/bill_stock_cart.dart';
import '../../../controllers/bill_stock/bill_stock_controller.dart';
import '../../../controllers/bill_stock/bill_stock_items_controller.dart';
import '../../../controllers/items/item_controller.dart';
import '../../../core/print/pdf_bill.dart';
import '../../../data/models/bills/bill_model.dart';
import '../../../data/models/items/item_model.dart';
import '../../widgets/items/item_cart_item.dart';
import '../../widgets/items/item_widget.dart';
import '../../widgets/items/wanted_item_back.dart';
import '../../widgets/login/snackbar.dart';
import '../../widgets/lottie/empty.dart';
import '../../widgets/menus/upper_widget.dart';

class AddBillBackStockScreen extends StatelessWidget {
  AddBillBackStockScreen({super.key});

  final BillStockCartControllerImp billStockCartController =
      Get.find<BillStockCartControllerImp>();
  final BillStockControllerImp billStockController =
      Get.find<BillStockControllerImp>();
  final BillStockItemControllerImp billStockItemController =
      Get.find<BillStockItemControllerImp>();
  final SupControllerImp supController = Get.find<SupControllerImp>();
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (billStockCartController.isLoading.value ||
              billStockController.isLoading.value ||
              supController.isLoading.value ||
              billStockController.isLoading.value) {
            return const MyLottieLoading();
          } else {
            var bill = billStockController.billsStockListReversed[0];
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
                          cartController: billStockCartController,
                          billStockController: billStockController,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              //textfield for items and dropdown for sup
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //search items
                                    SearchTextFiels(
                                      itemController: itemController,
                                      cartController: billStockCartController,
                                      supController: supController,
                                    ),
                                    //for height
                                    SizedBox(
                                      height: AppSizes.h02,
                                    ),
                                    //items
                                    Items(
                                        itemController: itemController,
                                        cartController:
                                            billStockCartController),
                                  ],
                                ),
                              ),
                              SizedBox(width: AppSizes.w01),
                              //cart items
                              Expanded(
                                flex: 3,
                                child: CartItems(
                                    cartController: billStockCartController),
                              ),
                              SizedBox(width: AppSizes.w01),
                              Expanded(
                                flex: 3,
                                child: WantedItems(
                                  itemController: itemController,
                                ),
                              ),
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
                                billStockCartController.clearCart();
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
                            const Spacer(),
                            Text(
                              '${AppStrings.total}  :  ${double.parse(billStockCartController.getNumberOfPieces.toString())} ${AppStrings.kgm}',
                              style: context.textTheme.bodySmall,
                            ),
                            const Spacer(),
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
    await billStockController.getBillsStock();
    billStockCartController.items.clear();
    List items = billStockCartController.myCarts.keys.toList();
    for (int i = 0; i < items.length; i++) {
      billStockCartController.items.add(
        [
          billStockCartController.myCarts.values.toList()[i].toString(),
          items[i].itemNum,
          items[i].itemName
        ],
      );
    }
    printBill(
      billDate: billStockController.billDate.isEmpty
          ? DateFormat.yMMMMEEEEd('ar').format(DateTime.now())
          : DateFormat.yMMMMEEEEd('ar').format(billStockController.date.value),
      billLenth: billStockCartController.myCarts.length.toString(),
      billNumber: bill.billId.toString(),
      items: billStockCartController.items,
      colums: [
        AppStrings.itemQuantity,
        AppStrings.itemNum,
        AppStrings.itemName,
      ],
      label: AppStrings.backBillStock,
      kind: '1',
      endDate: '',
      startDate: '',
      total: '0',
    );
  }

  void save() async {
    await billStockController.getBillsStock();
    var bill = billStockController.billsStockListReversed[0];
    if (billStockCartController.isOverd!.contains(true)) {
      MySnackBar.snack(AppStrings.orderdQuantityNotFound, '');
    } else if (billStockCartController.myCarts.isEmpty) {
      MySnackBar.snack(AppStrings.emptyList, '');
    } else {
      List items = billStockCartController.myCarts.keys.toList();
      List quantities = billStockCartController.myCarts.values.toList();
      // upload bill stock items
      await billStockItemController.addBillStockItemsGroup(
        items: items,
        billId: bill.billId.toString(),
        quantity: quantities,
        kind: '3',
        time: billStockController.billDate.value.isEmpty
            ? '${billStockController.formatter.format(billStockController.now)} ${DateTime.now().hour}:${DateTime.now().minute}:00'
            : billStockController.billDate.value.toString(),
      );
      // minus from main stock
      await itemController.updateStockItemsGroup(
        items: items,
        quantity: quantities,
        kind: 1,
      );
      // add to sub stock
      await itemController.updateSubStockItemsGroup(
        items: items,
        subQuantity: quantities,
        kind: 2,
      );
      // save bill stock
      await billStockController.saveBillStock(
        id: bill.billId.toString(),
        sup: supController.selectedSup.value,
        total: billStockCartController.getNumberOfPieces.toString(),
        numberOfItems: billStockCartController.myCarts.length.toString(),
        kind: '2',
        planId: 'plan',
      );
      // add new bill
      await billStockController.addBill();
      await itemController.getItems();
      billStockController.billStockSearchController.clear();
      billStockCartController.clearCart();
      supController.selectedSup.value = '';
      itemController.searchItemsList.clear();
    }
  }
}

class SearchTextFiels extends StatelessWidget {
  const SearchTextFiels({
    super.key,
    required this.itemController,
    required this.cartController,
    required this.supController,
  });

  final ItemControllerImp itemController;
  final BillStockCartControllerImp cartController;
  final SupControllerImp supController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(
          controller: itemController.name,
          validate: (val) {},
          label: AppStrings.search,
          onChanged: (val) {
            itemController.search(searchName: val, kind: 3);
          },
          onSubmite: (val) {
            itemController.search(searchName: val, kind: 3);
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
  final BillStockCartControllerImp cartController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}

class CartItems extends StatelessWidget {
  const CartItems({
    super.key,
    required this.cartController,
  });

  final BillStockCartControllerImp cartController;

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
                return ItemCart(
                  index: index,
                  item: cartController.myCarts.keys.toList()[index],
                  quantity: double.parse(
                    cartController.myCarts.values.toList()[index].toString(),
                  ),
                  isMain: false,
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
    required this.billStockController,
  });

  final Bill bill;
  final BillStockCartControllerImp cartController;
  final BillStockControllerImp billStockController;

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
                  ' ${AppStrings.billStockBackNumper} : ${bill.billId.toString()}',
                  style: context.textTheme.displayLarge,
                ),
                Text(
                  ' ${AppStrings.numberOfitems} : ${cartController.myCarts.length.toString()}',
                  style: context.textTheme.displayLarge,
                ),
                Text(
                  '${AppStrings.date} : ${billStockController.billDate.value}',
                  //${DateFormat.yMEd().format(DateTime.now())}',
                  style: context.textTheme.displayLarge,
                ),
                IconButton(
                  onPressed: () {
                    billStockController.setBillDate(context: context);
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
              controller: billStockController.billNotes,
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

class WantedItems extends StatelessWidget {
  const WantedItems({
    super.key,
    required this.itemController,
  });
  final ItemControllerImp itemController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColorManger.greyLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 2, color: AppColorManger.black),
      ),
      child: Column(
        children: [
          const Text(AppStrings.subStock),
          SizedBox(height: AppSizes.h01),
          Expanded(
            child: Obx(
              () {
                if (itemController.isLoading.value) {
                  return const MyLottieLoading();
                } else {
                  if (itemController.subStockItemsList.isEmpty) {
                    return const Text(AppStrings.emptyList);
                  } else {
                    return Column(
                      children: [
                        const WantedItemBack(index: 1, kind: AppStrings.header),
                        Expanded(
                          child: ListView.builder(
                            itemCount: itemController.subStockItemsList.length,
                            itemBuilder: (context, index) {
                              Item item =
                                  itemController.subStockItemsList[index];
                              return Builder(
                                builder: (context) {
                                  return WantedItemBack(
                                    item: item,
                                    index: index,
                                    kind: AppStrings.body,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        const WantedItemBack(index: 1, kind: AppStrings.bottom),
                      ],
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
