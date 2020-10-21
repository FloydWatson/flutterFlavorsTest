import 'package:flavortest/model/entity.dart';
import 'package:flutter/material.dart';
import 'dart:collection';

class AppProvider with ChangeNotifier {
  Map<String, Entity> _entities = HashMap();

  List<Entity> get entities {
    return _entities.values.toList(growable: false);
  }

  void setEntities(Iterable<Entity> entities) {
    _entities.clear();
    _entities.addEntries(entities.map((e) => MapEntry(e.id, e)));
    notifyListeners();
  }

  String firstName() {
    if (this.entities.length < 1) return "Empty";
    return this.entities[0]?.name ?? 'Empty';
  }
}
