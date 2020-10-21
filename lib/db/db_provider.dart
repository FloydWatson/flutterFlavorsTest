import 'dart:math';

import 'package:flavortest/db/001_init.dart';
import 'package:flavortest/db/002_init.dart';
import 'package:flavortest/db/migration.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class MigrationHandler {
  // Flavors type variable
  int _type = FlavorConfig.instance.variables["type"];

  // migration sql for tpe 1
  final List<Migration> migrations = [
    Migration001Init(),
  ];

  // migration sql for type 2
  final List<Migration> migrations2 = [
    Migration002Init(),
  ];

  int get length => migrations.length;

  // Apply migration in list order up to newVersion specified
  Future upgradeDatabase(Database db, int oldVersion, int newVersion) async {
    // dirty type switch
    if (_type == 1) {
      final stop = min(migrations.length, newVersion);
      for (int i = oldVersion; i < stop; i++) {
        await migrations[i].up(db);
      }
    } else if (_type == 2) {
      final stop = min(migrations2.length, newVersion);
      for (int i = oldVersion; i < stop; i++) {
        await migrations2[i].up(db);
      }
    }
  }
}

class DBProvider {
  final Database database;

  DBProvider(this.database);

  // Factory
  static Future<DBProvider> create() async {
    // Instantiate migration handler
    final migrations = MigrationHandler();

    // Find the database path
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, "flavortest.db");

    // Open database while applying appropriate migrations, if needed
    final db = await openDatabase(path,
        // use the number of migrations as the version number to apply all migrations
        version: migrations.length,
        onUpgrade: migrations.upgradeDatabase);

    return DBProvider(db);
  }
}
