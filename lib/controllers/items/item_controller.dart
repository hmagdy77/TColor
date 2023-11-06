import 'package:intl/intl.dart';

import '../../data/models/items/item_model.dart';
import '../../data/repo/items_repo.dart';
import '../../libraries.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class ItemController extends GetxController {
  addItem({
    required String sup,
    required int kind,
    required String cost,
    required String ingredientsNumber,
    required String itemWight,
  });
  editItem({required Item item, required String sup});
  editProudct({
    required Item item,
    required String priceIn,
  });
  prepareEditScreen({required Item item});
  clearTextFields();
  getItems();
  deleteItem({required String id});
  updateStock({required String itemNum, required String quantity});
  updateWightStock({required String itemNum, required String quantity});
  updateStockItemsGroup(
      {required List items, required List quantity, required int kind});
  updateSubStock({required String itemNum, required String subQuantity});
  updateSubStockItemsGroup(
      {required List items, required List subQuantity, required int kind});

  sortItems();
  String converter({required String quant});
  search({required String searchName, required int kind});
  void searchKind(String searchName);
  searchMinAndMax({required int kind, required bool isComponent});
  searchAvilableQuant({required int kind, required bool isComponets});
}

class ItemControllerImp extends ItemController {
  late TextEditingController name;
  late TextEditingController num;
  late TextEditingController priceIn;
  late TextEditingController priceOut;
  late TextEditingController searchTextField;
  late TextEditingController min;
  late TextEditingController max;
  late TextEditingController prints;
  GlobalKey<FormState> editItemKey = GlobalKey<FormState>();
  GlobalKey<FormState> addItemKey = GlobalKey<FormState>();
  var formatter = DateFormat('yyyy-MM-dd');
  var printNumber = 0.obs;
  var totalSubQuant = 0.0.obs;
  List<Widget> printList = [];
  var selectedPackage = ''.obs;
  var selectedKind = ''.obs;
  var selectedTime = ''.obs;
  var selectedBikeCondtion = ''.obs;
  var usedKind = 0.obs;
  bool isShown = true;
  var isLoading = false.obs;
  List<Item> itemsList = <Item>[].obs;
  List<Item> componetsItemsList = <Item>[].obs;
  List<Item> subStockItemsList = <Item>[].obs;
  List<Item> productsItemsList = <Item>[].obs;
  List<Item> searchItemsList = <Item>[].obs;
  List<Item> itemGrediantsList = <Item>[].obs;
  List<List<String>> printItems = [];
  MyService myService = Get.find();
  var converterQuantity = ''.obs;
  var colorsBool = <bool>[].obs;

  @override
  void onInit() {
    getItems();
    name = TextEditingController();
    num = TextEditingController();
    priceIn = TextEditingController();
    priceOut = TextEditingController();
    searchTextField = TextEditingController();
    // quant = TextEditingController();
    prints = TextEditingController();
    min = TextEditingController();
    max = TextEditingController();
    // priceInDigits = TextEditingController(text: '0');
    // priceOutDigits = TextEditingController(text: '0');
    // // numberOfpicesDigits = TextEditingController(text: '0');
    // // quantDigits = TextEditingController(text: '0');
    // minDigits = TextEditingController(text: '0');
    // maxDigits = TextEditingController(text: '0');
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    num.dispose();
    prints.dispose();
    priceIn.dispose();
    priceOut.dispose();
    searchTextField.dispose();
    // quant.dispose();
    min.dispose();
    max.dispose();
    // priceInDigits.dispose();
    // priceOutDigits.dispose();
    // numberOfpicesDigits.dispose();
    // // quantDigits.dispose();
    // minDigits.dispose();
    // maxDigits.dispose();
    super.dispose();
  }

  @override
  getItems() async {
    searchItemsList.clear();
    itemsList.clear();
    productsItemsList.clear();
    componetsItemsList.clear();
    subStockItemsList.clear();
    isLoading(true);
    var item = await ItemsRepo.getItems();
    try {
      if (item.status == 'fail') {
        isLoading(false);
        update();
      } else if (item.status == 'suc') {
        isLoading(false);

        itemsList.addAll(item.data);
        sortItems();
        update();
      }
    } catch (_) {}
  }

