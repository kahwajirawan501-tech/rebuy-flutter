
import 'package:roasters/features/my_favorits/data/models/contact_favorite_model.dart';
import 'package:roasters/features/my_favorits/domain/entities/contact_favorite_entity.dart';

extension ContactFavoriteMapper on ContactFavoriteModel{
  ContactFavoriteEntity toEntity(){
    return ContactFavoriteEntity(id: id, type: type, number: number);
  }
}