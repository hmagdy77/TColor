import 'package:intl/intl.dart';

import '../../data/models/items/item_model.dart';
import '../../libraries.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class StockReportController extends GetxController {
  // com
  addItemsToComCart({required Item item});
  addListToComCart({required List items});
  prepareComBillInItems({required Item item});
  prepareComBillStockItems({required Item item});
  prepareComBillShortageItems({required Item item});
  prepareComBillOutItems({required Item item});
  updateComItems({
    required List items,
    required String kind,
  });
  // prod
  addItemsToProdCart({required Item item});
  addListToProdCart({required List items});
  prepareProBillOutItems({required Item item});
  prepareProBillShortageItems({required Item item});
  prepareProBillFactoryItems({required Item item});
  updateProdItems({
    required List items,
    required String kind,
  });
  // sub com
  addItemsToSubComCart({required Item item});
  addListToSubComCart({required List items});
  prepareSubComBillStockItems({required Item item});
  prepareeSubComBillFactoryItems({required Item item});
  updateSubComItems({
    required List items,
    required String kind,
  });
  void clearSubComCart();
  // other
  void search({required String searchName, required int kind});
  void removeOneProduct(Item item, int index);
  void clearComCart();
  void clearProdCart();
  setDate({required context, required bool start, required bool end});
}

