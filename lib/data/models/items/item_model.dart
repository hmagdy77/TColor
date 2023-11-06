// To parse this JSON data, do
//
//     final itemModel = itemModelFromJson(jsonString);

import 'dart:convert';

ItemModel itemModelFromJson(String str) => ItemModel.fromJson(json.decode(str));

String itemModelToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel {
  String status;
  List<Item> data;

  ItemModel({
    required this.status,
    required this.data,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        status: json["status"],
        data: List<Item>.from(json["data"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Item {
  int itemId;
  String itemName;
  String itemNum;
  String itemSup;
  String itemPriceIn;
  String itemPriceOut;
  String itemCount;
  String billId;
  String stockId;
  String itemQuant;
  String itemQuantWight;
  String itemSubQuant;
  String itemMin;
  String itemMax;
  String itemPakage;
  String itemPiec;
  String planId;
  int kind;
  String ingredientsNumber;
  String itemWight;
  String itemExchange;
  String itemUsed;
  String itemDone;
  DateTime itemTime;

  Item({
    required this.itemId,
    required this.itemName,
    required this.itemNum,
    required this.itemSup,
    required this.itemPriceIn,
    required this.itemPriceOut,
    required this.itemCount,
    required this.billId,
    required this.stockId,
    required this.itemQuant,
    required this.itemQuantWight,
    required this.itemSubQuant,
    required this.itemMin,
    required this.itemMax,
    required this.itemPakage,
    required this.itemPiec,
    required this.planId,
    required this.kind,
    required this.ingredientsNumber,
    required this.itemWight,
    required this.itemExchange,
    required this.itemUsed,
    required this.itemDone,
    required this.itemTime,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemId: json["item_id"],
        itemName: json["item_name"],
        itemNum: json["item_num"],
        itemSup: json["item_sup"],
        itemPriceIn: json["item_price_in"],
        itemPriceOut: json["item_price_out"],
        itemCount: json["item_count"],
        billId: json["bill_id"],
        stockId: json["stock_id"],
        itemQuant: json["item_quant"],
        itemQuantWight: json["item_quant_wight"],
        itemSubQuant: json["item_sub_quant"],
        itemMin: json["item_min"],
        itemMax: json["item_max"],
        itemPakage: json["item_pakage"],
        itemPiec: json["item_piec"],
        planId: json["plan_id"],
        kind: json["kind"],
        ingredientsNumber: json["ingredients_number"],
        itemWight: json["item_wight"],
        itemExchange: json["item_exchange"],
        itemUsed: json["item_used"],
        itemDone: json["item_done"],
        itemTime: DateTime.parse(json["item_time"]),
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "item_name": itemName,
        "item_num": itemNum,
        "item_sup": itemSup,
        "item_price_in": itemPriceIn,
        "item_price_out": itemPriceOut,
        "item_count": itemCount,
        "bill_id": billId,
        "stock_id": stockId,
        "item_quant": itemQuant,
        "item_quant_wight": itemQuantWight,
        "item_sub_quant": itemSubQuant,
        "item_min": itemMin,
        "item_max": itemMax,
        "item_pakage": itemPakage,
        "item_piec": itemPiec,
        "plan_id": planId,
        "kind": kind,
        "ingredients_number": ingredientsNumber,
        "item_wight": itemWight,
        "item_exchange": itemExchange,
        "item_used": itemUsed,
        "item_done": itemDone,
        "item_time": itemTime.toIso8601String(),
      };
}
