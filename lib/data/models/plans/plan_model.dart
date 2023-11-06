// To parse this JSON data, do
//
//     final plansModel = plansModelFromJson(jsonString);

import 'dart:convert';

PlansModel plansModelFromJson(String str) =>
    PlansModel.fromJson(json.decode(str));

String plansModelToJson(PlansModel data) => json.encode(data.toJson());

class PlansModel {
  String status;
  List<Plans> data;

  PlansModel({
    required this.status,
    required this.data,
  });

  factory PlansModel.fromJson(Map<String, dynamic> json) => PlansModel(
        status: json["status"],
        data: List<Plans>.from(json["data"].map((x) => Plans.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Plans {
  int id;
  String name;
  String workName;
  String des;
  String done;
  String components;
  String proudcts;
  String exghange;
  String componentsDone;
  String proudctsDone;
  DateTime date;

  Plans({
    required this.id,
    required this.name,
    required this.workName,
    required this.des,
    required this.done,
    required this.components,
    required this.proudcts,
    required this.exghange,
    required this.componentsDone,
    required this.proudctsDone,
    required this.date,
  });

  factory Plans.fromJson(Map<String, dynamic> json) => Plans(
        id: json["id"],
        name: json["name"],
        workName: json["work_name"],
        des: json["des"],
        done: json["done"],
        components: json["components"],
        proudcts: json["proudcts"],
        exghange: json["exghange"],
        componentsDone: json["components_done"],
        proudctsDone: json["proudcts_done"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "work_name": workName,
        "des": des,
        "done": done,
        "components": components,
        "proudcts": proudcts,
        "exghange": exghange,
        "components_done": componentsDone,
        "proudcts_done": proudctsDone,
        "date": date.toIso8601String(),
      };
}
