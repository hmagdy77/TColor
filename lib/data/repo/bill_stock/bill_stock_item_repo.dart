import '../../../libraries.dart';
import '../../models/items/item_model.dart';
import '../../models/status/status_model.dart';

class BillsStockItemRepo {
  static addBillStockItem({
    required Item item,
    required String itemCount,
    required String billId,
    required String kind,
    required String time,
  }) {
    return Crud.postRequest(
      url: Api.apiAddBillsstockitems,
      data: {
        'item_name': item.itemName,
        'item_num': item.itemNum,
        'item_sup': item.itemSup,
        'stock_id': item.itemId.toString(),
        'item_price_Stock': item.itemPriceIn.toString(),
        'item_price_out': 'itemPriceOut',
        'item_count': itemCount.toString(),
        'bill_id': billId,
        'kind': kind,
        'item_time': time,
      },
      function: statusModelFromJson,
    );
  }

  static getBillStockItems({required String billId}) {
    return Crud.postRequest(
      url: Api.apiGetBillsstockitems,
      data: {'bill_id': billId},
      function: itemModelFromJson,
    );
  }

  static deleteBillStockItem({
    required String id,
  }) {
    return Crud.postRequest(
      url: Api.apiDeleteBillsstockitems,
      data: {'bill_id': id},
      function: statusModelFromJson,
    );
  }

  static editBillStockItem({
    required String billId,
    required Item item,
    required String itemCount,
  }) {
    return Crud.postRequest(
      url: Api.apiEditBillsstockitems,
      data: {
        'item_id': item.itemId,
        'item_name': item.itemName,
        'item_num': item.itemNum,
        'item_sup': item.itemSup,
        'item_price_Stock': item.itemPriceIn.toString(),
        'item_price_out': 'itemPriceOut',
        'item_count': itemCount,
        'bill_id': billId,
      },
      function: statusModelFromJson,
    );
  }

  static getBillStockItemInRange({
    required String itemNum,
    required String starDate,
    required String endDate,
  }) {
    return Crud.postRequest(
      url: Api.apiGetBillstockitemInRange,
      data: {
        'item_num': itemNum,
        'start_date': starDate,
        'end_date': endDate,
      },
      function: itemModelFromJson,
    );
  }

  static getBillStockAllItemsInRange({
    required String starDate,
    required String endDate,
  }) {
    return Crud.postRequest(
      url: Api.apiGetAllBillstockitemsInRange,
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
      url: Api.apiGetAllBillstockitemsInDay,
      data: {
        'item_time': date,
      },
      function: itemModelFromJson,
    );
  }
}
