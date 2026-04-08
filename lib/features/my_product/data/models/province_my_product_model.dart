class ProvinceMyProductModel {
  final int id;
  final String name;

  ProvinceMyProductModel({
    required this.id,
    required this.name,
  });

  factory ProvinceMyProductModel.fromJson(Map<String, dynamic> json) {
    return ProvinceMyProductModel(
      id: json['id'],
      name: json['name'],
    );
  }
}