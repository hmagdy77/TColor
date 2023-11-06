import 'package:intl/intl.dart';

import '../../data/models/items/item_model.dart';
import '../../data/repo/bill_in/bill_in_item_repo.dart';
import '../../libraries.dart';

abstract class BillInItemController extends GetxController {
  addBillInItem({
    required String time,
    required String billId,
    required Item item,
    required double itemCount,
    required String kind,
  });
  editItems(
      {required String billId, required Item item, required String itemCount});
  getitemsbyBillService(String billId);
  getItemsbyBillId(String billId);
  getItemsByIndex(String billId);
  deleteAllBillItems(String billId);
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

class BillInItemControllerImp extends BillInItemController {
  var billsInItemsList = <Item>[].obs;
  List<Item> billsInSearchItemsList = <Item>[].obs;
  List<Item> billsInAllItemsInRange = <Item>[].obs;
  List<Item> billsInItemInRange = <Item>[].obs;
  var billInItemsInDay = <Item>[].obs;
  bool isShown = true;
  var isLoading = false.obs;
  var formatter = DateFormat('yyyy-MM-dd');

  @override
  addBillInItem({
    required String time,
    required String billId,
    required Item item,
    required double itemCount,
    required String kind,
  }) async {
    isLoading.value = true;
    var addBillIn = await BillsInItemRepo.addBillInItem(
        item: item,
        itemCount: itemCount.toString(),
        billId: billId,
        kind: kind,
        time: time);
    try {
      if (addBillIn.status == "suc") {
        isLoading(false);
        update();
      } else if (addBillIn.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      //MySnackBar.snack('please try later', 'Some thing went wrong');
      isLoading(false);
      update();
    }
  }

  addBillInItemsGroup({
    required List items,
    required String billId,
    required List quantity,
    required String kind,
    required String time,
  }) async {
    for (int i = 0; i < items.length; i++) {
      await addBillInItem(
          billId: billId,
          item: items[i],
          itemCount: double.parse(quantity[i].toString()),
          kind: kind,
          time: time);
    }
  }

  @override
  editItems(
      {required String billId,
      required Item item,
      required String itemCount}) async {
    isLoading.value = true;
    var editItem = await BillsInItemRepo.editBillInItem(
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
  deleteAllBillItems(String billId) async {
    isLoading(true);
    var item = await BillsInItemRepo.deleteBillInItem(id: billId);
    if (item.status == 'suc') {
      isLoading(false);
      update();
    } else if (item.status == 'fail') {
      isLoading(false);
      update();
    }
  }

  @override
  getitemsbyBillService(String billId) async {
    var items = await BillsInItemRepo.getBillInItems(billId: billId);
    return items.data;
  }

  @override
  getItemsbyBillId(String billId) async {
    var items = await getitemsbyBillService(billId);
    isLoading(true);
    billsInItemsList.value = items;
    isLoading(false);
    if (items.isEmpty) {
      isLoading(false);
      update();
    }
  }

  @override
  getItemsByIndex(String billId) async {
    isLoading(true);
    var items = await getItemsbyBillId(billId);
    if (items != null) {
      billsInItemsList.value = items;
    }
    isLoading(false);
  }

  @override
  getAllItemsinRange({
    required String start,
    required String end,
  }) async {
    isLoading.value = true;
    var items = await BillsInItemRepo.getBillInAllItemsInRange(
      starDate: start,
      endDate: end,
    );

    if (items.status == "suc") {
      billsInAllItemsInRange.addAll(items.data);
      isLoading(false);
      update();
    } else if (items.status == "fail") {
      isLoading(false);
      update();
    }
    try {} catch (_) {
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
    var item = await BillsInItemRepo.getBillInItemInRange(
      starDate: start,
      endDate: end,
      itemNum: itemNum,
    );
    try {
      if (item.status == "suc") {
        billsInItemInRange.addAll(item.data);
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
          await BillsInItemRepo.getAllItemsInDay(date: formatter.format(date));
      if (items.status == 'suc') {
        billInItemsInDay.clear();
        billInItemsInDay.addAll(items.data);
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