// To parse this JSON data, do
//
//     final billModel = billModelFromJson(jsonString);

import 'dart:convert';

BillModel billModelFromJson(String str) => BillModel.fromJson(json.decode(str));

String billModelToJson(BillModel data) => json.encode(data.toJson());

class BillModel {
  String status;
  List<Bill> data;

  BillModel({
    required this.status,
    required this.data,
  });

  factory BillModel.fromJson(Map<String, dynamic> json) => BillModel(
        status: json["status"],
        data: List<Bill>.from(json["data"].map((x) => Bill.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Bill {
  int billId;
  String planId;
  String workName;
  int kind;
  String billSup;
  String billItems;
  String billTotal;
  double billPayment;
  String agentName;
  String agentPhone;
  String billNotes;
  DateTime billTimestamp;

  Bill({
    required this.billId,
    required this.planId,
    required this.workName,
    required this.kind,
    required this.billSup,
    required this.billItems,
    required this.billTotal,
    required this.billPayment,
    required this.agentName,
    required this.agentPhone,
    required this.billNotes,
    required this.billTimestamp,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        billId: json["bill_id"],
        planId: json["plan_id"],
        workName: json["work_name"],
        kind: json["kind"],
        billSup: json["bill_sup"],
        billItems: json["bill_items"],
        billTotal: json["bill_total"],
        billPayment: json["bill_payment"]?.toDouble(),
        agentName: json["agent_name"],
        agentPhone: json["agent_phone"],
        billNotes: json["bill_notes"],
        billTimestamp: DateTime.parse(json["bill_timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "bill_id": billId,
        "plan_id": planId,
        "work_name": workName,
        "kind": kind,
        "bill_sup": billSup,
        "bill_items": billItems,
        "bill_total": billTotal,
        "bill_payment": billPayment,
        "agent_name": agentName,
        "agent_phone": agentPhone,
        "bill_notes": billNotes,
        "bill_timestamp": billTimestamp.toIso8601String(),
      };
}
