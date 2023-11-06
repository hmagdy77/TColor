import 'package:intl/intl.dart';

import '../../data/models/items/item_model.dart';
import '../../data/repo/bill_factory/bill_factory_item_repo.dart';
import '../../libraries.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class BillFactoryItemController extends GetxController {
  addItems({
    required String time,
    required String billId,
    required Item item,
    required String planId,
    required String kind,
  });
  // editItems({
  //   required {required String billId},
  //   required Item item,
  //   required String itemCount,
  // });
  getitemsbyBillService({required String billId});
  getItemsbyBillId({required String billId});
  getItemsByIndex({required String billId});
  deleteItems({required String billId});
  sortItems();
  getAllItemsinRange({
    required String start,
    required String end,
  });
  getIteminRange({
    required String itemNum,
    required String start,
    required String end,
  });
  getAllItemsInDay({required DateTime date});
}

class BillFactoryItemControllerImp extends BillFactoryItemController {
  List<Item> allBillFactoryItems = <Item>[].obs;
  List<Item> billItemsComponents = <Item>[].obs;
  List<Item> billItemsProudcts = <Item>[].obs;
  List<Item> billsFactorySearchItemsList = <Item>[].obs;
  List<Item> billFactoryAllItemsInRange = <Item>[].obs;
  List<Item> billFactoryItemInRange = <Item>[].obs;
  var billFactoryItemsInDay = <Item>[].obs;
  bool isShown = true;
  var isLoading = false.obs;
  var formatter = DateFormat('yyyy-MM-dd');

  @override
  addItems({
    required String time,
    required String billId,
    required Item item,
    required String planId,
    required String kind,
  }) async {
    isLoading.value = true;
    try {
      var addBillOutItem = await BillsFactoryItemRepo.addBillFactoryItem(
        item: item,
        planId: planId,
        kind: kind,
        billId: billId,
        time: time,
      );

      if (addBillOutItem.status == "suc") {
        isLoading(false);
        update();
      } else if (addBillOutItem.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      MySnackBar.snack('$_', 'Erorr');
      isLoading(false);
      update();
    }
  }

  // @override
  // editItems(
  //     {required {required String billId},
  //     required Item item,
  //     required String itemCount}) async {
  //   isLoading.value = true;
  //   var editItem = await Crud.postRequest(
  //     AppStrings.apiEditBillsOutItems,
  //     {
  //       'item_id': item.itemId.toString(),
  //       'item_name': item.itemName,
  //       'item_num': item.itemNum,
  //       'item_sup': item.itemSup,
  //       'item_price_in': 'itemPriceOut',
  //       'item_price_out': item.itemPriceOut.toString(),
  //       'item_count': itemCount.toString(),
  //       'bill_id': billId,
  //     },
  //     statusModelFromJson,
  //   );
  //   try {
  //     if (editItem.status == "suc") {
  //       isLoading(false);
  //       update();
  //     } else if (editItem.status == "fail") {
  //       isLoading(false);
  //       update();
  //     }
  //   } catch (_) {
  //     //MySnackBar.snack('please try later', 'Some thing went wrong');
  //     isLoading(false);
  //     update();
  //   }
  // }

  @override
  void sortItems() {
    billItemsProudcts.clear();
    billItemsProudcts = allBillFactoryItems
        .where(
          (item) {
            var kind = item.kind;
            return kind == 2;
          },
        )
        .toList()
        .reversed
        .toList();
    billItemsComponents.clear();
    billItemsComponents = allBillFactoryItems
        .where(
          (item) {
            var kind = item.kind;
            return kind == 1;
          },
        )
        .toList()
        .reversed
        .toList();
  }

  @override
  deleteItems({required String billId}) async {
    isLoading(true);
    var item = await BillsFactoryItemRepo.deleteBillFactoryItem(id: billId);
    if (item.status == 'suc') {
      isLoading(false);
      update();
    } else if (item.status == 'fail') {
      isLoading(false);
      update();
    }
  }

  @override
  getitemsbyBillService({required String billId}) async {
    var items = await BillsFactoryItemRepo.getBillsFactoryItems(billId: billId);
    return items.data;
  }

  @override
  getItemsbyBillId({required String billId}) async {
    var items = await getitemsbyBillService(billId: billId);
    isLoading(true);
    allBillFactoryItems = items;
    isLoading(false);
    if (items.isEmpty) {
      isLoading(false);
      update();
    }
  }

  @override
  getItemsByIndex({required String billId}) async {
    isLoading(true);
    var items = await getItemsbyBillId(billId: billId);
    if (items != null) {
      allBillFactoryItems = items;
    }
    sortItems();

    isLoading(false);
  }

  @override
  getAllItemsinRange({
    required String start,
    required String end,
  }) async {
    isLoading.value = true;
    var items = await BillsFactoryItemRepo.getBillOutAllItemsInRange(
      starDate: start,
      endDate: end,
    );
    try {
      if (items.status == "suc") {
        billFactoryAllItemsInRange.addAll(items.data);
        isLoading(false);
        update();
      } else if (items.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  getIteminRange({
    required String itemNum,
    required String start,
    required String end,
  }) async {
    isLoading.value = true;
    var item = await BillsFactoryItemRepo.getBillOutItemInRange(
      starDate: start,
      endDate: end,
      itemNum: itemNum,
    );
    try {
      if (item.status == "suc") {
        billFactoryItemInRange.addAll(item.data);
        isLoading(false);
        update();
      } else if (item.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  getAllItemsInDay({required DateTime date}) async {
    isLoading(true);
    update();
    try {
      var items = await BillsFactoryItemRepo.getAllItemsInDay(
          date: formatter.format(date));
      if (items.status == 'suc') {
        billFactoryItemsInDay.addAll(items.data);
        isLoading(false);
        update();
      } else {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }
}
