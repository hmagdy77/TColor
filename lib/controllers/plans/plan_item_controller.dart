import '../../data/models/items/item_model.dart';
import '../../data/repo/plans/plan_item_repo.dart';
import '../../libraries.dart';

abstract class PlanItemController extends GetxController {
  addPlanItem({
    required String planId,
    required Item item,
    required double itemCount,
    required int kind,
  });
  updatePlanItem({
    required String itemNum,
    required String planId,
    required String exCahnge,
    required String used,
    required String done,
    required String itemQuantWight,
  });
  updateGroupPlanItemsExchange({
    required List items,
    required List exCahnge,
    required String planId,
  });
  getitemsbyPlanService({required String planId});
  getItemsbyplanId({required String planId});
  getItemsByIndex({required String planId});
  void sortItems();
  deletePlanItem({required String id});
  deleteAllPlanItems({required String planId});
  getAllItemsInDay({required String date});
}

class PlanItemControllerImp extends PlanItemController {
  List<Item> planItems = <Item>[].obs;
  var colorsBool = <bool>[].obs;

  List<Item> planItemsProuducts = <Item>[].obs;
  List<Item> planItemsComponents = <Item>[].obs;
  List<Item> planItemsWanted = <Item>[].obs;
  var planItemsInDay = <Item>[].obs;
  List<Item> plansSearchItemsList = <Item>[].obs;
  bool isShown = true;
  var isLoading = false.obs;

  @override
  addPlanItem({
    required String planId,
    required Item item,
    required double itemCount,
    required int kind,
  }) async {
    isLoading.value = true;
    var addPlan = await PlansItemRepo.addplanItem(
      item: item,
      itemCount: itemCount.toString(),
      planId: planId,
      kind: kind,
      itemQuant: item.itemQuant,
      itemSubQuant: item.itemSubQuant,
    );
    try {
      if (addPlan.status == "suc") {
        isLoading(false);
        update();
      } else if (addPlan.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      //MySnackBar.snack('please try later', 'Some thing went wrong');
      isLoading(false);
      update();
    }
  }

  @override
  deleteAllPlanItems({required String planId}) async {
    isLoading(true);
    var item = await PlansItemRepo.deleteAllPlanItem(planId: planId);
    if (item.status == 'suc') {
      isLoading(false);
      update();
    } else if (item.status == 'fail') {
      isLoading(false);
      update();
    }
  }

  @override
  deletePlanItem({required String id}) async {
    isLoading(true);
    var item = await PlansItemRepo.deletePlanItem(id: id);
    if (item.status == 'suc') {
      isLoading(false);
      update();
    } else if (item.status == 'fail') {
      isLoading(false);
      update();
    }
  }

  @override
  getitemsbyPlanService({required String planId}) async {
    var items = await PlansItemRepo.getPlanItems(planId: planId);
    return items.data;
  }

  @override
  getItemsbyplanId({required String planId}) async {
    var items = await getitemsbyPlanService(planId: planId);
    isLoading(true);
    planItems = items;
    isLoading(false);
    if (items.isEmpty) {
      isLoading(false);
      update();
    }
  }

  @override
  getItemsByIndex({required String planId}) async {
    isLoading(true);
    var items = await getItemsbyplanId(planId: planId);
    if (items != null) {
      planItems = items;
    }
    sortItems();
    isLoading(false);
  }

  @override
  void sortItems() {
    planItemsProuducts.clear();
    planItemsProuducts = planItems
        .where(
          (item) {
            var kind = item.kind;
            return kind == 2;
          },
        )
        .toList()
        .reversed
        .toList();
    planItemsWanted.clear();
    planItemsWanted = planItems
        .where(
          (item) {
            var kind = item.kind;
            return kind == 1;
          },
        )
        .toList()
        .reversed
        .toList();
    colorsBool.clear();
    for (int i = 0; i < planItemsWanted.length; i++) {
      colorsBool.add(false);
    }
  }

  @override
  updatePlanItem({
    required String itemNum,
    required String planId,
    required String exCahnge,
    required String used,
    required String done,
    required String itemQuantWight,
  }) async {
    try {
      var updateItem = await PlansItemRepo.updatePlanItems(
        itemNum: itemNum,
        planId: planId,
        exCahnge: exCahnge,
        used: used,
        done: done,
        itemQuantWight: itemQuantWight,
      );
      if (updateItem.status == "suc") {
        isLoading(false);
        update();
      } else if (updateItem.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      //MySnackBar.snack('please try later', 'Some thing went wrong');
      isLoading(false);
      update();
    }
  }

  @override
  updateGroupPlanItemsExchange({
    required List items,
    required String planId,
    required List exCahnge,
  }) {
    for (int index = 0; index < items.length; index++) {
      updatePlanItem(
        itemNum: items[index].itemNum,
        planId: planId,
        exCahnge: exCahnge[index].toString(),
        used: '0',
        done: '0',
        itemQuantWight: '0',
      );
    }
  }

  @override
  getAllItemsInDay({required String date}) async {
    isLoading(true);
    update();
    try {
      var items = await PlansItemRepo.getAllItemsInDay(date: date);
      if (items.status == 'suc') {
        planItemsInDay.addAll(items.data);
        isLoading(false);
        update();
      } else {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }
}

//  await Future.delayed(const Duration(seconds: 2));