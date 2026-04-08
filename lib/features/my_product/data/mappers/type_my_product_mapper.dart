import 'package:roasters/features/my_favorits/data/models/type_favorite_model.dart';
import 'package:roasters/features/my_favorits/domain/entities/type_favorite_entity.dart';
import 'package:roasters/features/my_product/data/models/type_my_product_model.dart';
import 'package:roasters/features/my_product/domain/entities/type_my_product_entity.dart';


extension TypeMyProductMapper on TypeMyProductModel{
  TypeMyProductEntity toEntity(){
    return TypeMyProductEntity(id: id, name: name);
  }
}