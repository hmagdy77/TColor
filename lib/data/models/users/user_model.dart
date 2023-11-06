// To parse this JSON data, do
//
//     final usersModel = usersModelFromJson(jsonString);

import 'dart:convert';

UsersModel usersModelFromJson(String str) =>
    UsersModel.fromJson(json.decode(str));

String usersModelToJson(UsersModel data) => json.encode(data.toJson());

class UsersModel {
  String status;
  List<User> data;

  UsersModel({
    required this.status,
    required this.data,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        status: json["status"],
        data: List<User>.from(json["data"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class User {
  int userId;
  String name;
  String userName;
  String userPassword;
  int userKind;
  DateTime userTime;

  User({
    required this.userId,
    required this.name,
    required this.userName,
    required this.userPassword,
    required this.userKind,
    required this.userTime,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        name: json["name"],
        userName: json["user_name"],
        userPassword: json["user_password"],
        userKind: json["user_kind"],
        userTime: DateTime.parse(json["user_time"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "user_name": userName,
        "user_password": userPassword,
        "user_kind": userKind,
        "user_time": userTime.toIso8601String(),
      };
}
