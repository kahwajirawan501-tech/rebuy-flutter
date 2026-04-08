
import 'package:dio/dio.dart';
import 'package:roasters/core/network/dio_exception_extension.dart';
import 'package:roasters/features/auth/data/LocalDataSource/auth_local_data_source.dart';
import 'package:roasters/features/my_product/data/models/product_my_product_model.dart';

abstract class MyProductRemoteDataSources {
  Future<List<ProductMyProductModel>>getProductForUser(int id, int page,int limit);
  Future <String> removeProduct({required int idProduct});
  Future<bool>updateIsSold({required int productId,required bool isSold});
}
class MyProductRemoteDataSourcesImpl implements MyProductRemoteDataSources{
  final Dio dio;

  MyProductRemoteDataSourcesImpl(this.dio);
  @override
  Future<List<ProductMyProductModel>> getProductForUser(int id, int page,int limit)async {
    try {
      final response = await dio.get(
        "/product/user/$id/page/$page/limit/$limit",

      );
      final List data = response.data['data']['products'] as List;
      return data.map((e)=>ProductMyProductModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.friendlyMessage);
    }
  }

  @override
  Future<String> removeProduct({required int idProduct})async {
    try {
      final response = await dio.delete(
        "/product/$idProduct",
      );

      return response.data["message"];
    } on DioException catch (e) {
      throw Exception(e.friendlyMessage);
    }
  }
  @override
  Future<bool> updateIsSold({

    required int productId,
    required bool isSold,
  }) async {
    try {
      final response = await dio.patch(
        "/product/$productId/is_sold",
        data: { "isSold": isSold }, // إرسال القيمة في body
      );

      return response.data['success'] ?? false;
    } on DioException catch (e) {
      throw Exception(e.friendlyMessage);
    }
  }


}