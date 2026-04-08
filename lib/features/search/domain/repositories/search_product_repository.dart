import 'package:roasters/features/search/domain/entities/product_search_entity.dart';

abstract class SearchProductRepository {
  Future<List<ProductSearchEntity>>
  getSearch(int typeId,int? provinceId, String? text, int page,int limit);
  Future <String> addFavorite({required int idProduct});
  Future <String> removeFavorite({required int idProduct});

}