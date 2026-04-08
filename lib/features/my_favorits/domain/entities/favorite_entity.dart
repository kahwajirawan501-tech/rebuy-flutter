import 'package:roasters/features/my_favorits/domain/entities/product_favorite_entity.dart';

class FavoriteEntity {
  final int id;
  final int user_id;
  final int product_id;
  final ProductFavoriteEntity product;

  FavoriteEntity({required this.id, required this.user_id,
    required this.product_id, required this.product});
  FavoriteEntity copyWith({
     int? id,
     int? user_id,
     int ?product_id,
     ProductFavoriteEntity? product,
}){
    return FavoriteEntity(id: id??this.id, user_id: user_id??this.user_id,
        product_id: product_id??this.product_id, product: product??this.product);
  }
}