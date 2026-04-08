

import 'package:roasters/features/my_product/data/models/province_my_product_model.dart';
import 'package:roasters/features/my_product/domain/entities/province_my_product_entity.dart';

extension ProvinceMyProductMapper on ProvinceMyProductModel{
  ProvinceMyProductEntity toEntity(){
    return ProvinceMyProductEntity(id: id, name: name);
  }
}