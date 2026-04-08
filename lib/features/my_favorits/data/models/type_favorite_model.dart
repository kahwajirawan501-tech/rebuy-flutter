class TypeFavoriteModel {
  final int id;
  final String name;

  TypeFavoriteModel({
    required this.id,
    required this.name,
  });

  factory TypeFavoriteModel.fromJson(Map<String, dynamic> json) {
    return TypeFavoriteModel(
      id: json['id'],
      name: json['name'],
    );
  }
}