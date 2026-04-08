import 'package:roasters/features/my_favorits/data/models/type_favorite_model.dart';
import 'package:roasters/features/my_favorits/domain/entities/type_favorite_entity.dart';


extension TypeFavoriteMapper on TypeFavoriteModel{
  TypeFavoriteEntity toEntity(){
    return TypeFavoriteEntity(id: id, name: name);
  }
}