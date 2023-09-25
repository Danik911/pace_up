import 'package:pace_up/data/source/local/sqflite/models/item_sq_model.dart';
import '../../../domain/entities/item.dart';
import '../local/hive/models/item.dart';

extension ItemHiveModelX on ItemHiveModel {
  Item toEntity() =>
      Item(
        id: id.trim() ?? '',
        name: name.trim() ?? '',
        description: description.trim() ?? '',
        image: image.trim() ?? '',
        size: size.trim() ?? '',
      );
}
  extension ItemSqModelX on ItemSqModel {
  Item toEntity() => Item(
    id: id.trim() ?? '',
    name: name.trim() ?? '',
    description: description.trim() ?? '',
    image: image.trim() ?? '',
    size: size.trim() ?? '',
  );
}

extension ItemToLocalHiveX on Item {
  ItemHiveModel toHiveModel() => ItemHiveModel()
    ..id = id.trim()
    ..name = name.trim()
    ..description = description.trim() ?? ""
    ..image = image.trim() ?? ""
    ..size = size.trim() ?? "";
}
extension ItemToLocalSqModleX on Item {
  ItemSqModel toLocalSqModel() => ItemSqModel(
    id: id.trim() ?? '',
    name: name.trim() ?? '',
    description: description.trim() ?? '',
    image: image.trim() ?? '',
    size: size.trim() ?? '',
  );

}
