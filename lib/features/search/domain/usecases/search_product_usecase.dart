import 'package:roasters/features/search/domain/entities/product_search_entity.dart';
import 'package:roasters/features/search/domain/repositories/search_product_repository.dart';

class SearchProductUseCase {
  final SearchProductRepository searchProductRepository;

  SearchProductUseCase(this.searchProductRepository);
  Future<List<ProductSearchEntity>>call(int typeId,int ?provinceId, String? text, int page,int limit){
    return searchProductRepository.getSearch(typeId, provinceId, text, page, limit);
  }
}