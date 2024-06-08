// To parse this JSON data, do
//
//     final userAlbumModel = userAlbumModelFromJson(jsonString);

import 'dart:convert';

List<UserAlbumModel> userAlbumModelFromJson(String str) => List<UserAlbumModel>.from(json.decode(str).map((x) => UserAlbumModel.fromJson(x)));

String userAlbumModelToJson(List<UserAlbumModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserAlbumModel {
  int? userId;
  int? id;
  String? title;

  UserAlbumModel({
    this.userId,
    this.id,
    this.title,
  });

  UserAlbumModel copyWith({
    int? userId,
    int? id,
    String? title,
  }) =>
      UserAlbumModel(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
      );

  factory UserAlbumModel.fromJson(Map<String, dynamic> json) => UserAlbumModel(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
  };
}
