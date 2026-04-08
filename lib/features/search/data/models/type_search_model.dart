class TypeSearchModel {
  final int id;
  final String name;

  TypeSearchModel({
    required this.id,
    required this.name,
  });

  factory TypeSearchModel.fromJson(Map<String, dynamic> json) {
    return TypeSearchModel(
      id: json['id'],
      name: json['name'],
    );
  }
}