
import 'package:roasters/features/my_favorits/data/models/image_favorite_model.dart';
import 'package:roasters/features/my_favorits/domain/entities/image_favorite_entity.dart';

extension ImageFavoriteMapper on ImageFavoriteModel{
  ImageFavoriteEntity toEntity(){
    return ImageFavoriteEntity(id: id, imageUrl: imageUrl);
  }
}