import 'package:flavortest/db/entity_repo.dart';
import 'package:flavortest/injection.dart';
import 'package:flavortest/model/entity.dart';
import 'package:flavortest/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

Future boot() async {

  // == Initialise flutter
  WidgetsFlutterBinding.ensureInitialized();

  // == Initialise application
  // Setup service container
  await Injection.init();
}

class Sync {
  static Future<void> syncEntities(BuildContext context) async {
    final repo = GetIt.I<EntityRepository>();
    List<Entity> loadedEntities = await repo.getEntities();

    Provider.of<AppProvider>(context, listen: false)
        .setEntities(loadedEntities);
  }
}
