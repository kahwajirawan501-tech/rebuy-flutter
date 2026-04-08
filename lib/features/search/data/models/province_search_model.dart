class ProvinceSearchModel {
  final int id;
  final String name;

  ProvinceSearchModel({
    required this.id,
    required this.name,
  });

  factory ProvinceSearchModel.fromJson(Map<String, dynamic> json) {
    return ProvinceSearchModel(
      id: json['id'],
      name: json['name'],
    );
  }
}