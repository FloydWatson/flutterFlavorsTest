class Entity {
  String id;
  String name;

  Entity({this.id, this.name});

  factory Entity.fromJson(Map<String, dynamic> json, String tenantId) {
    return Entity(
      id: json['id'],
      name: json['name'],
    );
  }

  factory Entity.fromLocalDatabase(Map<String, dynamic> json) {
    return Entity(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toLocalDatabase() => {
        "id": id,
        "name": name,
      };

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
