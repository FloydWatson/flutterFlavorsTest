import 'dart:async';

import 'package:flavortest/db/entity_data_source.dart';
import 'package:flavortest/model/entity.dart';
import 'package:get_it/get_it.dart';

class EntityRepository {
  static const String NAME = "Entity";

  final EntityDataSource _entityDataSource = GetIt.I();

  Future<List<Entity>> getEntities() async {
    return await _entityDataSource.getEntities();
  }
}
