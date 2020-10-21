import 'package:sqflite/sqflite.dart';

abstract class Migration {
  Future up(Database db);
}
