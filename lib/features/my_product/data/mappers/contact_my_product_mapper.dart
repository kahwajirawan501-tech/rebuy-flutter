

import 'package:roasters/features/my_product/data/models/contact_my_product_model.dart';
import 'package:roasters/features/my_product/domain/entities/contact_my_product_entity.dart';

extension ContactMyProductMapper on ContactMyProductModel{
  ContactMyProductEntity toEntity(){
    return ContactMyProductEntity(id: id, type: type, number: number);
  }
}