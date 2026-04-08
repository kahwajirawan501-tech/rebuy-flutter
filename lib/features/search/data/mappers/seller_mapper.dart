import 'package:roasters/features/search/data/models/seller_model.dart';
import 'package:roasters/features/search/domain/entities/seller_entity.dart';

extension  SellerMapper on SellerModel{
  SellerEntity toEntity(){
    return SellerEntity
      (id: id, name: name, email: email, profileImage: profileImage, phone: phone);
  }
}