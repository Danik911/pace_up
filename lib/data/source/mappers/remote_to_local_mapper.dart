import 'package:pace_up/data/source/api/models/item.dart';
import 'package:pace_up/data/source/local/models/item.dart';

extension RemoteItemModelToLocalX on GithubItemModel {
  ItemHiveModel toHiveModel() => ItemHiveModel()
    ..id = id.trim()
    ..name = name.trim()
    ..description = description.trim() ?? ""
    ..image = image.trim() ?? ""
    ..size = size.trim() ?? "";
}

