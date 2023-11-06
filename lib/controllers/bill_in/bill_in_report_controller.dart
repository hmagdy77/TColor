import 'package:intl/intl.dart';

import '../../data/models/items/item_model.dart';
import '../../libraries.dart';

abstract class BillInReportController extends GetxController {
  // com
  addItemsToComCart({required Item item});
  addListToComCart({required List items});
  prepareComBillInItems({required Item item});
  updateComItems({required List items});
  // other
  void search({required String searchName});
  void removeOneProduct(Item item, int index);
  void clearComCart();
  setDate({required context, required bool start, required bool end});
}

class BillInReportControllerImp extends BillInReportController {
  Map componentsUniqeCarts = {}.obs;
  List componentsSearch = [].obs;
  List<List<String>> items = [];
  late TextEditingController searchComTextField;
  var prepared = false.obs;
  var isLoading = false.obs;
  List<List<String>> printItemsList = [];
  var formatter = DateFormat('yyyy-MM-dd');
  var startDate = ''.obs;
  var endDate = ''.obs;
  var startDateView = DateTime.now().obs;
  var endDateView = DateTime.now().obs;

  @override
  void onInit() {
    searchComTextField = TextEditingController();
    clearComCart();
    super.onInit();
  }

  @override
  void dispose() {
    searchComTextField.dispose();
    super.dispose();
  }

  @override
  addItemsToComCart({required Item item}) {
    if (componentsUniqeCarts.containsKey(item.itemNum)) {
    } else {
      componentsUniqeCarts[item.itemNum] = Item(
        itemId: item.itemId,
        itemName: item.itemName,
        itemNum: item.itemNum,
        itemSup: item.itemSup,
        itemQuant: item.itemQuant,
        itemQuantWight: item.itemQuantWight,
        itemSubQuant: item.itemSubQuant,
        itemPriceIn: item.itemPriceIn,
        itemPriceOut: item.itemPriceOut,
        itemExchange: '0.0', //exchange
        itemDone: '0.0', //    back exchange
        itemMin: '0.0', //     bill in
        itemMax: '0.0', //     back bill in
        billId: item.billId,
        stockId: item.stockId,
        itemPakage: item.itemPakage,
        itemPiec: item.itemPiec,
        planId: item.planId,
        kind: item.kind,
        ingredientsNumber: item.ingredientsNumber,
        itemTime: item.itemTime,
        itemCount: '0.0',
        itemWight: item.itemWight,
        itemUsed: '0.0',
      );
    }
  }

  @override
  addListToComCart({required List items}) {
    componentsUniqeCarts.clear();
    for (int index = 0; index < items.length; index++) {
      addItemsToComCart(
        item: items[index],
      );
    }
  }

  @override
  prepareComBillInItems({required Item item}) {
    if (componentsUniqeCarts.containsKey(item.itemNum)) {
      componentsUniqeCarts.update(
        item.itemNum,
        (value) {
          Item ing = Item(
            itemId: value.itemId,
            itemName: value.itemName,
            itemNum: value.itemNum,
            itemCount: value.itemCount,
            itemPakage: value.itemPakage,
            itemPiec: value.itemPiec,
            itemPriceIn: value.itemPriceIn,
            itemPriceOut: value.itemPriceOut,
            itemQuant: value.itemQuant,
            itemQuantWight: value.itemQuantWight,
            itemSubQuant: value.itemSubQuant,
            itemSup: value.itemSup,
            itemTime: value.itemTime,
            kind: value.kind,
            stockId: value.stockId,
            billId: value.billId,
            itemMin: item.kind == 1
                ? (double.parse(item.itemCount) + double.parse(value.itemMin))
                    .toString()
                : value.itemMin,
            itemMax: item.kind == 3
                ? (double.parse(item.itemCount) + double.parse(value.itemMax))
                    .toString()
                : value.itemMax,
            planId: value.planId,
            ingredientsNumber: value.ingredientsNumber,
            itemDone: value.itemDone,
            itemWight: value.itemWight,
            itemExchange: value.itemExchange,
            itemUsed: value.itemUsed,
          );
          return ing;
        },
      );
    }
  }

  @override
  updateComItems({
    required List items,
  }) {
    isLoading(true);
    for (int index = 0; index < items.length; index++) {
      prepareComBillInItems(item: items[index]);
    }
    isLoading(false);
    prepared(true);
  }

// other

  @override
  void search({required String searchName}) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    componentsSearch = componentsUniqeCarts.values.toList().where(
      (item) {
        var itemName = item.itemName;
        var itemSup = item.itemSup.toLowerCase();
        var itemNum = item.itemNum.toLowerCase();
        var itemId = item.itemId.toString();
        return itemName.contains(searchName) ||
            itemNum.contains(searchName) ||
            itemSup.contains(searchName) ||
            itemId.contains(searchName);
      },
    ).toList();
    isLoading(false);
    update();
  }

  @override
  void removeOneProduct(Item item, int index) {
    componentsUniqeCarts.removeWhere((key, value) => value == item.itemNum);
  }

  @override
  void clearComCart() {
    componentsUniqeCarts.clear();
    componentsSearch.clear();
    searchComTextField.clear();
    update();
  }

  @override
  setDate({required context, required bool start, required bool end}) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      // locale: const Locale('ar'),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        if (start) {
          startDate.value = formatter.format(pickedDate);
          startDateView.value = pickedDate;
        } else if (end) {
          endDate.value = formatter.format(pickedDate);
          endDateView.value = pickedDate;
        }
      },
    );
  }
}
