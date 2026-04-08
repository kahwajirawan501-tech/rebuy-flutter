import 'package:roasters/features/search/domain/entities/product_search_entity.dart';
import 'package:roasters/features/search/domain/repositories/search_product_repository.dart';

class RemoveFavoriteUseCase {
  final SearchProductRepository searchProductRepository;

  RemoveFavoriteUseCase(this.searchProductRepository);
  Future<String>call({required int idProduct}){
    return searchProductRepository.removeFavorite(idProduct: idProduct);
  }
}