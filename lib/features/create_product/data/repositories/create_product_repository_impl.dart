import 'dart:io';

import 'package:roasters/features/create_product/data/datasources/create_product_remote_data_source.dart';
import 'package:roasters/features/create_product/data/mappers/image_upload_mapper.dart';
import 'package:roasters/features/create_product/data/mappers/product_mapper.dart';
import 'package:roasters/features/create_product/data/mappers/update_product_request_mapper.dart';
import 'package:roasters/features/create_product/data/models/create_product_request.dart';
import 'package:roasters/features/create_product/domain/entities/image_upload_entity.dart';
import 'package:roasters/features/create_product/domain/entities/product_entity.dart';
import 'package:roasters/features/create_product/domain/entities/update_produc_entity.dart';
import 'package:roasters/features/create_product/domain/repositories/create_product_repository.dart';
import 'package:roasters/features/my_product/data/mappers/product_my_product_mapper.dart';
import 'package:roasters/features/my_product/domain/entities/product_my_product_entity.dart';

class CreateProductRepositoryImpl implements CreateProductRepository {
  final CreateProductRemoteDataSource createProductRemoteDataSource;

  CreateProductRepositoryImpl(this.createProductRemoteDataSource);
  @override
  Future<String> createProduct({required ProductEntity  product}) async{
    final model = product.toModel();

    return await createProductRemoteDataSource.createProduct(product: model);
  }
  @override
  Future<ProductMyProductEntity> updateProduct({
    required int id,
    required UpdateProductEntity product,
  }) async {
    final model = product.toModel();
    final p=await createProductRemoteDataSource.updateProduct(
      id: id,
      product: model,
    );
    return p.toEntity();
  }
  @override
  Future<List<ImageUploadEntity>> imageUpload({required List<File> files}) async {
    final models = await createProductRemoteDataSource.imageUpload(files: files);
    return models.map((e) => e.toEntity()).toList();
  }

}