import '../../data/models/items/item_model.dart';
import '../../libraries.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class PlanCartController extends GetxController {
  void updateQuantity(
      {required Item item, required int quantity, required int quantityDigit});
  addToCarts({required Item item});
  // addToUniqeCarts({required Item ingredient});
  // addListToUniqeCart({required List<Item> ingredients});
  removeFromCart({required Item item});
  void removeOneProduct({required Item item, required int index});
  void clearCart();
  var pay14 = 0.obs;
}

class PlanCartControllerImp extends PlanCartController {
  Map myCarts = {}.obs;
  Map myUniqeCarts = {}.obs;
  var isLoading = false.obs;
  List<List<String>> items = [];
  List<TextEditingController>? controllers = [];
  List<TextEditingController>? controllersDigits = [];
  List<bool>? isOverd = [];
  late TextEditingController numberOfPices;
  MyService myService = Get.find();
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
  void updateQuantity(
      {required Item item, required int quantity, required int quantityDigit}) {
    myCarts.update(item, (value) => double.parse('$quantity.$quantityDigit'));
  }

  @override
  addToCarts({required Item item}) {
    if (myCarts.containsKey(item)) {
      MySnackBar.snack(AppStrings.alreadyIn, '');
      // myCarts[item] += 1;
    } else {
      myCarts[item] = 1.0;
      controllers!.add(TextEditingController(text: '1'));
      controllersDigits!.add(TextEditingController(text: '0'));
      isOverd!.add(false);
    }
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
  void removeOneProduct({required Item item, required int index}) {
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

  get getNumberOfPieces => myCarts.isEmpty
      ? 0
      : myCarts.entries
          .map((e) => double.parse(e.key.itemCount) * e.value)
          .toList()
          .reduce((value, element) => value + element)
          .toStringAsFixed(3);
}
