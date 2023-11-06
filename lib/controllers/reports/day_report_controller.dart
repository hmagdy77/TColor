import 'package:intl/intl.dart';

import '../../data/models/items/item_model.dart';
import '../../libraries.dart';

abstract class DayReportsController extends GetxController {
  // Bills In
  prepareComBillsInItems({required Item item});
  updateBillsInItems({required List items});
  // bills Stock
  prepareComBillsStockItems({required Item item});
  updateBillsStockItems({required List items});
  //  Bills Out
  prepareComBillOutItems({required Item item});
  prepareProBillOutItems({required Item item});
  updateBillsOutItems({required List items});
  //  Bills Factory
  prepareComBillFactoryItems({required Item item});
  prepareProBillFactoryItems({required Item item});
  updateBillsFactoryItems({required List items});
  //  Bills Shortage
  prepareComBillShortageItems({required Item item});
  prepareProBillShortageItems({required Item item});
  updateBillsShortageItems({required List items});

  void clearAllCart();
  setDate({required context});
}

class DayReportsControllerImp extends DayReportsController {
  Map billsInCarts = {}.obs;
  Map billsStockCarts = {}.obs;
  Map billsOutComCarts = {}.obs;
  Map billsOutProdCarts = {}.obs;
  Map billsFactoryComCarts = {}.obs;
  Map billsFactoryProdCarts = {}.obs;
  Map billsShortageComCarts = {}.obs;
  Map billsShortageProdCarts = {}.obs;
  List<List<String>> billsInPrintList = [];
  List<List<String>> billsStockPrintList = [];
  List<List<String>> billsOutComPrintList = [];
  List<List<String>> billsOutProdPrintList = [];
  List<List<String>> billsFactoryComPrintList = [];
  List<List<String>> billsFactoryProdPrintList = [];
  List<List<String>> billsShortageComPrintList = [];
  List<List<String>> billsShortageProdPrintList = [];
  var prepared = false.obs;
  var isLoading = false.obs;
  var formatter = DateFormat('yyyy-MM-dd');
  var currentDate = DateTime.now().obs;
  var currentDateView = ''.obs;

  @override
  void onInit() {
    clearAllCart();

    super.onInit();
  }

