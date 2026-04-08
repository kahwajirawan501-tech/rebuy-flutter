import 'package:roasters/features/my_favorits/domain/entities/favorite_entity.dart';

abstract class FavoriteRepository {
  Future<List<FavoriteEntity>>getFavoritesForUser();
  Future <String> addFavorite({required int idProduct});
  Future <String> removeFavorite({required int idProduct});
}