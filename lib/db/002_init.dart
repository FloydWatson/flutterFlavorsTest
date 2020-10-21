import 'package:flavortest/db/migration.dart';
import 'package:sqflite_common/sqlite_api.dart';


class Migration002Init implements Migration {
  @override
  Future up(Database db) async {
    await db.execute('CREATE TABLE entities (id TEXT PRIMARY KEY, name TEXT)');
    await db.execute('CREATE TABLE second (id TEXT PRIMARY KEY, name TEXT)');

    //await db.insert('entities', )

    await db.execute('INSERT INTO entities (id, name) VALUES("0000001", "TYPE TWO NAME")');
  }
}
