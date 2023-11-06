import '../../data/models/items/item_model.dart';
import '../../libraries.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class IngredientCartController extends GetxController {
  addToCartsz({required Item ingredient, required int index});
  addAllToCarts(List<Item> ingredients);
  void clearCart();
  void updateQuantity({required Item ingredient, required double quantity});
  updateQuantityForAllCarts({
    required List<Item> ingredients,
    required int quantity,
    required int digitQuantity,
  });
  void removeOneProduct({required Item ingredient});
  removeGroupProduct({required List<Item> ingredients});
  addProudctsIngredint({required Item ingredents});
  addAllProudctsIngredint({required List ingredents});
  // updateProudctsIngredint({required List ingredents});
}

class IngredientCartControllerImp extends IngredientCartController {
  Map myCarts = {}.obs;
  Map myIngredentsCarts = {}.obs;
  var isLoading = false.obs;
  List<List<String>> ingredients = [];
  List<TextEditingController>? controllers = [];
  List<TextEditingController>? controllersDigits = [];
  List<bool>? isOverd = [];
  late TextEditingController numberOfPices;

  @override
  void onInit() {
    numberOfPices = TextEditingController();
    myCarts.clear();
    super.onInit();
  }

  @override
  void dispose() {
    numberOfPices.dispose();
    super.dispose();
  }

  @override
  void updateQuantity({required Item ingredient, required double quantity}) {
    if (myCarts.isNotEmpty) {
      myCarts.update(ingredient, (value) => value = quantity);
    }
  }

  @override
  updateQuantityForAllCarts({
    required List<Item> ingredients,
    required int quantity,
    required int digitQuantity,
  }) {
    double q = double.parse('$quantity.$digitQuantity');
    isLoading(true);
    for (int index = 0; index < ingredients.length; index++) {
      updateQuantity(
        ingredient: ingredients[index],
        quantity: (q * double.parse(ingredients[index].itemCount)),
      );
    }
    isLoading(false);
  }

  @override
  addToCartsz({required Item ingredient, required int index}) {
    if (myCarts.containsKey(ingredient)) {
      // myCarts[ingredient] += ingredient.itemQuant;
    } else {
      myCarts[ingredient] = ingredient.itemCount;
    }
  }

  @override
  addAllToCarts(List<Item> ingredients) {
    isLoading(true);
    for (int index = 0; index < ingredients.length; index++) {
      addToCartsz(
        ingredient: ingredients[index],
        index: index,
      );
    }
    isLoading(false);
  }

  @override
  void removeOneProduct({required Item ingredient}) {
    myCarts.removeWhere((key, value) => key == ingredient);
  }

  @override
  removeGroupProduct({required List<Item> ingredients}) {
    isLoading(true);
    for (int index = 0; index < ingredients.length; index++) {
      removeOneProduct(
        ingredient: ingredients[index],
      );
    }
    isLoading(false);
  }

  @override
  void clearCart() {
    myCarts.clear();
    myIngredentsCarts.clear();
    controllers!.clear();
    controllersDigits!.clear();
    isOverd!.clear();
  }

  get supTotal =>
      myCarts.entries.map((e) => e.key.IngredientPriceOut * e.value).toList();

  get total => myCarts.isEmpty
      ? 0
      : myCarts.entries
          .map((e) => e.key.IngredientPriceOut * e.value)
          .toList()
          .reduce((value, element) => value + element)
          .toStringAsFixed(2);

  @override
  addProudctsIngredint({required Item ingredents}) {
    if (myIngredentsCarts.containsKey(ingredents.itemNum)) {
      MySnackBar.snack(AppStrings.found, '');
    } else {
      myIngredentsCarts[ingredents.itemNum] = Item(
        itemId: ingredents.itemId,
        itemName: ingredents.itemName,
        itemNum: ingredents.itemNum,
        itemSup: ingredents.itemSup,
        itemQuant: ingredents.itemQuant,
        itemQuantWight: ingredents.itemQuantWight,
        itemSubQuant: ingredents.itemSubQuant,
        itemPriceIn: ingredents.itemPriceIn, // bill in
        itemPriceOut: ingredents.itemPriceOut, //back bill in
        itemExchange: ingredents.itemExchange, //exchange
        itemDone: ingredents.itemDone, //   back exchange
        itemMin: ingredents.itemMin, //     bill out
        itemMax: ingredents.itemMax, //     back bill out
        billId: ingredents.billId, //shortahe plaus
        stockId: ingredents.stockId, //shortahe minus
        itemPakage: ingredents.itemPakage,
        itemPiec: ingredents.itemPiec,
        planId: ingredents.planId,
        kind: ingredents.kind,
        ingredientsNumber: ingredents.ingredientsNumber,
        itemTime: ingredents.itemTime,
        itemCount: ingredents.itemCount,
        itemWight: ingredents.itemWight,
        itemUsed: ingredents.itemUsed,
      );
      controllers!.add(TextEditingController());
      controllersDigits!.add(TextEditingController());
    }
  }

  @override
  addAllProudctsIngredint({required List ingredents}) {
    myIngredentsCarts.clear();
    for (int index = 0; index < ingredents.length; index++) {
      addProudctsIngredint(
        ingredents: ingredents[index],
      );
    }
  }

  void updateProudctsIngredintQuantity(
      {required Item item, required int quantity, required int quantityDigit}) {
    if (myIngredentsCarts.containsKey(item.itemNum)) {
      myIngredentsCarts.update(
        item.itemNum,
        (value) {
          Item ing = Item(
            itemId: value.itemId,
            itemName: value.itemName,
            itemNum: value.itemNum,
            itemCount: '$quantity.$quantityDigit',
            itemPakage: value.itemPakage,
            itemPiec: value.itemPiec,
            itemMin: value.itemMin,
            itemMax: value.itemMax,
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

  void removeFromIngredentsCarts({
    required Item ingredient,
    required int index,
  }) {
    myIngredentsCarts.removeWhere((key, value) => key == ingredient.itemNum);
    controllers!.removeAt(index);
    controllersDigits!.removeAt(index);
  }

  get proudctsIngredintTotalPrice => myIngredentsCarts.isEmpty
      ? 0
      : myIngredentsCarts.entries
          .map((e) => (double.parse(e.value.itemPriceIn) *
              double.parse(e.value.itemCount)))
          .toList()
          .reduce((value, element) => value + element)
          .toStringAsFixed(2);

  get proudctsIngredintWight => myIngredentsCarts.isEmpty
      ? 0
      : myIngredentsCarts.entries
          .map((e) => double.parse(e.value.itemCount))
          .toList()
          .reduce((value, element) => value + element)
          .toStringAsFixed(3);
}
