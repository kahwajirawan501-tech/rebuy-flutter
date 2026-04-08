
import 'package:roasters/features/my_favorits/data/models/seller_model.dart';
import 'package:roasters/features/my_favorits/domain/entities/seller_entity.dart';

extension  SellerFavoriteMapper on SellerFavoriteModel{
  SellerFavoriteEntity toEntity(){
    return SellerFavoriteEntity
      (id: id, name: name, email: email, profileImage: profileImage, phone: phone);
  }
}