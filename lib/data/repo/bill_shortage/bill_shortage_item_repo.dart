import '../../../libraries.dart';
import '../../models/items/item_model.dart';
import '../../models/status/status_model.dart';

class BillShortageItemRepo {
  static addBillShortageItem({
    required Item item,
    required String itemCount,
    required String billId,
    required String kind,
    required String time,
  }) {
    return Crud.postRequest(
      url: Api.apiAddBillShortageItems,
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

  static getBillShortageItems({required String billId}) {
    return Crud.postRequest(
      url: Api.apiGetBillShortageItems,
      data: {'bill_id': billId},
      function: itemModelFromJson,
    );
  }

  static deleteBillShortageItem({
    required String id,
  }) {
    return Crud.postRequest(
      url: Api.apiDeleteBillShortageItems,
      data: {'bill_id': id},
      function: statusModelFromJson,
    );
  }

  static editBillShortageItem({
    required String billId,
    required Item item,
    required String itemCount,
  }) {
    return Crud.postRequest(
      url: Api.apiEditBillShortageItems,
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

  static getBillShortageItemInRange({
    required String itemNum,
    required String starDate,
    required String endDate,
  }) {
    return Crud.postRequest(
      url: Api.apiGetBillShortageitemInRange,
      data: {
        'item_num': itemNum,
        'start_date': starDate,
        'end_date': endDate,
      },
      function: itemModelFromJson,
    );
  }

  static getBillShortageAllItemsInRange({
    required String starDate,
    required String endDate,
  }) {
    return Crud.postRequest(
      url: Api.apiGetAllBillShortageitemsInRange,
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
      url: Api.apiGetAllBillShortageitemsInDay,
      data: {
        'item_time': date,
      },
      function: itemModelFromJson,
    );
  }
}
