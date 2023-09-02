import '../../../domain/entities/item.dart';
import '../local/models/item.dart';

extension ItemHiveModelX on ItemHiveModel {
  Item toEntity({List<ItemHiveModel> evolutions = const []}) => Item(

    number: number.trim() ?? '',
    name: name.trim() ?? '',
    description: description.trim() ?? '',
    image: image.trim() ?? '',

  );
}

