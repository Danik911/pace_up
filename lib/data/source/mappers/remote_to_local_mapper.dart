import 'package:pace_up/data/source/api/models/item.dart';
import 'package:pace_up/domain/entities/item.dart';

import '../local/hive/models/item.dart';
import '../local/sqflite/models/item_sq_model.dart';

extension RemoteItemModelToLocalHiveX on GithubItemModel {
  ItemHiveModel toHiveModel() => ItemHiveModel()
    ..id = id.trim()
    ..name = name.trim()
    ..description = description.trim() ?? ""
    ..image = image.trim() ?? ""
    ..size = size.trim() ?? "";
}

extension RemoteItemModelToLocalSqX on GithubItemModel {
  ItemSqModel toItemSqModel() => ItemSqModel(
        id: id.trim() ?? '',
        name: name.trim() ?? '',
        description: description.trim() ?? '',
        image: image.trim() ?? '',
        size: size.trim() ?? '',
      );
}

extension RemoteItemModelToLocalX on GithubItemModel {
  Item toItem() => Item(
        id: id.trim() ?? '',
        name: name.trim() ?? '',
        description: description.trim() ?? '',
        image: image.trim() ?? '',
        size: size.trim() ?? '',
      );
}
