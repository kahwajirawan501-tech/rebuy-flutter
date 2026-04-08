class ProvinceFavoriteModel {
  final int id;
  final String name;

  ProvinceFavoriteModel({
    required this.id,
    required this.name,
  });

  factory ProvinceFavoriteModel.fromJson(Map<String, dynamic> json) {
    return ProvinceFavoriteModel(
      id: json['id'],
      name: json['name'],
    );
  }
}