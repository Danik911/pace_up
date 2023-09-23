import 'package:flutter/cupertino.dart';
import 'package:pace_up/data/source/api/github_data_source.dart';
import 'package:pace_up/data/source/local/hive/local_data_source_impl_hive.dart';
import 'package:pace_up/data/source/mappers/db_model_to_entity.dart';
import 'package:pace_up/data/source/mappers/remote_to_local_mapper.dart';
import 'package:pace_up/domain/entities/item.dart';

import '../source/local/local_data_source.dart';

abstract class ItemRepository {
  Future<List<Item>> getAllItems();

  Future<List<Item>> getItemsByPage({required int limit, required int page});

  Future<Item?> getItem(String id);
}

class ItemDefaultRepository extends ItemRepository {
  ItemDefaultRepository(
      {required this.localDataSource, required this.remoteDataSource});

  final LocalDataSource localDataSource;
  final GithubDataSource remoteDataSource;

  @override
  Future<List<Item>> getAllItems() async {
    final hasCachedData = await localDataSource.hasData();

    if (!hasCachedData) {
      final itemGithubModels = await remoteDataSource.getItems();
      final items = itemGithubModels.map((e) => e.toItem());

      await localDataSource.saveItems(items);
    }

    final items = await localDataSource.getAllItems();

    //final itemEntities = itemHiveModels.map((e) => e.toEntity()).toList();


    return items;
  }

  @override
  Future<List<Item>> getItemsByPage({required int limit, required int page}) async {
    final hasCachedData = await localDataSource.hasData();

    if (!hasCachedData) {
      final itemGithubModels = await remoteDataSource.getItems();
      final items = itemGithubModels.map((e) => e.toItem());


      await localDataSource.saveItems(items);
    }

    final items = await localDataSource.getItemsByPage(
      page: page,
      limit: limit,
    );
    //final itemEntities = itemHiveModels.map((e) => e.toEntity()).toList();


    return items;
  }

  @override
  Future<Item?> getItem(String id) async {
    final itemModel = await localDataSource.getItem(id);
    if (itemModel == null) return null;
    //final item = itemModel.toEntity();

    return itemModel;
  }
}
