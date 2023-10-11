import 'package:pace_up/domain/entities/cart_item.dart';

import '../../../domain/entities/item.dart';
import '../local/models/item.dart';

extension ItemHiveModelX on ItemHiveModel {
  Item toEntity() => Item(

    id: id.trim() ?? '',
    name: name.trim() ?? '',
    description: description.trim() ?? '',
    image: image.trim() ?? '',
    cost: cost.trim() ?? '',
  );
}

extension CartHiveModelX on ItemHiveModel {
  CartItem toCartItem() => CartItem(

    id: id.trim() ?? '',
    item: toEntity(),
  );
}

