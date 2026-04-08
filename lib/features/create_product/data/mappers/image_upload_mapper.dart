import 'package:roasters/features/create_product/data/models/image_upload_model.dart';
import 'package:roasters/features/create_product/domain/entities/image_upload_entity.dart';

extension ImageUploadMapper on ImageUploadModel{
  ImageUploadEntity toEntity(){
    return ImageUploadEntity(
        originalname: originalname,
        filename: filename, path: path);
  }
}