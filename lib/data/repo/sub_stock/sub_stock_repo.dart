// import '../../../libraries.dart';
// import '../../models/items/item_model.dart';
// import '../../models/status/status_model.dart';

// class SubStockRepo {
//   static getItems() {
//     return Crud.postRequest(
//       url: Api.apiGetSubStockItems,
//       data: {},
//       function: itemModelFromJson,
//     );
//   }

//   static addItem({
//     required String name,
//     required String num,
//     required String sup,
//     required String priceIn,
//     required String priceOut,
//     required String quant,
//     required String pakage,
//     required String piec,
//     required String min,
//     required String max,
//     required String kind,
//     required String itemCount,
//     required String billId,
//     required String workId,
//     required String ingredientsNumber,
//     required String stockId,
//   }) {
//     return Crud.postRequest(
//       url: Api.apiAddSubStockItem,
//       data: {
//         'item_name': name,
//         'item_num': num,
//         'item_sup': sup,
//         'item_price_in': priceIn,
//         'item_price_out': priceOut,
//         'item_count': itemCount,
//         'bill_id': billId,
//         'item_quant': quant,
//         'item_min': min,
//         'item_max': max,
//         'item_pakage': pakage,
//         'item_piec': piec,
//         'ingredients_number': ingredientsNumber,
//         'kind': kind,
//       },
//       function: statusModelFromJson,
//     );
//   }

//   static editItem({
//     required String id,
//     required String name,
//     required String sup,
//     required String priceIn,
//     required String priceOut,
//     required String min,
//     required String max,
//   }) {
//     return Crud.postRequest(
//       url: Api.apiEditSubStockItem,
//       data: {
//         'item_id': id,
//         'item_name': name,
//         'item_sup': sup,
//         'item_price_in': priceIn,
//         'item_price_out': priceOut,
//         'item_min': min,
//         'item_max': max,
//       },
//       function: statusModelFromJson,
//     );
//   }

//   static deleteItem({
//     required String id,
//   }) {
//     return Crud.postRequest(
//       url: Api.apiDeleteSubStockItem,
//       data: {'item_id': id},
//       function: statusModelFromJson,
//     );
//   }

//   static updateStock({
//     required String itemNum,
//     required String quantity,
//   }) {
//     return Crud.postRequest(
//       url: Api.apiStockSubStockItem,
//       data: {
//         'item_num': itemNum,
//         'item_quant': quantity,
//       },
//       function: statusModelFromJson,
//     );
//   }
// }