  @override
  addItem({
    String? sup,
    required int kind,
    required String cost,
    required String ingredientsNumber,
    required String itemWight,
  }) async {
    isLoading.value = true;
    try {
      var addItem = await ItemsRepo.addItem(
        name: name.text,
        num: num.text.trim().toString(),
        sup: sup ?? '',
        priceIn: kind == 1 ? priceIn.text.toString() : cost,
        priceOut: priceOut.text.toString(),
        min: min.text.toString(),
        max: max.text.toString(),
        kind: kind.toString(),
        pakage: AppStrings.kgm, //'كجم',//'selectedPackage.value',
        ingredientsNumber: ingredientsNumber,
        quant: '0', //quant.text.toString(),
        piec: '1',
        itemCount: '1',
        billId: '1',
        workId: '1',
        stockId: '1', itemWight: itemWight,
      );
      if (addItem.status == "suc") {
        await getItems();
        if (kind == 1) {
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [
              AppRoutes.addComponentItemScreen,
              () {},
            ],
          );
        } else {
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [
              AppRoutes.addProudctItemScreen,
              () {},
            ],
          );
        }
        clearTextFields();
        await getItems();
        update();
      } else if (addItem.status == "found") {
        MySnackBar.snack(AppStrings.fail, AppStrings.found);
        isLoading(false);
        update();
      } else if (addItem.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
    // }
  }

