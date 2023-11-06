import '../../data/models/items/item_model.dart';
import '../../data/repo/ingredient_repo.dart';
import '../../libraries.dart';

abstract class IngredientController extends GetxController {
  addIngredient({
    required Item item,
    required String ingredientsNumber,
  });
  addAllIngredient({required List myCarts, required String ingrediantNum});
  editIngredient({required String itemId, required String quant});
  editGroubIngredient({required List items, required List quants});
  getIngredients();
  deleteIngredient({required String id});
  sortIngredients({required String productId});
}

class IngredientControllerImp extends IngredientController {
  GlobalKey<FormState> editIngredientKey = GlobalKey<FormState>();
  GlobalKey<FormState> addIngredientKey = GlobalKey<FormState>();
  var printNumber = 0.obs;
  List<Widget> printList = [];
  Map myCarts = {}.obs;
  var selectedPackage = ''.obs;
  var selectedKind = ''.obs;
  var selectedTime = ''.obs;
  var selectedBikeCondtion = ''.obs;
  var usedKind = 0.obs;
  var wight = 0.0.obs;
  bool isShown = true;
  var isLoading = false.obs;
  List<Item> ingredientsList = <Item>[].obs;
  List<Item> productsIngredientsList = <Item>[].obs;
  List<Item> searchIngredientsList = <Item>[].obs;
  MyService myService = Get.find();
  var converterQuantity = ''.obs;
  @override
  void onInit() {
    getIngredients();
    super.onInit();
  }

  @override
  getIngredients() async {
    searchIngredientsList.clear();
    ingredientsList.clear();
    isLoading(true);
    var ingredient = await IngredientsRepo.getIngredients();
    try {
      if (ingredient.status == 'fail') {
        isLoading(false);
        update();
      } else if (ingredient.status == 'suc') {
        isLoading(false);

        ingredientsList.addAll(ingredient.data);
        update();
      }
    } catch (_) {}
  }

  @override
  addAllIngredient(
      {required List myCarts, required String ingrediantNum}) async {
    for (int index = 0; index < myCarts.length; index++) {
      await addIngredient(
        item: myCarts[index],
        ingredientsNumber: ingrediantNum,
      );
    }
  }

  @override
  editIngredient({required String itemId, required String quant}) async {
    isLoading.value = true;
    try {
      var editItem = await IngredientsRepo.editIngredient(
        id: itemId.toString(),
        quant: quant,
      );
      if (editItem.status == "suc") {
        await getIngredients();
        isLoading(false);
        update();
      } else if (editItem.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  editGroubIngredient({required List items, required List quants}) {
    for (int index = 0; index < items.length; index++) {
      editIngredient(
        itemId: items[index].itemId,
        quant: quants[index],
      );
    }
  }

  @override
  addIngredient({
    required Item item,
    required String ingredientsNumber,
  }) async {
    isLoading(true);
    try {
      var addIngredient = await IngredientsRepo.addIngredient(
        name: item.itemName,
        num: item.itemNum,
        sup: item.itemSup,
        priceIn: item.itemPriceIn.toString(),
        priceOut: item.itemPriceOut.toString(),
        quant: item.itemQuant, //quant.text.toString(),
        pakage: item.itemPakage,
        piec: item.itemPiec,
        stockId: item.itemId.toString(),
        ingredientsNumber: ingredientsNumber.toString(),
        kind: '1',
        itemCount: item.itemCount.toString(),
      );
      if (addIngredient.status == "suc") {
        isLoading(false);
        update();
      } else if (addIngredient.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  deleteIngredient({required String id}) async {
    isLoading(true);
    var ingredient = await IngredientsRepo.deleteIngredient(id: id);
    if (ingredient.status == 'suc') {
      isLoading(false);
      update();
    } else if (ingredient.status == 'fail') {
      isLoading(false);
      update();
    }
  }

  deleteAllProudctIngredient({required String proudcttId}) async {
    isLoading(true);
    var ingredient = await IngredientsRepo.deleteAllProudctIngredient(
        proudcttId: proudcttId);
    if (ingredient.status == 'suc') {
      update();
    } else if (ingredient.status == 'fail') {
      isLoading(false);
      update();
    }
  }

  @override
  sortIngredients({required String productId}) {
    productsIngredientsList.clear();
    productsIngredientsList = ingredientsList
        .where(
          (ingredient) {
            var id = ingredient.ingredientsNumber;
            return id == productId;
          },
        )
        .toList()
        .reversed
        .toList();
    wight.value = 0.0;
    for (int index = 0; index < productsIngredientsList.length; index++) {
      wight.value += double.parse(productsIngredientsList[index].itemQuant);
    }
  }
}
