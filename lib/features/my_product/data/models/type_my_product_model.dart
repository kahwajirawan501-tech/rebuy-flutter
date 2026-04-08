class TypeMyProductModel {
  final int id;
  final String name;

  TypeMyProductModel({
    required this.id,
    required this.name,
  });

  factory TypeMyProductModel.fromJson(Map<String, dynamic> json) {
    return TypeMyProductModel(
      id: json['id'],
      name: json['name'],
    );
  }
}