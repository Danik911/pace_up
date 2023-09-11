import '../../../domain/entities/item.dart';
import '../local/models/item.dart';

extension ItemHiveModelX on ItemHiveModel {
  Item toEntity() => Item(

    id: id.trim() ?? '',
    name: name.trim() ?? '',
    description: description.trim() ?? '',
    image: image.trim() ?? '',
    size: size.trim() ?? '',
  );
}