  @override
  editItem({required Item item, String? sup}) async {
    var formData = editItemKey.currentState;
    if (formData!.validate()) {
      isLoading.value = true;
      var editItem = await ItemsRepo.editItem(
        id: item.itemId.toString(),
        name: name.text,
        sup: sup ?? item.itemSup,
        priceIn: priceIn.text.toString(),
        priceOut: priceOut.text.toString(),
        min: min.text.toString(),
        max: max.text.toString(),
        kind: item.kind.toString(),
      );
      try {
        if (editItem.status == "suc") {
          clearTextFields();
          await getItems();
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [
              AppRoutes.componetsScreen,
              () {},
            ],
          );
          isLoading(false);
          update();
        } else if (editItem.status == "fail") {
          MySnackBar.snack(AppStrings.noitemsEdited, '');
          isLoading(false);
          update();
        }
      } catch (_) {
        isLoading(false);
        update();
      }
    }
  }

  @override
  editProudct({
    required Item item,
    required String priceIn,
  }) async {
    isLoading.value = true;
    var editItem = await ItemsRepo.editItem(
      id: item.itemId.toString(),
      name: name.text,
      sup: item.itemSup,
      priceIn: priceIn,
      priceOut: priceOut.text.toString(),
      min: min.text.toString(),
      max: max.text.toString(),
      kind: item.kind.toString(),
    );
    try {
      if (editItem.status == "suc") {
        clearTextFields();
        await getItems();
        if (item.kind == 1) {
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [
              AppRoutes.componetsScreen,
              () {},
            ],
          );
        } else {
          clearTextFields();
          await getItems();
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [
              AppRoutes.productsScreen,
              () {},
            ],
          );
        }
        isLoading(false);
        update();
      } else if (editItem.status == "fail") {
        MySnackBar.snack(AppStrings.noitemsEdited, '');
        if (item.kind == 1) {
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [
              AppRoutes.componetsScreen,
              () {},
            ],
          );
        } else {
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [
              AppRoutes.productsScreen,
              () {},
            ],
          );
        }
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  prepareEditScreen({required Item item}) {
    name.text = item.itemName;
    num.text = item.itemNum;
    priceIn.text = double.parse(item.itemPriceIn).toString();
    priceOut.text = double.parse(item.itemPriceOut).toString();
    max.text = double.parse(item.itemMax).toString();
    min.text = double.parse(item.itemMin).toString();
  }

  @override
  clearTextFields() {
    name.clear();
    num.clear();
    priceIn.clear();
    priceOut.clear();
    min.clear();
    max.clear();
    searchTextField.clear();
  }

  @override
  deleteItem({required String id}) async {
    isLoading(true);
    var item = await ItemsRepo.deleteItem(id: id);
    if (item.status == 'suc') {
      getItems();
      Get.offNamed(
        AppRoutes.loadingScreen,
        arguments: [
          AppRoutes.productsScreen,
          () {},
        ],
      );
      update();
    } else if (item.status == 'fail') {
      isLoading(false);
      update();
    }
  }

  @override
  updateStock({required String itemNum, required String quantity}) async {
    isLoading.value = true;
    var editIngredient =
        await ItemsRepo.updateStock(itemNum: itemNum, quantity: quantity);
    try {
      if (editIngredient.status == "suc") {
        isLoading(false);
        update();
      } else if (editIngredient.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  updateWightStock({required String itemNum, required String quantity}) async {
    isLoading.value = true;
    var editIngredient =
        await ItemsRepo.updateWightStock(itemNum: itemNum, quantity: quantity);
    try {
      if (editIngredient.status == "suc") {
        isLoading(false);
        update();
      } else if (editIngredient.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  updateStockItemsGroup(
      {required List items, required List quantity, required int kind}) {
    for (int i = 0; i < items.length; i++) {
      updateStock(
        itemNum: items[i].itemNum.toString(),
        quantity: kind == 2
            ? (-double.parse(quantity[i].toString())).toString()
            : (double.parse(quantity[i].toString())).toString(),
      );
    }
    getItems();
  }

  @override
  updateSubStock({required String itemNum, required String subQuantity}) async {
    isLoading.value = true;
    var editIngredient = await ItemsRepo.updateSubStock(
      itemNum: itemNum,
      subQuantity: subQuantity,
    );
    try {
      if (editIngredient.status == "suc") {
        isLoading(false);
        update();
      } else if (editIngredient.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  updateSubStockItemsGroup(
      {required List items, required List subQuantity, required int kind}) {
    for (int i = 0; i < items.length; i++) {
      updateSubStock(
        itemNum: items[i].itemNum.toString(),
        subQuantity: kind == 2
            ? (-double.parse(subQuantity[i].toString())).toString()
            : (double.parse(subQuantity[i].toString())).toString(),
      );
    }
    getItems();
  }

  updateSubStockItemsGroupForUniqList(
      {required List items, required int kind}) {
    for (int i = 0; i < items.length; i++) {
      updateSubStock(
        itemNum: items[i].itemNum.toString(),
        subQuantity: kind == 2
            ? (-double.parse(items[i].itemCount.toString())).toString()
            : (double.parse(items[i].itemCount.toString())).toString(),
      );
    }
    getItems();
  }

  updateStockItemsGroupForUniqList({required List items, required int kind}) {
    for (int i = 0; i < items.length; i++) {
      updateStock(
        itemNum: items[i].itemNum.toString(),
        quantity: kind == 2
            ? (-double.parse(items[i].itemQuantWight.toString())).toString()
            : (double.parse(items[i].itemQuantWight.toString())).toString(),
      );
    }
    getItems();
  }

  @override
  converter({required String quant}) {
    var quntity = double.parse(quant);
    if (quntity < 0.0) {
      return converterQuantity.value =
          '${quntity.toStringAsFixed(3)} ${AppStrings.shortage}';
    } else if (quntity == 0.0) {
      return converterQuantity.value = AppStrings.emptyQuantity;
    } else if (quntity < 1) {
      return converterQuantity.value =
          '${quntity.toStringAsFixed(3)} ${AppStrings.gm}';
    } else if (quntity <= 1000) {
      return converterQuantity.value =
          '${quntity.toStringAsFixed(3)} ${AppStrings.kgm}';
    } else {
      int finalQuantity = quntity ~/ 1000;
      var numberOfKgm = quntity - (finalQuantity * 1000);
      if (numberOfKgm == 0) {
        return converterQuantity.value = '$finalQuantity ${AppStrings.tn}';
      } else {
        return converterQuantity.value =
            '${finalQuantity.toStringAsFixed(2)} ${AppStrings.tn} + ${numberOfKgm.toStringAsFixed(2)} ${AppStrings.kgm}';
      }
    }
  }

  @override
  void search({required String searchName, required int kind}) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    switch (kind) {
      case 1:
        searchItemsList = componetsItemsList.where(
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
        searchItemsList = productsItemsList.where(
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
        searchItemsList = subStockItemsList.where(
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
      case 4:
        searchItemsList = itemsList.where(
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
  void sortItems() {
    componetsItemsList.clear();
    componetsItemsList = itemsList
        .where(
          (item) {
            var kind = item.kind;
            return kind == 1;
          },
        )
        .toList()
        .reversed
        .toList();
    productsItemsList.clear();
    productsItemsList = itemsList
        .where(
          (item) {
            var kind = item.kind;
            return kind == 2;
          },
        )
        .toList()
        .reversed
        .toList();
    subStockItemsList.clear();
    colorsBool.clear();
    totalSubQuant.value = 0.0;
    subStockItemsList = itemsList
        .where(
          (item) {
            // var kind = item.kind;
            var subQuant = double.parse(item.itemSubQuant);
            return subQuant != 0;
          },
        )
        .toList()
        .reversed
        .toList();
    for (int i = 0; i < subStockItemsList.length; i++) {
      colorsBool.add(false);
      totalSubQuant.value += double.parse(subStockItemsList[i].itemSubQuant);
    }
  }

  @override
  void searchKind(String searchName) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    searchItemsList = itemsList
        .where(
          (item) {
            var itemKind = item.kind.toString();
            return itemKind.contains(searchName);
          },
        )
        .toList()
        .reversed
        .toList();
    isLoading(false);
    update();
  }

  @override
  searchAvilableQuant({required int kind, required bool isComponets}) {
    isLoading(true);
    if (isComponets) {
      searchItemsList = componetsItemsList.where(
        (item) {
          var itemQuant = double.parse(item.itemQuant);
          switch (kind) {
            case 0:
              return itemQuant == 0;
            case 1:
              return itemQuant != 0;
            default:
              return itemQuant <= 0;
          }
        },
      ).toList();
    } else {
      searchItemsList = productsItemsList.where(
        (item) {
          var itemQuant = double.parse(item.itemQuant);
          switch (kind) {
            case 0:
              return itemQuant == 0;
            case 1:
              return itemQuant != 0;
            default:
              return itemQuant <= 0;
          }
        },
      ).toList();
    }

    isLoading(false);
    update();
  }

  @override
  searchMinAndMax({required int kind, required bool isComponent}) {
    isLoading(true);
    if (isComponent) {
      searchItemsList = componetsItemsList.where(
        (item) {
          var itemKind = item.kind;
          var itemQuant = double.parse(item.itemQuant);
          var itemmMin = double.parse(item.itemMin);
          var itemMax = double.parse(item.itemMax);
          switch (kind) {
            case 1:
              return itemKind == 1 && itemQuant <= itemmMin;
            case 2:
              return itemKind == 1 && itemQuant >= itemMax;
            default:
              return itemKind == 2 && itemQuant >= itemMax;
          }
        },
      ).toList();
    } else {
      searchItemsList = productsItemsList.where(
        (item) {
          var itemKind = item.kind;
          var itemQuant = double.parse(item.itemQuant);
          var itemmMin = double.parse(item.itemMin);
          var itemMax = double.parse(item.itemMax);
          switch (kind) {
            case 1:
              return itemKind == 2 && itemQuant <= itemmMin;
            case 2:
              return itemKind == 2 && itemQuant >= itemMax;
            default:
              return itemKind == 2 && itemQuant >= itemMax;
          }
        },
      ).toList();
    }
    isLoading(false);
    update();
  }
}
