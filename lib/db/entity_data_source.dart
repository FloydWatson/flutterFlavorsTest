import 'package:flavortest/model/entity.dart';
import 'package:get_it/get_it.dart';

import 'db_provider.dart';

class EntityDataSource {
  final DBProvider dbProvider = GetIt.I();

  Future<void> storeEntity(Entity entity) async {
    final db = dbProvider.database;

    await db.transaction((txn) async {
      await txn.insert('entities', entity.toLocalDatabase());
    });
  }

  Future<void> updateEntity(Entity entity) async {
    final db = dbProvider.database;

    await db.transaction((txn) async {
      await txn.update('entities', entity.toLocalDatabase(),
          where: 'id = ?', whereArgs: [entity.id]);
    });
  }

  Future<Entity> getEntity(String umpireId) async {
    final db = dbProvider.database;

    if (umpireId == null) {
      return null;
    }
    var res = await db.query('entities', where: "id = ?", whereArgs: [umpireId]);

    Entity entity = res.isNotEmpty ? Entity.fromLocalDatabase(res.first) : null;
    return entity;
  }

  Future<List<Entity>> getEntities() async {
    final db = dbProvider.database;

    var res = await db.query('entities');
    List<Entity> entities = [];
    await Future.forEach(res, (entity) async {
      Entity newEntity = Entity.fromLocalDatabase(entity);
      entities.add(newEntity);
    });
    return entities;
  }

  Future<void> deleteAllEntitys() async {
    final db = dbProvider.database;

    await db.transaction((txn) async {
      await txn.delete('entities');
    });
  }
}
