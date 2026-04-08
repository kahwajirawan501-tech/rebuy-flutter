class PriceFavoriteModel {
  final int id;
  final double price;
  final String type;

  PriceFavoriteModel({
    required this.id,
    required this.price,
    required this.type,
  });

  factory PriceFavoriteModel.fromJson(Map<String, dynamic> json) {
    return PriceFavoriteModel(
      id: json['id'],
      price:(json['price'] as num).toDouble(),
      type: json['type'],
    );
  }
}