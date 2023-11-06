import 'package:intl/intl.dart';

import '../../data/models/items/item_model.dart';
import '../../data/repo/bill_Stock/bill_Stock_item_repo.dart';
import '../../libraries.dart';

abstract class BillStockItemController extends GetxController {
  addBillStockItem({
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
  getIteminRange({
    required String itemNum,
    required String start,
    required String end,
  });
  getAllItemsinRange({
    required String start,
    required String end,
  });

  getAllItemsInDay({required DateTime date});
}

class BillStockItemControllerImp extends BillStockItemController {
  var billsStockItemsList = <Item>[].obs;
  List<Item> billsStockSearchItemsList = <Item>[].obs;
  var billsStockItemInRange = <Item>[].obs;
  var billsStockAllItemsInRange = <Item>[].obs;
  var billStockItemsInDay = <Item>[].obs;
  bool isShown = true;
  var isLoading = false.obs;
  var formatter = DateFormat('yyyy-MM-dd');
  var startDate = ''.obs;
  var endDate = ''.obs;

  @override
  addBillStockItem({
    required String time,
    required String billId,
    required Item item,
    required double itemCount,
    required String kind,
  }) async {
    isLoading.value = true;
    var addBillStock = await BillsStockItemRepo.addBillStockItem(
      item: item,
      itemCount: itemCount.toString(),
      billId: billId,
      kind: kind,
      time: time,
    );
    try {
      if (addBillStock.status == "suc") {
        isLoading(false);
        update();
      } else if (addBillStock.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      //MySnackBar.snack('please try later', 'Some thStockg went wrong');
      isLoading(false);
      update();
    }
  }

  addBillStockItemsGroup({
    required List items,
    required String billId,
    required List quantity,
    required String kind,
    required String time,
  }) async {
    for (int i = 0; i < items.length; i++) {
      await addBillStockItem(
        billId: billId,
        item: items[i],
        itemCount: double.parse(quantity[i].toString()),
        kind: kind,
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
    var editItem = await BillsStockItemRepo.editBillStockItem(
        item: item, itemCount: itemCount, billId: billId);

    try {
      if (editItem.status == "suc") {
        isLoading(false);
        update();
      } else if (editItem.status == "fail") {
        // MySnackBar.snack(MyStrings.noitemsEdited, 'Some thStockg went wrong');
        isLoading(false);
        update();
      }
    } catch (_) {
      //MySnackBar.snack('please try later', 'Some thStockg went wrong');
      isLoading(false);
      update();
    }
  }

  @override
  deleteAllBillItems(String billId) async {
    isLoading(true);
    var item = await BillsStockItemRepo.deleteBillStockItem(id: billId);

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
    var items = await BillsStockItemRepo.getBillStockItems(billId: billId);
    return items.data;
  }

  @override
  getItemsbyBillId(String billId) async {
    var items = await getitemsbyBillService(billId);
    isLoading(true);
    billsStockItemsList.value = items;
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
      billsStockItemsList.value = items;
    }
    isLoading(false);
  }

  @override
  getAllItemsinRange({
    required String start,
    required String end,
  }) async {
    isLoading.value = true;
    var items = await BillsStockItemRepo.getBillStockAllItemsInRange(
      starDate: start,
      endDate: end,
    );
    try {
      if (items.status == "suc") {
        billsStockAllItemsInRange.addAll(items.data);
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
    var item = await BillsStockItemRepo.getBillStockItemInRange(
      starDate: start,
      endDate: end,
      itemNum: itemNum,
    );
    try {
      if (item.status == "suc") {
        billsStockItemInRange.addAll(item.data);
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
      var items = await BillsStockItemRepo.getAllItemsInDay(
          date: formatter.format(date));
      if (items.status == 'suc') {
        billStockItemsInDay.clear();
        billStockItemsInDay.addAll(items.data);
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