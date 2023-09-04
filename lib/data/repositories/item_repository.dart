import 'package:pace_up/data/source/local/local_data_source.dart';
import 'package:pace_up/data/source/mappers/hive_item_model_to_entity.dart';
import 'package:pace_up/domain/entities/item.dart';

abstract class ItemRepository {
  Future<List<Item>> getAllItems();

  Future<List<Item>> getItems({required int limit, required int page});

  Future<Item?> getItem(String number);
}

class ItemDefaultRepository extends ItemRepository {
  ItemDefaultRepository({required this.localDataSource});

  //TODO(You can add API to fetch data) final GithubDataSource githubDataSource;
  final LocalDataSource localDataSource;

  @override
  Future<List<Item>> getAllItems() async {
/*    final hasCachedData = await localDataSource.hasData();

    if (!hasCachedData) {
      //TODO("here you can add models fetched from API and save them into DB")

    }

    final itemHiveModels = await localDataSource.getAllItems();

    final itemEntities = itemHiveModels.map((e) => e.toEntity()).toList();*/

    return localDataSource.listOfItemsForTesting;
  }

  @override
  Future<List<Item>> getItems({required int limit, required int page}) async {
    /*final hasCachedData = await localDataSource.hasData();

    if (!hasCachedData) {
      //TODO("here you can add models fetched from API and save them into DB")
    }

    final itemHiveModels = await localDataSource.getItemsByPage(
      page: page,
      limit: limit,
    );
    final itemEntities = itemHiveModels.map((e) => e.toEntity()).toList();*/

    return localDataSource.listOfItemsForTesting;
  }

  @override
  Future<Item?> getItem(String number) async {
    final itemModel = await localDataSource.getItem(number);
    if (itemModel == null) return null;
    final item = itemModel.toEntity();


    return item;
  }
}
