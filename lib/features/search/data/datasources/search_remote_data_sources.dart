import 'package:dio/dio.dart';
import 'package:roasters/core/network/dio_exception_extension.dart';
import 'package:roasters/features/search/data/models/product_search_model.dart';

abstract class SearchRemoteDataSources {
  Future<List<ProductSearchModel>>getSearch(
      int typeId,int ?provinceId, String ?text, int page,int limit);
  Future <String> addFavorite({required int idProduct});
  Future <String> removeFavorite({required int idProduct});
}

class SearchRemoteDataSourcesImpl implements SearchRemoteDataSources{
  final Dio dio;

  SearchRemoteDataSourcesImpl(this.dio);
  @override
  Future<List<ProductSearchModel>> getSearch(
      int typeId,int ?provinceId, String? text, int page,int limit)async{
    try {
      final response = await dio.get(
        "/product/search",
        queryParameters: {
          'type_id': typeId,
          if (provinceId != null) 'province_id': provinceId,
          if (text != null && text.isNotEmpty) 'text': text,
          'page': page,
          'limit': limit,
        },
      );
      final List data = response.data['data']['products'] as List;
      return data.map((e)=>ProductSearchModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.friendlyMessage);
    }
  }

  @override
  Future<String> addFavorite({required int idProduct}) async{

    try {
      final response = await dio.post(
        "/favorites/$idProduct",

      );

      return response.data["message"];
    } on DioException catch (e) {
      throw Exception(e.friendlyMessage);
    }
  }

  @override
  Future<String> removeFavorite({required int idProduct})async {
    try {
      final response = await dio.delete(
        "/favorites/$idProduct",
      );

      return response.data["message"];
    } on DioException catch (e) {
      throw Exception(e.friendlyMessage);
    }
  }

}