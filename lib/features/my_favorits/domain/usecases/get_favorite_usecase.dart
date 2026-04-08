import 'package:roasters/features/my_favorits/domain/entities/favorite_entity.dart';
import 'package:roasters/features/my_favorits/domain/repositories/favorite_repository.dart';
import 'package:roasters/features/search/domain/repositories/search_product_repository.dart';

class GetFavoriteUseCase {
  final FavoriteRepository favoriteRepository;

  GetFavoriteUseCase(this.favoriteRepository);
  Future<List<FavoriteEntity>>call()async{
    return await favoriteRepository.getFavoritesForUser();
  }
}