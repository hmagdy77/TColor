import 'package:intl/intl.dart';

import '../../data/models/items/item_model.dart';
import '../../libraries.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class BillFactoryReportController extends GetxController {
  // com
  addItemsToComCart({required Item item});
  addListToComCart({required List items});
  prepareComBillFactoryItems({required Item item});
  updateComItems({
    required List items,
  });
  // prod
  addItemsToProdCart({required Item item});
  addListToProdCart({required List items});
  prepareProBillFactoryItems({required Item item});
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

class BillFactoryReportControllerImp extends BillFactoryReportController {
  Map componentsUniqeCarts = {}.obs;
  Map proudctsUniqeCarts = {}.obs;
  List componentsSearch = [].obs;
  List proudctsSearch = [].obs;
  late TextEditingController searchProdTextField;
  late TextEditingController searchComTextField;
  List<List<String>> items = [];
  var prepared = false.obs;
  var isLoading = false.obs;
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
  addListToComCart({required List items}) {
    componentsUniqeCarts.clear();
    for (int index = 0; index < items.length; index++) {
      addItemsToComCart(
        item: items[index],
      );
    }
  }

  @override
  prepareComBillFactoryItems({required Item item}) {
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
  updateComItems({
    required List items,
  }) {
    isLoading(true);
    for (int index = 0; index < items.length; index++) {
      prepareComBillFactoryItems(item: items[index]);
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
        itemQuantWight: '0.0',
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
  addListToProdCart({required List items}) {
    proudctsUniqeCarts.clear();
    for (int index = 0; index < items.length; index++) {
      addItemsToProdCart(
        item: items[index],
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
            itemQuantWight: (double.parse(item.itemQuantWight) +
                    double.parse(value.itemQuantWight))
                .toString(),
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
  updateProdItems({
    required List items,
  }) {
    isLoading(true);
    for (int index = 0; index < items.length; index++) {
      prepareProBillFactoryItems(item: items[index]);
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
