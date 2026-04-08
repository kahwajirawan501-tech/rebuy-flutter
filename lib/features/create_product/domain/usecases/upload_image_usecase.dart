import 'dart:io';

import 'package:roasters/features/create_product/domain/entities/image_upload_entity.dart';
import 'package:roasters/features/create_product/domain/repositories/create_product_repository.dart';

class UploadImageUseCase {
  final CreateProductRepository createProductRepository;

  UploadImageUseCase( this.createProductRepository);
  Future<List<ImageUploadEntity>>call({required List<File> files})async{
    return await createProductRepository.imageUpload(files: files);
  }
}