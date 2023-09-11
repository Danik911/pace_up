


import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';


@JsonSerializable()
class GithubItemModel {
  GithubItemModel(
      this.id,
      this.name,
      this.description,
      this.image,
      this.size
      );

  factory GithubItemModel.fromJson(Map<String, dynamic> json) =>
      _$GithubItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$GithubItemModelToJson(this);

  @JsonKey(required: true, disallowNullValue: true)
  final String id;

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  @JsonKey(defaultValue: '')
  final String description;

  @JsonKey(defaultValue: '')
  final String image;

  @JsonKey(defaultValue: '')
  final String size;


}
