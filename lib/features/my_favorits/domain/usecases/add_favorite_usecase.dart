
import 'package:roasters/features/my_favorits/domain/repositories/favorite_repository.dart';

class AddProductToFavoriteUseCase {
  final FavoriteRepository favoriteRepository;

  AddProductToFavoriteUseCase(this.favoriteRepository);
  Future<String>call({required int idProduct})async{
    return await favoriteRepository.addFavorite(idProduct: idProduct);
  }
}