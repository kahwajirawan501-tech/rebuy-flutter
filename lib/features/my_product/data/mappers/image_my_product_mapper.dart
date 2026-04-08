

import 'package:roasters/features/my_product/data/models/image_favorite_model.dart';
import 'package:roasters/features/my_product/domain/entities/image_my_product_entity.dart';

extension ImageMyProductMapper on ImageMyProductModel{
  ImageMyProductEntity toEntity(){
    return ImageMyProductEntity(id: id, imageUrl: imageUrl);
  }
}