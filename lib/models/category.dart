class Category {
  int? id;
  String name;
  String icon;

  Category({this.id, required this.name, required this.icon});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'icon': icon};
  }
}
