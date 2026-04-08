class PriceSearchModel {
  final int id;
  final double price;
  final String type;

  PriceSearchModel({
    required this.id,
    required this.price,
    required this.type,
  });

  factory PriceSearchModel.fromJson(Map<String, dynamic> json) {
    return PriceSearchModel(
      id: json['id'],
      price:(json['price'] as num).toDouble(),
      type: json['type'],
    );
  }
}