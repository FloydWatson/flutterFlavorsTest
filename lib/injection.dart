import 'package:flavortest/db/db_provider.dart';
import 'package:flavortest/db/entity_data_source.dart';
import 'package:flavortest/db/entity_repo.dart';
import 'package:get_it/get_it.dart';

class Injection {
  static Future init() async {
    final services = GetIt.I;

    // Database
    services.registerSingleton<DBProvider>(await DBProvider.create());

    // Datasource
    services.registerFactory(() => EntityDataSource());

    // Repo
    services.registerFactory(() => EntityRepository());


  }
}
