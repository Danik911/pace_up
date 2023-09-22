


import 'package:pace_up/data/repositories/item_repository.dart';

import '../../core/base_use_case.dart';
import '../entities/item.dart';

class GetAllItemsUseCase extends NoParamsUseCase<List<Item>> {
  const GetAllItemsUseCase(this.repository);

  final ItemRepository repository;

  @override
  Future<List<Item>> call() {
    return repository.getAllItems();
  }
}

class GetItemsParams {
  const GetItemsParams({
    required this.page,
    required this.limit,
  });

  final int page;
  final int limit;
}

class GetItemsPerPageUseCase extends UseCase<List<Item>, GetItemsParams> {
  const GetItemsPerPageUseCase(this.repository);

  final ItemRepository repository;

  @override
  Future<List<Item>> call(GetItemsParams params) {
    return repository.getItems(page: params.page, limit: params.limit);
  }
}

class GetItemParam {
  final String id;

  const GetItemParam(this.id);
}

class GetItemUseCase extends UseCase<Item?, GetItemParam> {
  final ItemRepository repository;

  const GetItemUseCase(this.repository);

  @override
  Future<Item?> call(GetItemParam params) {
    return repository.getItem(params.id);
  }
}
