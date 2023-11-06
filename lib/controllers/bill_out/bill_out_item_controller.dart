import 'package:intl/intl.dart';

import '../../data/models/items/item_model.dart';
import '../../data/repo/bill_out/bill_out_item_repo.dart';
import '../../libraries.dart';

abstract class BillOutItemController extends GetxController {
  addBillOutItem({
    required String time,
    required String billId,
    required Item item,
    required double itemCount,
    required String kind,
  });
  editItems(
      {required String billId, required Item item, required String itemCount});
  getitemsbyBillService({required String billId});
  getItemsbyBillId({required String billId});
  getItemsByIndex({required String billId});
  deleteAllBillItems({required String billId});
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

class BillOutItemControllerImp extends BillOutItemController {
  var billsOutItemsList = <Item>[].obs;
  List<Item> billsOutSearchItemsList = <Item>[].obs;
  bool isShown = true;
  var isLoading = false.obs;
  List<Item> billsOutAllItemsInRange = <Item>[].obs;
  List<Item> billsOutItemInRange = <Item>[].obs;
  var billOutItemsInDay = <Item>[].obs;
  var formatter = DateFormat('yyyy-MM-dd');

  @override
  addBillOutItem({
    required String time,
    required String billId,
    required Item item,
    required double itemCount,
    required String kind,
  }) async {
    isLoading.value = true;
    var addBillOut = await BillsOutItemRepo.addBillOutItem(
        item: item,
        itemCount: itemCount.toString(),
        billId: billId,
        kind: kind,
        time: time);

    try {
      if (addBillOut.status == "suc") {
        isLoading(false);
        update();
      } else if (addBillOut.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      //MySnackBar.snack('please try later', 'Some thing went wrong');
      isLoading(false);
      update();
    }
  }

  addBillOutItemsGroup({
    required List items,
    required String billId,
    required String time,
    required bool isBack,
    required List quantity,
  }) async {
    for (int i = 0; i < items.length; i++) {
      await addBillOutItem(
        billId: billId,
        item: items[i],
        itemCount: double.parse(quantity[i].toString()),
        kind:
            isBack ? (items[i].kind + 2).toString() : items[i].kind.toString(),
        time: time,
      );
    }
  }

  @override
  editItems(
      {required String billId,
      required Item item,
      required String itemCount}) async {
    isLoading.value = true;
    var editItem = await BillsOutItemRepo.editBillOutItem(
        item: item, itemCount: itemCount, billId: billId);

    try {
      if (editItem.status == "suc") {
        isLoading(false);
        update();
      } else if (editItem.status == "fail") {
        // MySnackBar.snack(MyStrings.noitemsEdited, 'Some thing went wrong');
        isLoading(false);
        update();
      }
    } catch (_) {
      //MySnackBar.snack('please try later', 'Some thing went wrong');
      isLoading(false);
      update();
    }
  }

  @override
  deleteAllBillItems({required String billId}) async {
    isLoading(true);
    var item = await BillsOutItemRepo.deleteBillOutItem(id: billId);
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
    var items = await BillsOutItemRepo.getBillOutItems(billId: billId);
    return items.data;
  }

  @override
  getItemsbyBillId({required String billId}) async {
    var items = await getitemsbyBillService(billId: billId);
    isLoading(true);
    billsOutItemsList.value = items;
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
      billsOutItemsList.value = items;
    }
    isLoading(false);
  }

  @override
  getAllItemsinRange({
    required String start,
    required String end,
  }) async {
    isLoading.value = true;
    var items = await BillsOutItemRepo.getBillOutAllItemsInRange(
      starDate: start,
      endDate: end,
    );
    try {
      if (items.status == "suc") {
        billsOutAllItemsInRange.addAll(items.data);
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
    var item = await BillsOutItemRepo.getBillOutItemInRange(
      starDate: start,
      endDate: end,
      itemNum: itemNum,
    );
    try {
      if (item.status == "suc") {
        billsOutItemInRange.addAll(item.data);
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
      var items =
          await BillsOutItemRepo.getAllItemsInDay(date: formatter.format(date));
      if (items.status == 'suc') {
        billOutItemsInDay.clear();
        billOutItemsInDay.addAll(items.data);
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

 // await Future.delayed(const Duration(seconds: 2));