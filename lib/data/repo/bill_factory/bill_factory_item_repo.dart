import '../../../libraries.dart';
import '../../models/items/item_model.dart';
import '../../models/status/status_model.dart';

class BillsFactoryItemRepo {
  static getBillsFactoryItems({required String billId}) {
    return Crud.postRequest(
      url: Api.apiGetBillsFactoryItems,
      data: {
        'bill_id': billId,
      },
      function: itemModelFromJson,
    );
  }

  static addBillFactoryItem({
    required Item item,
    required String planId,
    required String kind,
    required String billId,
    required String time,
  }) {
    return Crud.postRequest(
      url: Api.addBillFactoryItem,
      data: {
        'item_name': item.itemName,
        'item_num': item.itemNum,
        'item_sup': item.itemSup,
        'stock_id': item.itemId.toString(),
        'item_price_in': item.itemPriceIn,
        'item_price_out': item.itemPriceOut,
        'item_count': item.itemCount,
        'item_quant_wight': item.itemQuantWight,
        'plan_id': planId,
        'kind': kind,
        'bill_id': billId,
        'item_time': time,
      },
      function: statusModelFromJson,
    );
  }

  static deleteBillFactoryItem({
    required String id,
  }) {
    return Crud.postRequest(
      url: Api.apiDeleteBillsfactoryitems,
      data: {'bill_id': id},
      function: statusModelFromJson,
    );
  }

  static getBillOutItemInRange({
    required String itemNum,
    required String starDate,
    required String endDate,
  }) {
    return Crud.postRequest(
      url: Api.apiGetBillsFactoryitemInRange,
      data: {
        'item_num': itemNum,
        'start_date': starDate,
        'end_date': endDate,
      },
      function: itemModelFromJson,
    );
  }

  static getBillOutAllItemsInRange({
    required String starDate,
    required String endDate,
  }) {
    return Crud.postRequest(
      url: Api.apiGetAllBillsFactoryitemsInRange,
      data: {
        'start_date': starDate,
        'end_date': endDate,
      },
      function: itemModelFromJson,
    );
  }

  static getAllItemsInDay({
    required String date,
  }) {
    return Crud.postRequest(
      url: Api.apiGetAllBillsFactoryitemsInDay,
      data: {
        'item_time': date,
      },
      function: itemModelFromJson,
    );
  }
}
