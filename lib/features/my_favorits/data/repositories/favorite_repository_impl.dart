import 'package:roasters/features/my_favorits/data/datasources/favorite_remote_data_sources.dart';
import 'package:roasters/features/my_favorits/data/mappers/favorite_mapper.dart';
import 'package:roasters/features/my_favorits/domain/entities/favorite_entity.dart';
import 'package:roasters/features/my_favorits/domain/repositories/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSources favoriteRemoteDataSources;

  FavoriteRepositoryImpl(this.favoriteRemoteDataSources);
  @override
  Future<List<FavoriteEntity>> getFavoritesForUser()async {
    final model=await favoriteRemoteDataSources.getFavoritesForUser();
    return model.map((e)=>e.toEntity()).toList();
  }
  @override
  Future<String> addFavorite({required int idProduct})async {
    final message=await favoriteRemoteDataSources.addFavorite(idProduct: idProduct);
    return message;
  }

  @override
  Future<String> removeFavorite({required int idProduct})async {
    final message=await favoriteRemoteDataSources.removeFavorite(idProduct: idProduct);
    return message;
  }
}