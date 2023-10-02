import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

List<GithubItemModel> githubItemModelsFromJson(String str) =>
    List<GithubItemModel>.from(
        json.decode(str).map((x) => GithubItemModel.fromJson(x)));

String githubItemModelsToJson(List<GithubItemModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class GithubItemModel {
  String id;
  String name;
  String description;
  String image;
  String cost;

  GithubItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.cost,
  });


  factory GithubItemModel.fromJson(Map<String, dynamic> json) =>
      GithubItemModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        cost: json["cost"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "cost": cost,
      };
}






