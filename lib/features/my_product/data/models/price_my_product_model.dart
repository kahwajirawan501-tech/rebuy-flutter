class PriceMyProductModel {
  final int id;
  final double price;
  final String type;

  PriceMyProductModel({
    required this.id,
    required this.price,
    required this.type,
  });

  factory PriceMyProductModel.fromJson(Map<String, dynamic> json) {
    return PriceMyProductModel(
      id: json['id'],
      price:(json['price'] as num).toDouble(),
      type: json['type'],
    );
  }
}