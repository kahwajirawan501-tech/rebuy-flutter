import 'package:roasters/features/my_favorits/data/models/product_favorite_model.dart';

class FavoriteModel {
  final int id;
  final int user_id;
  final int product_id;
  final ProductFavoriteModel product;

  FavoriteModel({required this.id,
    required this.user_id, required this.product_id, required this.product});
  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'],
      user_id: json['user_id'],
      product_id: json['product_id'],
      product:  ProductFavoriteModel.fromJson(json['product'])
    );
  }
}