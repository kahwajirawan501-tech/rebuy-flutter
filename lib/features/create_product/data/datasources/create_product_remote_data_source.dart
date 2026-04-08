import 'dart:io';

import 'package:dio/dio.dart';
import 'package:roasters/core/network/dio_exception_extension.dart';
import 'package:roasters/features/create_product/data/models/create_product_request.dart';
import 'package:roasters/features/create_product/data/models/image_upload_model.dart';
import 'package:roasters/features/create_product/data/models/update_product_request_model.dart';
import 'package:roasters/features/my_product/data/models/product_my_product_model.dart';

abstract class CreateProductRemoteDataSource {
  Future <String> createProduct({required CreateProductRequestModel product});
  Future<ProductMyProductModel> updateProduct({
    required int id,
    required UpdateProductRequestModel product,
  });
  Future <List<ImageUploadModel>> imageUpload({required List<File> files});
}
class CreateProductRemoteDataSourceImpl implements CreateProductRemoteDataSource{
  final Dio dio;

  CreateProductRemoteDataSourceImpl(this.dio);

  @override
  Future<String> createProduct({required CreateProductRequestModel product})async {

    try {
      final response = await dio.post(
        "/product",
        data: product.toJson()
      );

     return response.data['message'];
    } on DioException catch (e) {
      throw Exception(e.friendlyMessage);
    }
  }

  @override
  Future<List<ImageUploadModel>> imageUpload({required List<File> files}) async {
    FormData formData = FormData();

    for (File file in files) {
      formData.files.add(
        MapEntry(
          "files",
          await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          ),
        ),
      );
    }

    try {
      final response = await dio.post(
        "/upload/product-image",
        data: formData,

      );

      final List data = response.data as List;
      return data.map((e) => ImageUploadModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.friendlyMessage);
    }
  }
  @override
  Future<ProductMyProductModel> updateProduct({
    required int id,
    required UpdateProductRequestModel product,
  })
  async {


    try {
      final response = await dio.patch(
        "/product/$id",
        data:product.toJson(),

      );

      return ProductMyProductModel.fromJson(response.data['data']['product']);
    } on DioException catch (e) {
      throw Exception(e.friendlyMessage);
    }
  }
}