class StockReportControllerImp extends StockReportController {
  Map componentsUniqeCarts = {}.obs;
  Map proudctsUniqeCarts = {}.obs;
  Map subComponentsUniqeCarts = {}.obs;
  List componentsSearch = [].obs;
  List proudctsSearch = [].obs;
  List subComponentsSearch = [].obs;
  List<List<String>> items = [];
  late TextEditingController searchProdTextField;
  late TextEditingController searchComTextField;
  late TextEditingController searchSubComTextField;
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
    searchSubComTextField = TextEditingController();
    clearComCart();
    clearProdCart();
    clearSubComCart();
    super.onInit();
  }

  @override
  void dispose() {
    searchProdTextField.dispose();
    searchComTextField.dispose();
    searchSubComTextField.dispose();
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
        itemPriceIn: '0.0', // bill in
        itemPriceOut: '0.0', //back bill in
        itemExchange: '0.0', //exchange
        itemDone: '0.0', //   back exchange
        itemMin: '0.0', //     bill out
        itemMax: '0.0', //     back bill out
        billId: '0.0', //shortahe plaus
        stockId: '0.0', //shortahe minus
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
  prepareComBillStockItems({required Item item}) {
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
            itemExchange: item.kind == 1
                ? (double.parse(item.itemCount) +
                        double.parse(value.itemExchange))
                    .toString()
                : value.itemExchange,
            itemDone: item.kind == 3
                ? (double.parse(item.itemCount) + double.parse(value.itemDone))
                    .toString()
                : value.itemDone,
            itemPriceIn: value.itemPriceIn,
            itemPriceOut: value.itemPriceOut,
            itemMax: value.itemMax,
            itemMin: value.itemMin,
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
  prepareComBillShortageItems({required Item item}) {
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
            stockId: item.kind == 3
                ? (double.parse(item.itemCount) + double.parse(value.stockId))
                    .toString()
                : value.stockId,
            billId: item.kind == 1
                ? (double.parse(item.itemCount) + double.parse(value.billId))
                    .toString()
                : value.billId,
            itemExchange: value.itemExchange,
            itemDone: value.itemDone,
            itemPriceIn: value.itemPriceIn,
            itemPriceOut: value.itemPriceOut,
            itemMax: value.itemMax,
            itemMin: value.itemMin,
            itemQuant: value.itemQuant,
            itemQuantWight: value.itemQuantWight,
            itemSubQuant: value.itemSubQuant,
            itemSup: value.itemSup,
            itemTime: value.itemTime,
            kind: value.kind,
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
            itemPriceIn: item.kind == 1
                ? (double.parse(item.itemCount) +
                        double.parse(value.itemPriceIn))
                    .toString()
                : value.itemPriceIn,
            itemPriceOut: item.kind == 3
                ? (double.parse(item.itemCount) +
                        double.parse(value.itemPriceOut))
                    .toString()
                : value.itemPriceOut,
            itemQuant: value.itemQuant,
            itemQuantWight: value.itemQuantWight,
            itemSubQuant: value.itemSubQuant,
            itemSup: value.itemSup,
            itemTime: value.itemTime,
            kind: value.kind,
            stockId: value.stockId,
            billId: value.billId,
            itemMax: value.itemMax,
            itemMin: value.itemMin,
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
    required String kind,
  }) {
    isLoading(true);
    if (kind == AppStrings.billIn) {
      for (int index = 0; index < items.length; index++) {
        prepareComBillInItems(item: items[index]);
      }
    } else if (kind == AppStrings.billOut) {
      for (int index = 0; index < items.length; index++) {
        prepareComBillOutItems(item: items[index]);
      }
    } else if (kind == AppStrings.billStock) {
      for (int index = 0; index < items.length; index++) {
        prepareComBillStockItems(item: items[index]);
      }
    } else if (kind == AppStrings.billShortage) {
      for (int index = 0; index < items.length; index++) {
        prepareComBillShortageItems(item: items[index]);
      }
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
        itemPriceIn: '0.0', // bill in
        itemPriceOut: '0.0', //back bill in
        itemExchange: '0.0', //exchange
        itemDone: '0.0', //   back exchange
        itemMin: '0.0', //     bill out
        itemMax: '0.0', //     back bill out
        billId: '0.0', //shortage plus
        stockId: '0.0', // shortage minus
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
  prepareProBillFactoryItems({required Item item}) {
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
            itemMax: value.itemMax,
            itemMin: value.itemMin,
            planId: value.planId,
            ingredientsNumber: value.ingredientsNumber,
            itemDone: value.itemDone,
            itemWight: value.itemWight,
            itemExchange: value.itemExchange,
            itemUsed: (double.parse(item.itemQuantWight) +
                    double.parse(value.itemUsed))
                .toString(),
          );
          return ing;
        },
      );
    }
  }

  @override
  prepareProBillShortageItems({required Item item}) {
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
            itemPriceIn: value.itemPriceIn,
            itemPriceOut: value.itemPriceOut,
            itemQuant: value.itemQuant,
            itemQuantWight: value.itemQuantWight,
            itemSubQuant: value.itemSubQuant,
            itemSup: value.itemSup,
            itemTime: value.itemTime,
            kind: value.kind,
            stockId: item.kind == 4
                ? (double.parse(item.itemCount) + double.parse(value.stockId))
                    .toString()
                : value.stockId,
            billId: item.kind == 2
                ? (double.parse(item.itemCount) + double.parse(value.billId))
                    .toString()
                : value.billId,
            itemMax: value.itemMax,
            itemMin: value.itemMin,
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
  updateProdItems({
    required List items,
    required String kind,
  }) {
    isLoading(true);
    if (kind == AppStrings.billOut) {
      for (int index = 0; index < items.length; index++) {
        prepareProBillOutItems(item: items[index]);
      }
    } else if (kind == AppStrings.theFactory) {
      for (int index = 0; index < items.length; index++) {
        prepareProBillFactoryItems(item: items[index]);
      }
    } else if (kind == AppStrings.billShortage) {
      for (int index = 0; index < items.length; index++) {
        prepareProBillShortageItems(item: items[index]);
      }
    }
    isLoading(false);
    prepared(true);
  }

// sub Com
  @override
  addItemsToSubComCart({required Item item}) {
    if (subComponentsUniqeCarts.containsKey(item.itemNum)) {
      MySnackBar.snack(AppStrings.found, '');
    } else {
      subComponentsUniqeCarts[item.itemNum] = Item(
        itemId: item.itemId,
        itemName: item.itemName,
        itemNum: item.itemNum,
        itemSup: item.itemSup,
        itemQuant: item.itemQuant,
        itemQuantWight: item.itemQuantWight,
        itemSubQuant: item.itemSubQuant,
        itemPriceIn: '0.0', // bill in
        itemPriceOut: '0.0', //back bill in
        itemExchange: '0.0', //exchange
        itemDone: '0.0', //   back exchange
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
  addListToSubComCart({required List items}) {
    subComponentsUniqeCarts.clear();
    for (int index = 0; index < items.length; index++) {
      addItemsToSubComCart(
        item: items[index],
      );
    }
  }

  @override
  prepareSubComBillStockItems({required Item item}) {
    if (subComponentsUniqeCarts.containsKey(item.itemNum)) {
      subComponentsUniqeCarts.update(
        item.itemNum,
        (value) {
          Item ing = Item(
            itemId: value.itemId,
            itemName: value.itemName,
            itemNum: value.itemNum,
            itemCount: value.itemCount,
            itemPakage: value.itemPakage,
            itemPiec: value.itemPiec,
            itemExchange: item.kind == 1
                ? (double.parse(item.itemCount) +
                        double.parse(value.itemExchange))
                    .toString()
                : value.itemExchange,
            itemDone: item.kind == 3
                ? (double.parse(item.itemCount) + double.parse(value.itemDone))
                    .toString()
                : value.itemDone,
            itemPriceIn: value.itemPriceIn,
            itemPriceOut: value.itemPriceOut,
            itemMax: value.itemMax,
            itemMin: value.itemMin,
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
  prepareeSubComBillFactoryItems({required Item item}) {
    if (subComponentsUniqeCarts.containsKey(item.itemNum)) {
      subComponentsUniqeCarts.update(
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
            itemMax: value.itemMax,
            itemMin: value.itemMin,
            planId: value.planId,
            ingredientsNumber: value.ingredientsNumber,
            itemDone: value.itemDone,
            itemWight: value.itemWight,
            itemExchange: value.itemExchange,
            itemUsed:
                (double.parse(item.itemCount) + double.parse(value.itemUsed))
                    .toString(),
          );
          return ing;
        },
      );
    }
  }

  @override
  updateSubComItems({
    required List items,
    required String kind,
  }) {
    isLoading(true);
    if (kind == AppStrings.billStock) {
      for (int index = 0; index < items.length; index++) {
        prepareSubComBillStockItems(item: items[index]);
      }
    } else if (kind == AppStrings.theFactory) {
      for (int index = 0; index < items.length; index++) {
        prepareeSubComBillFactoryItems(item: items[index]);
      }
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
      case 3:
        subComponentsSearch = subComponentsUniqeCarts.values.toList().where(
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
  void clearSubComCart() {
    subComponentsUniqeCarts.clear();
    subComponentsSearch.clear();
    searchSubComTextField.clear();
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
