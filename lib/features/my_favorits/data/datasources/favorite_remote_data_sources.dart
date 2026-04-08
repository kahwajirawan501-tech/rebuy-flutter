import 'package:dio/dio.dart';
import 'package:roasters/core/network/dio_exception_extension.dart';
import 'package:roasters/features/my_favorits/data/models/favorite_model.dart';

abstract class FavoriteRemoteDataSources {
  Future<List<FavoriteModel>>getFavoritesForUser();
  Future <String> addFavorite({required int idProduct});
  Future <String> removeFavorite({required int idProduct});
}
class FavoriteRemoteDataSourcesImpl implements FavoriteRemoteDataSources{
  final Dio dio;

  FavoriteRemoteDataSourcesImpl(this.dio);
  @override
  Future<List<FavoriteModel>> getFavoritesForUser() async{
    try {
      final response = await dio.get(
        "/favorites",

      );
      final List data = response.data['data']['favorites'] as List;
      return data.map((e)=>FavoriteModel.fromJson(e)).toList();
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