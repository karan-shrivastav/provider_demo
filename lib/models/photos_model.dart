// To parse this JSON data, do
//
//     final photosModel = photosModelFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

List<PhotosModel> photosModelFromJson(String str) => List<PhotosModel>.from(json.decode(str).map((x) => PhotosModel.fromJson(x)));

String photosModelToJson(List<PhotosModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PhotosModel {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;
  File? image;
  bool? isImageMobile = true;

  PhotosModel({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
    this.image,
    this.isImageMobile = true,
  });

  PhotosModel copyWith({
    int? albumId,
    int? id,
    String? title,
    String? url,
    String? thumbnailUrl,
    File? image,
    bool? isImageMobile = true,
  }) =>
      PhotosModel(
        albumId: albumId ?? this.albumId,
        id: id ?? this.id,
        title: title ?? this.title,
        url: url ?? this.url,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
        image: image ?? this.image,
        isImageMobile: isImageMobile?? this.isImageMobile
      );

  factory PhotosModel.fromJson(Map<String, dynamic> json) => PhotosModel(
    albumId: json["albumId"],
    id: json["id"],
    title: json["title"],
    url: json["url"],
    thumbnailUrl: json["thumbnailUrl"],
    image: json["image"],
    isImageMobile: json["imageMobile"] = true
  );

  Map<String, dynamic> toJson() => {
    "albumId": albumId,
    "id": id,
    "title": title,
    "url": url,
    "thumbnailUrl": thumbnailUrl,
    "image" : image,
    "imageMobile" : isImageMobile = true
  };

  void setIsImageMobile(bool value) {
    isImageMobile = value;
  }
}
