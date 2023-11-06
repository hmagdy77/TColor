import 'package:intl/intl.dart';

import '../../data/models/plans/plan_model.dart';
import '../../data/repo/plans/plans_repo.dart';
import '../../libraries.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class PlanController extends GetxController {
  addPlan();
  editPlan({required String id, required String done});
  savePlan({
    required String id,
    required String components,
    required String proudcts,
  });
  updatePlan({
    required String id,
    required String exghange,
    required String componentsDone,
    required String proudctsDone,
  });
  getPlans();
  search({required String searchName});
  deletePlan({required String id});
}

class PlanControllerImp extends PlanController {
  late TextEditingController planSearchController;
  late TextEditingController nameTextField;
  late TextEditingController descriptionTextField;
  List<List<String>> itemsCom = [];
  List<List<String>> itemsProd = [];
  bool isShown = true;
  var isLoading = false.obs;
  List<Plans> plansList = <Plans>[].obs;
  List<Plans> plansSearchList = <Plans>[].obs;
  List<Plans> plansListReversed = <Plans>[].obs;
  MyService myService = Get.find();
  var formatter = DateFormat('yyyy-MM-dd');
  @override
  void onInit() {
    planSearchController = TextEditingController();
    nameTextField = TextEditingController();
    descriptionTextField = TextEditingController();
    getPlans();
    super.onInit();
  }

  @override
  void dispose() {
    planSearchController.dispose();
    nameTextField.dispose();
    descriptionTextField.dispose();
    super.dispose();
  }

  @override
  addPlan() async {
    isLoading.value = true;
    var addPlan = await PlansRepo.addPlan();
    try {
      if (addPlan.status == "suc") {
        await getPlans();
        isLoading(false);
        update();
      } else if (addPlan.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  savePlan({
    required String id,
    required String components,
    required String proudcts,
  }) async {
    isLoading.value = true;
    try {
      var saveBillIn = await PlansRepo.savePlan(
        id: id,
        name: nameTextField.text,
        description: descriptionTextField.text,
        done: '0',
        date:
            '${formatter.format(DateTime.now())} ${DateTime.now().hour}:${DateTime.now().minute}:00',
        components: components,
        proudcts: proudcts,
      );
      if (saveBillIn.status == "suc") {
        await getPlans();
        Get.offNamed(
          AppRoutes.loadingScreen,
          arguments: [
            AppRoutes.addPlanScreen,
            () {},
          ],
        );
        isLoading(false);
        update();
      } else if (saveBillIn.status == "fail") {
        MySnackBar.snack(AppStrings.fail, '');
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  updatePlan({
    required String id,
    required String exghange,
    required String componentsDone,
    required String proudctsDone,
  }) async {
    isLoading.value = true;
    try {
      var updatePlan = await PlansRepo.updatePlan(
        id: id,
        exghange: exghange,
        componentsDone: componentsDone,
        proudctsDone: proudctsDone,
      );
      if (updatePlan.status == "suc") {
        await getPlans();
        isLoading(false);
        update();
      } else if (updatePlan.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  editPlan({
    required String id,
    required String done,
  }) async {
    try {
      isLoading.value = true;
      var editPlan = await PlansRepo.editPlan(
        id: id,
        done: done,
      );
      if (editPlan.status == "suc") {
        await getPlans();
        isLoading(false);
        update();
      } else if (editPlan.status == "fail") {
        MySnackBar.snack(AppStrings.noitemsEdited, '');
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  getPlans() async {
    plansList.clear();
    plansListReversed.clear();
    plansSearchList.clear();
    isLoading(true);
    var plan = await PlansRepo.getPlans();
    if (plan.status == 'fail') {
      isLoading(false);
      update();
    } else if (plan.status == 'suc') {
      isLoading(false);
      plansList.addAll(plan.data);
      plansListReversed = plansList.reversed.toList();
      update();
    }
    try {} catch (_) {}
  }

  @override
  void search({required String searchName}) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    plansSearchList = plansList.where(
      (plan) {
        var name = plan.name;
        var id = plan.id.toString();
        var desc = plan.des;
        var date = formatter.format(plan.date);
        return name.contains(searchName) ||
            id.contains(searchName) ||
            desc.contains(searchName) ||
            date.contains(searchName);
      },
    ).toList();
    isLoading(false);
    update();
  }

  @override
  deletePlan({required String id}) async {
    isLoading(true);
    var item = await PlansRepo.deletePlan(id: id);
    if (item.status == 'suc') {
      isLoading(false);
      await getPlans();
      plansSearchList.clear();
      Get.offNamed(
        AppRoutes.loadingScreen,
        arguments: [
          AppRoutes.searchPlansScreen,
          () {},
        ],
      );
      update();
    } else if (item.status == 'fail') {
      isLoading(false);
      update();
    }
  }
}
