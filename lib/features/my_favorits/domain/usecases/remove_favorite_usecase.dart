import 'package:roasters/features/my_favorits/domain/repositories/favorite_repository.dart';

class RemoveProductFromFavoriteUseCase {
  final FavoriteRepository favoriteRepository;

  RemoveProductFromFavoriteUseCase(this.favoriteRepository);
  Future<String>call({required int idProduct})async{
    return await favoriteRepository.removeFavorite(idProduct: idProduct);
  }
}