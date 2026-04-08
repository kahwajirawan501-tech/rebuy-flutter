import 'dart:io';

import 'package:roasters/features/create_product/domain/entities/image_upload_entity.dart';
import 'package:roasters/features/create_product/domain/entities/product_entity.dart';
import 'package:roasters/features/create_product/domain/entities/update_produc_entity.dart';
import 'package:roasters/features/my_product/domain/entities/product_my_product_entity.dart';

abstract class CreateProductRepository {
  Future <String> createProduct({required ProductEntity  product});
  Future <List<ImageUploadEntity>> imageUpload({required List<File> files});
  Future<ProductMyProductEntity> updateProduct({
    required int id,
    required UpdateProductEntity product,
  });
}