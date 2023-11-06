import '../../data/models/items/item_model.dart';
import '../../libraries.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class BillFactoryCartController extends GetxController {
  addToCarts({required Item item});
  removeFromCart(Item item);
  void updateCount(
      {required Item item, required int quantity, required int quantityDigit});
  void updateWight(
      {required Item item, required int quantity, required int quantityDigit});
  void removeOneProduct(Item item, int index);
  void clearCart();
}

class BillFactoryCartControllerImp extends BillFactoryCartController {
  Map myCarts = {}.obs;
  var isLoading = false.obs;
  List<List<String>> items = [];
  List<TextEditingController>? controllers = [];
  List<TextEditingController>? controllersDigits = [];
  List<TextEditingController>? controllersWight = [];
  List<TextEditingController>? controllersDigitsWight = [];
  List<bool>? isOverd = [];
  late TextEditingController numberOfPices;

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
  void updateCount(
      {required Item item, required int quantity, required int quantityDigit}) {
    myCarts.update(item.itemNum, (item) {
      return Item(
        itemId: item.itemId,
        itemName: item.itemName,
        itemNum: item.itemNum,
        itemSup: item.itemSup,
        itemPriceIn: item.itemPriceIn,
        itemPriceOut: item.itemPriceOut,
        itemCount: double.parse('$quantity.$quantityDigit').toStringAsFixed(3),
        billId: item.billId,
        stockId: item.stockId,
        itemQuant: item.itemQuant,
        itemQuantWight: item.itemQuantWight,
        itemSubQuant: item.itemSubQuant,
        itemMin: item.itemMin,
        itemMax: item.itemMax,
        itemPakage: item.itemPakage,
        itemPiec: item.itemPiec,
        planId: item.planId,
        kind: item.kind,
        ingredientsNumber: item.ingredientsNumber,
        itemWight: item.itemWight,
        itemExchange: item.itemExchange,
        itemUsed: item.itemUsed,
        itemDone: item.itemDone,
        itemTime: item.itemTime,
      );
    });
  }

  @override
  void updateWight(
      {required Item item, required int quantity, required int quantityDigit}) {
    myCarts.update(item.itemNum, (item) {
      return Item(
        itemId: item.itemId,
        itemName: item.itemName,
        itemNum: item.itemNum,
        itemSup: item.itemSup,
        itemPriceIn: item.itemPriceIn,
        itemPriceOut: item.itemPriceOut,
        itemCount: item.itemCount,
        billId: item.billId,
        stockId: item.stockId,
        itemQuant: item.itemQuant,
        itemQuantWight:
            double.parse('$quantity.$quantityDigit').toStringAsFixed(3),
        itemSubQuant: item.itemSubQuant,
        itemMin: item.itemMin,
        itemMax: item.itemMax,
        itemPakage: item.itemPakage,
        itemPiec: item.itemPiec,
        planId: item.planId,
        kind: item.kind,
        ingredientsNumber: item.ingredientsNumber,
        itemWight: item.itemWight,
        itemExchange: item.itemExchange,
        itemUsed: item.itemUsed,
        itemDone: item.itemDone,
        itemTime: item.itemTime,
      );
    });
  }

  @override
  addToCarts({required Item item}) {
    if (myCarts.containsKey(item.itemNum)) {
      MySnackBar.snack(AppStrings.found, '');
    } else {
      myCarts[item.itemNum] = Item(
        itemId: item.itemId,
        itemName: item.itemName,
        itemNum: item.itemNum,
        itemSup: item.itemSup,
        itemQuant: item.itemQuant,
        itemQuantWight: '0.0',
        itemCount: item.itemCount,
        itemSubQuant: item.itemSubQuant,
        itemPriceIn: item.itemPriceIn, // bill in
        itemPriceOut: item.itemPriceOut, //back bill in
        itemExchange: item.itemExchange, //exchange
        itemDone: item.itemDone, //   back exchange
        itemMin: item.itemMin, //     bill out
        itemMax: item.itemMax, //     back bill out
        billId: item.billId, //shortahe plaus
        stockId: item.stockId, //shortahe minus
        itemPakage: item.itemPakage,
        itemPiec: item.itemPiec,
        planId: item.planId,
        kind: item.kind,
        ingredientsNumber: item.ingredientsNumber,
        itemTime: item.itemTime,
        itemWight: item.itemWight,
        itemUsed: item.itemUsed,
      );
      controllers!.add(TextEditingController(text: '1'));
      controllersDigits!.add(TextEditingController(text: '0'));
      controllersWight!.add(TextEditingController(text: '0'));
      controllersDigitsWight!.add(TextEditingController(text: '0'));
      isOverd!.add(false);
    }
  }

  @override
  void removeFromCart(Item item) {
    if (myCarts.containsKey(item) && myCarts[item] == 1) {
      myCarts.removeWhere((key, value) => key == item);
    } else {
      myCarts[item] -= 1;
    }
  }

  @override
  void removeOneProduct(Item item, int index) {
    myCarts.removeWhere((key, value) => key == item.itemNum);
    controllers!.removeAt(index);
    controllersDigits!.removeAt(index);
    controllersWight!.removeAt(index);
    controllersDigitsWight!.removeAt(index);
    isOverd!.removeAt(index);
  }

  @override
  void clearCart() {
    myCarts.clear();
    for (int i = 0; i < controllers!.length; i++) {
      controllers![i].clear();
      controllersDigits![i].clear();
      controllersWight![i].clear();
      controllersDigitsWight![i].clear();
      isOverd![i] = false;
    }
  }

  get total => myCarts.isEmpty
      ? 0
      : myCarts.entries
          .map((e) => double.parse(e.key.itemPriceIn) * e.value)
          .toList()
          .reduce((value, element) => value + element)
          .toStringAsFixed(3);

  get getNumberOfPieces => myCarts.isEmpty
      ? 0
      : myCarts.entries
          .map((e) => double.parse(e.value.itemCount))
          .toList()
          .reduce((value, element) => value + element)
          .toStringAsFixed(3);

  get getTotalWight => myCarts.isEmpty
      ? 0
      : myCarts.entries
          .map((e) => double.parse(e.value.itemQuantWight))
          .toList()
          .reduce((value, element) => value + element)
          .toStringAsFixed(3);
}
