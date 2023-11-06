import '../../data/models/sup/sup_model.dart';
import '../../data/repo/sup_repo.dart';
import '../../libraries.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class SupController extends GetxController {
  getSups();
  addSup();
  editSup(String id);
  deleteSub(String id);
  void search(String searchName);
  goToMainScreen();
}

class SupControllerImp extends SupController {
  late TextEditingController name;
  late TextEditingController tel;
  var selectedSup = ''.obs;
  var selectedSupFrist = ''.obs;
  var selectedSupSecond = ''.obs;
  var selectedSupThird = ''.obs;
  var selectedSupForth = ''.obs;
  bool isShown = true;
  var isLoading = false.obs;
  List<Sup> supList = <Sup>[].obs;
  List<String> supListNames = [];
  List<Sup> searchSupList = <Sup>[].obs;
  MyService myService = Get.find();
  GlobalKey<FormState> editSupKey = GlobalKey<FormState>();
  GlobalKey<FormState> addSupKey = GlobalKey<FormState>();

  @override
  void onInit() {
    name = TextEditingController();
    tel = TextEditingController();
    getSups();
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    tel.dispose();
    super.dispose();
  }

  @override
  getSups() async {
    supList.clear();
    isLoading(true);
    var sup = await SupRepo.getSup();
    try {
      if (sup.status == 'fail') {
        isLoading(false);
        update();
      } else if (sup.status == 'suc') {
        isLoading(false);
        supList.addAll(sup.data);
        genrateList();
        update();
      }
    } catch (_) {}
  }

  genrateList() {
    supListNames =
        List.generate(supList.length, (index) => supList[index].supName);
  }

  @override
  addSup() async {
    var formData = addSupKey.currentState;
    if (formData!.validate()) {
      isLoading.value = true;
      var addItem = await SupRepo.addSup(
        name: name.text,
        tel: tel.text,
      );
      try {
        if (addItem.status == "suc") {
          await getSups();
          isLoading(false);
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [
              AppRoutes.addSupScreen,
              () {},
            ],
          );
          update();
        } else if (addItem.status == "found") {
          MySnackBar.snack(AppStrings.found, ' ');
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
    }
  }

  @override
  editSup(String id) async {
    var formData = editSupKey.currentState;
    if (formData!.validate()) {
      isLoading.value = true;
      var editSup =
          await SupRepo.editSup(id: id, name: name.text, tel: tel.text);
      try {
        if (editSup.status == "suc") {
          await getSups();
          isLoading(false);
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [
              AppRoutes.searchSupScreen,
              () {},
            ],
          );
          update();
        } else if (editSup.status == "fail") {
          MySnackBar.snack(AppStrings.noitemsEdited, '');
          isLoading(false);
          update();
        }
      } catch (_) {
        //MySnackBar.snack('please try later', 'Some thing went wrong');
        isLoading(false);
        update();
      }
    }
  }

  @override
  void search(String searchName) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    searchSupList = supList.where(
      (sup) {
        var supName = sup.supName;
        var supId = sup.supId.toString();
        var supTel = sup.supTel.toString();
        return supName.contains(searchName) ||
            supId.contains(searchName) ||
            supTel.contains(searchName);
      },
    ).toList();
    isLoading(false);
    update();
  }

  @override
  deleteSub(String id) async {
    isLoading(true);
    var sup = await SupRepo.deleteSup(id: id);
    if (sup.status == 'suc') {
      isLoading(false);
      Get.offNamed(
        AppRoutes.loadingScreen,
        arguments: [
          AppRoutes.searchSupScreen,
          () {},
        ],
      );
      update();
    } else if (sup.status == 'fail') {
      isLoading(false);
      update();
    }
  }

  @override
  goToMainScreen() {
    Get.offAndToNamed(AppRoutes.mainScreen);
  }

  prepareSubForUse({required String sup}) {
    if (sup.contains(',')) {
      var splited = sup.split(' , ');
      if (splited.length == 2) {
        selectedSupFrist.value = splited[0];
        selectedSupSecond.value = splited[1];
      } else if (splited.length == 3) {
        selectedSupFrist.value = splited[0];
        selectedSupSecond.value = splited[1];
        selectedSupThird.value = splited[2];
      } else if (splited.length == 4) {
        selectedSupFrist.value = splited[0];
        selectedSupSecond.value = splited[1];
        selectedSupThird.value = splited[2];
        selectedSupForth.value = splited[3];
      }
    } else {
      selectedSupFrist.value = sup;
      selectedSupSecond.value = '';
    }
  }

  clearSubForUse({required String sup}) {
    selectedSup = ''.obs;
    selectedSupFrist = ''.obs;
    selectedSupSecond = ''.obs;
    selectedSupThird = ''.obs;
    selectedSupForth = ''.obs;
  }
}
