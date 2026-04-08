import 'package:roasters/features/search/domain/repositories/search_product_repository.dart';

class AddFavoriteUseCase {
  final SearchProductRepository searchProductRepository;

  AddFavoriteUseCase(this.searchProductRepository);
  Future<String>call({required int idProduct}){
    return searchProductRepository.addFavorite(idProduct: idProduct);
  }
}