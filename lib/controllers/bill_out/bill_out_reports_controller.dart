import 'package:intl/intl.dart';

import '../../data/models/items/item_model.dart';
import '../../libraries.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class BillOutReportController extends GetxController {
  // com
  addItemsToComCart({required Item item});
  addListToComCart({required List items});
  prepareComBillOutItems({required Item item});
  updateComItems({
    required List items,
  });
  // prod
  addItemsToProdCart({required Item item});
  addListToProdCart({required List items});
  prepareProBillOutItems({required Item item});
  updateProdItems({
    required List items,
  });
  // other
  void search({required String searchName, required int kind});
  void removeOneProduct(Item item, int index);
  void clearComCart();
  void clearProdCart();
  setDate({required context, required bool start, required bool end});
}

class BillOutReportControllerImp extends BillOutReportController {
  Map componentsUniqeCarts = {}.obs;
  Map proudctsUniqeCarts = {}.obs;
  List componentsSearch = [].obs;
  List proudctsSearch = [].obs;
  List<List<String>> items = [];
  late TextEditingController searchProdTextField;
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
    searchProdTextField = TextEditingController();
    searchComTextField = TextEditingController();
    clearComCart();
    clearProdCart();
    super.onInit();
  }

  @override
  void dispose() {
    searchProdTextField.dispose();
    searchComTextField.dispose();
    super.dispose();
  }

  @override
  addItemsToComCart({required Item item}) {
    if (componentsUniqeCarts.containsKey(item.itemNum)) {
      MySnackBar.snack(AppStrings.found, '');
    } else {
      componentsUniqeCarts[item.itemNum] = Item(
        itemId: item.itemId,
        itemName: item.itemName,
        itemNum: item.itemNum,
        itemSup: item.itemSup,
        itemQuant: item.itemQuant,
        itemQuantWight: item.itemQuantWight,
        itemSubQuant: item.itemSubQuant,
        itemPriceIn: item.itemPriceIn, // bill in
        itemPriceOut: item.itemPriceOut, //back bill in
        itemExchange: item.itemExchange, //exchange
        itemDone: item.itemDone, //   back exchange
        itemMin: '0.0', //     bill out
        itemMax: '0.0', //     back bill out
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
  prepareComBillOutItems({required Item item}) {
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
            itemMin: item.kind == 1 || item.kind == 2
                ? (double.parse(item.itemCount) + double.parse(value.itemMin))
                    .toString()
                : value.itemMin,
            itemMax: item.kind == 3 || item.kind == 4
                ? (double.parse(item.itemCount) + double.parse(value.itemMax))
                    .toString()
                : value.itemMax,
            itemExchange: value.itemExchange,
            itemDone: value.itemDone,
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
            planId: value.planId,
            ingredientsNumber: value.ingredientsNumber,
            itemWight: value.itemWight,
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
      prepareComBillOutItems(item: items[index]);
    }
    isLoading(false);
    prepared(true);
  }

// Prod
  @override
  addItemsToProdCart({required Item item}) {
    if (proudctsUniqeCarts.containsKey(item.itemNum)) {
      MySnackBar.snack(AppStrings.found, '');
    } else {
      proudctsUniqeCarts[item.itemNum] = Item(
        itemId: item.itemId,
        itemName: item.itemName,
        itemNum: item.itemNum,
        itemSup: item.itemSup,
        itemQuant: item.itemQuant,
        itemQuantWight: item.itemQuantWight,
        itemSubQuant: item.itemSubQuant,
        itemPriceIn: item.itemPriceIn, // bill in
        itemPriceOut: item.itemPriceOut, //back bill in
        itemExchange: item.itemExchange, //exchange
        itemDone: item.itemDone, //   back exchange
        itemMin: '0.0', //     bill out
        itemMax: '0.0', //     back bill out
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
  addListToProdCart({required List items}) {
    proudctsUniqeCarts.clear();
    for (int index = 0; index < items.length; index++) {
      addItemsToProdCart(
        item: items[index],
      );
    }
  }

  @override
  prepareProBillOutItems({required Item item}) {
    if (proudctsUniqeCarts.containsKey(item.itemNum)) {
      proudctsUniqeCarts.update(
        item.itemNum,
        (value) {
          Item ing = Item(
            itemId: value.itemId,
            itemName: value.itemName,
            itemNum: value.itemNum,
            itemCount: value.itemCount,
            itemPakage: value.itemPakage,
            itemPiec: value.itemPiec,
            itemMin: item.kind == 1 || item.kind == 2
                ? (double.parse(item.itemCount) + double.parse(value.itemMin))
                    .toString()
                : value.itemMin,
            itemMax: item.kind == 3 || item.kind == 4
                ? (double.parse(item.itemCount) + double.parse(value.itemMax))
                    .toString()
                : value.itemMax,
            itemExchange: value.itemExchange,
            itemDone: value.itemDone,
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
            planId: value.planId,
            ingredientsNumber: value.ingredientsNumber,
            itemWight: value.itemWight,
            itemUsed: value.itemUsed,
          );
          return ing;
        },
      );
    }
  }

  @override
  updateProdItems({
    required List items,
  }) {
    isLoading(true);
    for (int index = 0; index < items.length; index++) {
      prepareProBillOutItems(item: items[index]);
    }
    isLoading(false);
    prepared(true);
  }

// other

  @override
  void search({required String searchName, required int kind}) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    switch (kind) {
      case 1:
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
        break;
      case 2:
        proudctsSearch = proudctsUniqeCarts.values.toList().where(
          (item) {
            var itemName = item.itemName;
            var itemNum = item.itemNum.toLowerCase();
            var itemprice = item.itemNum.toLowerCase();
            var itemId = item.itemId.toString();
            return itemName.contains(searchName) ||
                itemNum.contains(searchName) ||
                itemprice.contains(searchName) ||
                itemId.contains(searchName);
          },
        ).toList();
        break;
    }
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
  void clearProdCart() {
    proudctsUniqeCarts.clear();
    proudctsSearch.clear();
    searchProdTextField.clear();
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
