// // To parse this JSON data, do
// //
// //     final IngredientModel = IngredientModelFromJson(jsonString);

// import 'dart:convert';

// IngredientModel ingredientsModelFromJson(String str) =>
//     IngredientModel.fromJson(json.decode(str));

// String ingredientModelToJson(IngredientModel data) =>
//     json.encode(data.toJson());

// class IngredientModel {
//   String status;
//   List<Ingredient> data;

//   IngredientModel({
//     required this.status,
//     required this.data,
//   });

//   factory IngredientModel.fromJson(Map<String, dynamic> json) =>
//       IngredientModel(
//         status: json["status"],
//         data: List<Ingredient>.from(
//             json["data"].map((x) => Ingredient.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class Ingredient {
//   int itemId;
//   String itemName;
//   String itemNum;
//   String itemSup;
//   String itemPriceIn;
//   String itemPriceOut;
//   String itemCount;
//   String billId;
//   String stockId;
//   String itemQuant;
//   String itemMin;
//   String itemMax;
//   String itemPakage;
//   String itemPiec;
//   String workId;
//   int kind;
//   String ingredientsNumber;
//   DateTime itemTime;

//   Ingredient({
//     required this.itemId,
//     required this.itemName,
//     required this.itemNum,
//     required this.itemSup,
//     required this.itemPriceIn,
//     required this.itemPriceOut,
//     required this.itemCount,
//     required this.billId,
//     required this.stockId,
//     required this.itemQuant,
//     required this.itemMin,
//     required this.itemMax,
//     required this.itemPakage,
//     required this.itemPiec,
//     required this.workId,
//     required this.kind,
//     required this.ingredientsNumber,
//     required this.itemTime,
//   });

//   factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
//         itemId: json["item_id"],
//         itemName: json["item_name"],
//         itemNum: json["item_num"],
//         itemSup: json["item_sup"],
//         itemPriceIn: json["item_price_in"],
//         itemPriceOut: json["item_price_out"],
//         itemCount: json["item_count"],
//         billId: json["bill_id"],
//         stockId: json["stock_id"],
//         itemQuant: json["item_quant"],
//         itemMin: json["item_min"],
//         itemMax: json["item_max"],
//         itemPakage: json["item_pakage"],
//         itemPiec: json["item_piec"],
//         workId: json["work_id"],
//         kind: json["kind"],
//         ingredientsNumber: json["ingredients_number"],
//         itemTime: DateTime.parse(json["item_time"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "item_id": itemId,
//         "item_name": itemName,
//         "item_num": itemNum,
//         "item_sup": itemSup,
//         "item_price_in": itemPriceIn,
//         "item_price_out": itemPriceOut,
//         "item_count": itemCount,
//         "bill_id": billId,
//         "stock_id": stockId,
//         "item_quant": itemQuant,
//         "item_min": itemMin,
//         "item_max": itemMax,
//         "item_pakage": itemPakage,
//         "item_piec": itemPiec,
//         "work_id": workId,
//         "kind": kind,
//         "ingredients_number": ingredientsNumber,
//         "item_time": itemTime.toIso8601String(),
//       };
// }

// // Ingredient