import '../../../libraries.dart';
import '../../models/items/item_model.dart';
import '../../models/status/status_model.dart';

class BillsOutItemRepo {
  static addBillOutItem({
    required Item item,
    required String itemCount,
    required String billId,
    required String kind,
    required String time,
  }) {
    return Crud.postRequest(
      url: Api.apiAddBillsOutItems,
      data: {
        'item_name': item.itemName,
        'item_num': item.itemNum,
        'item_sup': item.itemSup,
        'stock_id': item.itemId.toString(),
        'item_price_in': item.itemPriceIn.toString(),
        'item_price_out': item.itemPriceOut.toString(),
        'item_count': itemCount.toString(),
        'bill_id': billId,
        'kind': kind,
        'item_time': time,
      },
      function: statusModelFromJson,
    );
  }

  static getBillOutItems({required String billId}) {
    return Crud.postRequest(
      url: Api.apiGetBillsOutItems,
      data: {'bill_id': billId},
      function: itemModelFromJson,
    );
  }

  static deleteBillOutItem({
    required String id,
  }) {
    return Crud.postRequest(
      url: Api.apiDeleteBillsOutItems,
      data: {'bill_id': id},
      function: statusModelFromJson,
    );
  }

  static editBillOutItem({
    required String billId,
    required Item item,
    required String itemCount,
  }) {
    return Crud.postRequest(
      url: Api.apiEditBillsOutItems,
      data: {
        'item_id': item.itemId,
        'item_name': item.itemName,
        'item_num': item.itemNum,
        'item_sup': item.itemSup,
        'item_price_in': item.itemPriceIn,
        'item_price_out': item.itemPriceOut,
        'item_count': itemCount,
        'bill_id': billId,
      },
      function: statusModelFromJson,
    );
  }

  static getBillOutItemInRange({
    required String itemNum,
    required String starDate,
    required String endDate,
  }) {
    return Crud.postRequest(
      url: Api.apiGetBillsOutitemInRange,
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
      url: Api.apiGetAllBillsOutitemsInRange,
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
      url: Api.apiGetAllBillsOutitemsInDay,
      data: {
        'item_time': date,
      },
      function: itemModelFromJson,
    );
  }
}
