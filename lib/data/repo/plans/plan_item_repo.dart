import '../../../libraries.dart';
import '../../models/items/item_model.dart';
import '../../models/status/status_model.dart';

class PlansItemRepo {
  static addplanItem({
    required Item item,
    required String itemCount,
    required String planId,
    required String itemQuant,
    required String itemSubQuant,
    required int kind,
  }) {
    return Crud.postRequest(
      url: Api.apiAddPlansItems,
      data: {
        'item_name': item.itemName,
        'item_num': item.itemNum,
        'item_sup': item.itemSup,
        'item_price_in': item.itemPriceIn.toString(),
        'item_price_out': item.itemPriceOut.toString(),
        'item_count': itemCount.toString(),
        'kind': kind.toString(),
        'plan_id': planId,
        'item_quant': itemQuant,
        'item_sub_quant': itemSubQuant,
      },
      function: statusModelFromJson,
    );
  }

  static getPlanItems({required String planId}) {
    return Crud.postRequest(
      url: Api.apiGetPlansItems,
      data: {
        'plan_id': planId,
      },
      function: itemModelFromJson,
    );
  }

  static deletePlanItem({
    required String id,
  }) {
    return Crud.postRequest(
      url: Api.apiDeletePlans,
      data: {'item_id': id},
      function: statusModelFromJson,
    );
  }

  static deleteAllPlanItem({
    required String planId,
  }) {
    return Crud.postRequest(
      url: Api.apiDeleteAllPlanItems,
      data: {'plan_id': planId},
      function: statusModelFromJson,
    );
  }

  static editplanItem({
    required String planId,
    required Item item,
    required String itemCount,
  }) {
    return Crud.postRequest(
      url: Api.apiEditPlansItems,
      data: {
        'item_id': item.itemId,
        'item_name': item.itemName,
        'item_num': item.itemNum,
        'item_sup': item.itemSup,
        'item_price_in': item.itemPriceIn.toString(),
        'item_price_out': 'itemPriceOut',
        'item_count': itemCount,
        'plan_id': planId,
      },
      function: statusModelFromJson,
    );
  }

  static updatePlanItems({
    required String itemNum,
    required String planId,
    required String exCahnge,
    required String used,
    required String done,
    required String itemQuantWight,
  }) {
    return Crud.postRequest(
      url: Api.apiUpdatePlanItems,
      data: {
        'item_num': itemNum,
        'plan_id': planId,
        'item_exchange': exCahnge,
        'item_used': used,
        'item_done': done,
        'item_quant_wight': itemQuantWight,
      },
      function: statusModelFromJson,
    );
  }

  static getAllItemsInDay({
    required String date,
  }) {
    return Crud.postRequest(
      url: Api.apiGetAllPlanItemsInDay,
      data: {
        'item_time': date,
      },
      function: itemModelFromJson,
    );
  }
}
