import '../../../libraries.dart';
import '../../models/items/item_model.dart';
import '../../models/status/status_model.dart';

class BillsInItemRepo {
  static addBillInItem({
    required Item item,
    required String itemCount,
    required String billId,
    required String kind,
    required String time,
  }) {
    return Crud.postRequest(
      url: Api.apiAddBillsInItems,
      data: {
        'item_name': item.itemName,
        'item_num': item.itemNum,
        'item_sup': item.itemSup,
        'stock_id': item.itemId.toString(),
        'item_price_in': item.itemPriceIn.toString(),
        'item_price_out': 'itemPriceOut',
        'item_count': itemCount.toString(),
        'bill_id': billId,
        'kind': kind,
        'item_time': time,
      },
      function: statusModelFromJson,
    );
  }

  static getBillInItems({required String billId}) {
    return Crud.postRequest(
      url: Api.apiGetBillsInItems,
      data: {'bill_id': billId},
      function: itemModelFromJson,
    );
  }

  static deleteBillInItem({
    required String id,
  }) {
    return Crud.postRequest(
      url: Api.apiDeleteBillsInItems,
      data: {'bill_id': id},
      function: statusModelFromJson,
    );
  }

  static editBillInItem({
    required String billId,
    required Item item,
    required String itemCount,
  }) {
    return Crud.postRequest(
      url: Api.apiEditBillsInItems,
      data: {
        'item_id': item.itemId,
        'item_name': item.itemName,
        'item_num': item.itemNum,
        'item_sup': item.itemSup,
        'item_price_in': item.itemPriceIn.toString(),
        'item_price_out': 'itemPriceOut',
        'item_count': itemCount,
        'bill_id': billId,
      },
      function: statusModelFromJson,
    );
  }

  static getBillInItemInRange({
    required String itemNum,
    required String starDate,
    required String endDate,
  }) {
    return Crud.postRequest(
      url: Api.apiGetBillsInitemInRange,
      data: {
        'item_num': itemNum,
        'start_date': starDate,
        'end_date': endDate,
      },
      function: itemModelFromJson,
    );
  }

  static getBillInAllItemsInRange({
    required String starDate,
    required String endDate,
  }) {
    return Crud.postRequest(
      url: Api.apiGetAllBillsInitemsInRange,
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
      url: Api.apiGetAllBillsInitemsInDay,
      data: {
        'item_time': date,
      },
      function: itemModelFromJson,
    );
  }
}
