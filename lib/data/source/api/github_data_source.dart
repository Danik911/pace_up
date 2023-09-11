import 'dart:convert';

import 'package:pace_up/data/source/api/models/item.dart';
import '../../../core/network_manager.dart';

class GithubDataSource {
  GithubDataSource(this.networkManager);

  static const String itemsURL =
      'https://pace-up-api.onrender.com/items.json';

  final NetworkManager networkManager;

  Future<List<GithubItemModel>> getItems() async {
    final response = await networkManager.request(RequestMethod.get, itemsURL);

    final data = (json.decode(response.data) as List)
        .map((item) => GithubItemModel.fromJson(item))
        .toList();

    return data;
  }


}