  // Bills In
  @override
  prepareComBillsInItems({required Item item}) {
    if (billsInCarts.containsKey(item.itemNum)) {
      billsInCarts.update(
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
    } else {
      billsInCarts[item.itemNum] = Item(
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
        itemMin: item.kind == 1 ? item.itemCount : item.itemMin,
        itemMax: item.kind == 3 ? item.itemCount : item.itemMax,
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
  updateBillsInItems({
    required List items,
  }) {
    isLoading(true);
    for (int index = 0; index < items.length; index++) {
      prepareComBillsInItems(item: items[index]);
    }
    isLoading(false);
    prepared(true);
  }

  // Bills In
  @override
  prepareComBillsStockItems({required Item item}) {
    if (billsStockCarts.containsKey(item.itemNum)) {
      billsStockCarts.update(
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
    } else {
      billsStockCarts[item.itemNum] = Item(
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
        itemMin: item.kind == 1 ? item.itemCount : item.itemMin,
        itemMax: item.kind == 3 ? item.itemCount : item.itemMax,
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
  updateBillsStockItems({required List items}) {
    isLoading(true);
    for (int index = 0; index < items.length; index++) {
      prepareComBillsStockItems(item: items[index]);
    }
    isLoading(false);
    prepared(true);
  }

  // Bills Out
  @override
  prepareComBillOutItems({required Item item}) {
    if (billsOutComCarts.containsKey(item.itemNum) &&
        (item.kind == 1 || item.kind == 3)) {
      billsOutComCarts.update(
        item.itemNum,
        (value) {
          Item ing = Item(
            itemId: value.itemId,
            itemName: value.itemName,
            itemNum: value.itemNum,
            itemCount: value.itemCount,
            itemPakage: value.itemPakage,
            itemPiec: value.itemPiec,
            itemMin: item.kind == 1
                ? (double.parse(item.itemCount) + double.parse(value.itemMin))
                    .toString()
                : value.itemMin,
            itemMax: item.kind == 3
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
    } else if (!billsOutComCarts.containsKey(item.itemNum) &&
        (item.kind == 1 || item.kind == 3)) {
      billsOutComCarts[item.itemNum] = Item(
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
        itemMin: item.kind == 1 ? item.itemCount : item.itemMin,
        itemMax: item.kind == 3 ? item.itemCount : item.itemMax,
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
  prepareProBillOutItems({required Item item}) {
    if (billsOutProdCarts.containsKey(item.itemNum) &&
        (item.kind == 2 || item.kind == 4)) {
      billsOutProdCarts.update(
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
    } else if (!billsOutProdCarts.containsKey(item.itemNum) &&
        (item.kind == 2 || item.kind == 4)) {
      billsOutProdCarts[item.itemNum] = Item(
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
        itemMin: item.kind == 2 ? item.itemCount : item.itemMin,
        itemMax: item.kind == 4 ? item.itemCount : item.itemMax,
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
  updateBillsOutItems({required List items}) {
    isLoading(true);
    for (int index = 0; index < items.length; index++) {
      prepareComBillOutItems(item: items[index]);
      prepareProBillOutItems(item: items[index]);
    }
    isLoading(false);
    prepared(true);
  }

  // Bills Factory
  @override
  prepareComBillFactoryItems({required Item item}) {
    if (billsFactoryComCarts.containsKey(item.itemNum) &&
        (item.kind == 1 || item.kind == 3)) {
      billsFactoryComCarts.update(
        item.itemNum,
        (value) {
          Item ing = Item(
            itemId: value.itemId,
            itemName: value.itemName,
            itemNum: value.itemNum,
            itemCount: value.itemCount,
            itemPakage: value.itemPakage,
            itemPiec: value.itemPiec,
            itemMin: item.kind == 1
                ? (double.parse(item.itemCount) + double.parse(value.itemMin))
                    .toString()
                : value.itemMin,
            itemMax: item.kind == 3
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
    } else if (!billsFactoryComCarts.containsKey(item.itemNum) &&
        (item.kind == 1 || item.kind == 3)) {
      billsFactoryComCarts[item.itemNum] = Item(
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
        itemMin: item.kind == 1 ? item.itemCount : item.itemMin,
        itemMax: item.kind == 3 ? item.itemCount : item.itemMax,
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
  prepareProBillFactoryItems({required Item item}) {
    if (billsFactoryProdCarts.containsKey(item.itemNum) &&
        (item.kind == 2 || item.kind == 4)) {
      billsFactoryProdCarts.update(
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
            itemQuantWight: (double.parse(item.itemQuantWight) +
                    double.parse(value.itemQuantWight))
                .toString(),
            itemExchange: value.itemExchange,
            itemDone: value.itemDone,
            itemPriceIn: value.itemPriceIn,
            itemPriceOut: value.itemPriceOut,
            itemQuant: value.itemQuant,
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
    } else if (!billsFactoryProdCarts.containsKey(item.itemNum) &&
        (item.kind == 2 || item.kind == 4)) {
      billsFactoryProdCarts[item.itemNum] = Item(
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
        itemMin: item.kind == 2 ? item.itemCount : item.itemMin,
        itemMax: item.kind == 4 ? item.itemCount : item.itemMax,
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
  updateBillsFactoryItems({required List items}) {
    isLoading(true);
    for (int index = 0; index < items.length; index++) {
      prepareComBillFactoryItems(item: items[index]);
      prepareProBillFactoryItems(item: items[index]);
    }
    isLoading(false);
    prepared(true);
  }

// Bills Shortage
  @override
  prepareComBillShortageItems({required Item item}) {
    if (billsShortageComCarts.containsKey(item.itemNum) &&
        (item.kind == 1 || item.kind == 3)) {
      billsShortageComCarts.update(
        item.itemNum,
        (value) {
          Item ing = Item(
            itemId: value.itemId,
            itemName: value.itemName,
            itemNum: value.itemNum,
            itemCount: value.itemCount,
            itemPakage: value.itemPakage,
            itemPiec: value.itemPiec,
            itemMin: item.kind == 1
                ? (double.parse(item.itemCount) + double.parse(value.itemMin))
                    .toString()
                : value.itemMin,
            itemMax: item.kind == 3
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
    } else if (!billsShortageComCarts.containsKey(item.itemNum) &&
        (item.kind == 1 || item.kind == 3)) {
      billsShortageComCarts[item.itemNum] = Item(
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
        itemMin: item.kind == 1 ? item.itemCount : item.itemMin,
        itemMax: item.kind == 3 ? item.itemCount : item.itemMax,
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
  prepareProBillShortageItems({required Item item}) {
    if (billsShortageProdCarts.containsKey(item.itemNum) &&
        (item.kind == 2 || item.kind == 4)) {
      billsShortageProdCarts.update(
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
    } else if (!billsShortageProdCarts.containsKey(item.itemNum) &&
        (item.kind == 2 || item.kind == 4)) {
      billsShortageProdCarts[item.itemNum] = Item(
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
        itemMin: item.kind == 2 ? item.itemCount : item.itemMin,
        itemMax: item.kind == 4 ? item.itemCount : item.itemMax,
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
  updateBillsShortageItems({required List items}) {
    isLoading(true);
    for (int index = 0; index < items.length; index++) {
      prepareComBillShortageItems(item: items[index]);
      prepareProBillShortageItems(item: items[index]);
    }
    isLoading(false);
    prepared(true);
  }

  @override
  void clearAllCart() {
    billsInCarts.clear();
    billsOutComCarts.clear();
    billsOutProdCarts.clear();
    billsStockCarts.clear();
    billsFactoryComCarts.clear();
    billsFactoryProdCarts.clear();
    billsShortageComCarts.clear();
    billsShortageProdCarts.clear();
    update();
  }

  void clearAllPrintsList() {
    billsInPrintList.clear();
    billsOutComPrintList.clear();
    billsOutProdPrintList.clear();
    billsStockPrintList.clear();
    billsFactoryComPrintList.clear();
    billsFactoryProdPrintList.clear();
    billsShortageComPrintList.clear();
    billsShortageProdPrintList.clear();
    update();
  }

  @override
  setDate({required context}) {
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
        currentDateView.value = formatter.format(pickedDate);
        currentDate.value = pickedDate;
      },
    );
  }
}
