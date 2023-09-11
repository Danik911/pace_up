// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubItemModel _$GithubItemModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'name'],
    disallowNullValues: const ['id', 'name'],
  );
  return GithubItemModel(
    json['id'] as String,
    json['name'] as String,
    json['description'] as String? ?? '',
    json['image'] as String? ?? '',
    json['size'] as String? ?? '',
  );
}

Map<String, dynamic> _$GithubItemModelToJson(GithubItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'size': instance.size,
    };
