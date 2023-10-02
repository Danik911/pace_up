import 'package:flutter/material.dart';
import 'package:pace_up/data/source/api/api_routes.dart';
import 'package:pace_up/data/source/api/models/item.dart';

import '../../../core/network_manager.dart';

class GithubDataSource {
  GithubDataSource(this.networkManager);

  final NetworkManager networkManager;

  Future<List<GithubItemModel>> getItems() async {
    final response = await networkManager.request(RequestMethod.get, ApiRoutes.baseUrl);

    final data =((response.data) as List)
        .map((item) => GithubItemModel.fromJson(item)).toList();
    return data;
  }
}


