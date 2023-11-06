import '../../data/models/items/item_model.dart';
import '../../libraries.dart';

abstract class SubStockCartController extends GetxController {
  addToCarts({required Item item});
  addToUniqeCarts({required Item item, required String count});
  addListToUniqeCart({required Map items});
  prepareStockToUniqeCart({required Item item});
  prepareStockListToUniqeCart({required List items});
  removeFromCart({required Item item});
  void updateQuantity(
      {required Item item, required int quantity, required int quantityDigit});
  void removeOneProduct(Item item, int index);
  void clearCart();
}

class SubStockCartControllerImp extends SubStockCartController {
  Map myCarts = {}.obs;
  Map myFinalUniqeCarts = {}.obs;
  // Map myUniqeCartsBeforePrepare = {}.obs;
  var prepared = false.obs;
  var isLoading = false.obs;
  List<List<String>> items = [];
  List<TextEditingController>? controllers = [];
  List<TextEditingController>? controllersDigits = [];
  List<bool>? isFound = [];
  List<bool>? isOverd = [];
  late TextEditingController numberOfPices;
  var finalCartsMainQuant = 0.0.obs;
  var finalCartsWanted = 0.0.obs;
  var finalCartsSubQuant = 0.0.obs;

  @override
  void onInit() {
    numberOfPices = TextEditingController();
    clearCart();
    super.onInit();
  }

  @override
  void dispose() {
    numberOfPices.dispose();
    super.dispose();
  }

  @override
  void updateQuantity(
      {required Item item, required int quantity, required int quantityDigit}) {
    myCarts.update(item, (value) => double.parse('$quantity.$quantityDigit'));
  }

  @override
  addToCarts({required Item item}) {
    if (myCarts.containsValue(item.itemNum)) {
      myCarts[item.itemQuant] += item.itemQuant;
    } else {
      myCarts[item] = 1.0;
    }
  }

  addListToCart({required List<Item> items}) {
    for (int index = 0; index < items.length; index++) {
      addToCarts(item: items[index]);
    }
  }

  @override
  addToUniqeCarts({required Item item, required String count}) {
    if (myFinalUniqeCarts.containsKey(item.itemNum)) {
      myFinalUniqeCarts.update(
        item.itemNum,
        (value) {
          Item ing = Item(
            itemId: value.itemId,
            itemName: value.itemName,
            itemNum: value.itemNum,
            itemCount: (double.parse(value.itemCount) + double.parse(count))
                .toString(),
            itemPakage: value.itemPakage,
            itemPiec: value.itemPiec,
            itemPriceIn: value.itemPriceIn,
            itemPriceOut: value.itemPriceOut,
            itemQuant: '0.0',
            itemSubQuant: '0.0',
            itemQuantWight: '0.0',
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
    } else {
      myFinalUniqeCarts[item.itemNum] = Item(
        itemId: item.itemId,
        itemName: item.itemName,
        itemNum: item.itemNum,
        itemSup: item.itemSup,
        itemPriceIn: item.itemPriceIn,
        itemPriceOut: item.itemPriceOut,
        itemCount: count,
        billId: item.billId,
        stockId: item.stockId,
        itemQuant: '0.0',
        itemSubQuant: '0.0',
        itemQuantWight: '0.0',
        itemMin: item.itemMin,
        itemMax: item.itemMax,
        itemPakage: item.itemPakage,
        itemPiec: item.itemPiec,
        planId: item.planId,
        kind: item.kind,
        ingredientsNumber: item.ingredientsNumber,
        itemTime: item.itemTime,
        itemDone: item.itemDone,
        itemWight: item.itemWight,
        itemExchange: item.itemExchange,
        itemUsed: item.itemUsed,
      );
    }
  }

  @override
  addListToUniqeCart({required Map items}) {
    myFinalUniqeCarts.clear();
    for (int index = 0; index < items.length; index++) {
      addToUniqeCarts(
        item: items.keys.toList()[index],
        count: items.values.toList()[index].toString(),
      );
    }
  }

  @override
  prepareStockToUniqeCart({required Item item}) {
    if (myFinalUniqeCarts.containsKey(item.itemNum)) {
      myFinalUniqeCarts.update(
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
            itemQuant: double.parse(item.itemQuant).toString(),
            itemSubQuant: double.parse(item.itemSubQuant).toString(),
            itemQuantWight: double.parse(item.itemQuantWight).toString(),
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
  prepareStockListToUniqeCart({required List items}) {
    isLoading(true);
    for (int index = 0; index < items.length; index++) {
      prepareStockToUniqeCart(item: items[index]);
      isFound!.add(false);
    }
    finalCartsSumQuant();
    isLoading(false);
    prepared(true);
  }

  @override
  void removeFromCart({required Item item}) {
    if (myCarts.containsKey(item) && myCarts[item] == 1) {
      myCarts.removeWhere((key, value) => key == item);
    } else {
      myCarts[item] -= 1;
    }
  }

  @override
  void removeOneProduct(Item item, int index) {
    myCarts.removeWhere((key, value) => key == item);
    controllers!.removeAt(index);
    controllersDigits!.removeAt(index);
    isOverd!.removeAt(index);
  }

  @override
  void clearCart() {
    myCarts.clear();
    controllers!.clear();
    controllersDigits!.clear();
    isOverd!.clear();
    isFound!.clear();
    myFinalUniqeCarts.clear();
    prepared(false);
    finalCartsMainQuant.value = 0.0;
    finalCartsSubQuant.value = 0.0;
    finalCartsWanted.value = 0.0;
  }

  get supTotal => myCarts.entries
      .map((e) => double.parse(e.key.itemPriceIn) * e.value)
      .toList();

  get total => myCarts.isEmpty
      ? 0
      : myCarts.entries
          .map((e) => double.parse(e.key.itemPriceIn) * e.value)
          .toList()
          .reduce((value, element) => value + element)
          .toStringAsFixed(3);

  finalCartsSumQuant() {
    List items = myFinalUniqeCarts.values.toList();
    for (int index = 0; index < items.length; index++) {
      finalCartsMainQuant.value += double.parse(items[index].itemQuant);
      finalCartsSubQuant.value += double.parse(items[index].itemSubQuant);
      finalCartsWanted.value += double.parse(items[index].itemCount);
    }
  }
}
