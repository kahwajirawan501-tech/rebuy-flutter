import 'package:roasters/features/search/data/models/image_search_model.dart';
import 'package:roasters/features/search/domain/entities/image_search_entity.dart';

extension ImageSearchMapper on ImageSearchModel{
  ImageSearchEntity toEntity(){
    return ImageSearchEntity(id: id, imageUrl: imageUrl);
  }
}