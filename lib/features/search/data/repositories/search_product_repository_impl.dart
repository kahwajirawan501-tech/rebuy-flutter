import 'package:roasters/features/search/data/datasources/search_remote_data_sources.dart';
import 'package:roasters/features/search/data/mappers/product_search_mapper.dart';
import 'package:roasters/features/search/domain/entities/product_search_entity.dart';
import 'package:roasters/features/search/domain/repositories/search_product_repository.dart';

class SearchProductRepositoryImpl  implements  SearchProductRepository{
  final SearchRemoteDataSources searchRemoteDataSources;

  SearchProductRepositoryImpl(this.searchRemoteDataSources);

  @override
  Future<List<ProductSearchEntity>> getSearch(
      int typeId, int ?provinceId, String? text, int page, int limit) async{
    final models =await searchRemoteDataSources.getSearch(typeId, provinceId, text, page, limit);
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<String> addFavorite({required int idProduct})async {
    final message=await searchRemoteDataSources.addFavorite(idProduct: idProduct);
    return message;
  }

  @override
  Future<String> removeFavorite({required int idProduct})async {
    final message=await searchRemoteDataSources.removeFavorite(idProduct: idProduct);
    return message;
  }
}