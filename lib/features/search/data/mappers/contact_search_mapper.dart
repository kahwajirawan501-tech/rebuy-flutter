import 'package:roasters/features/search/data/models/contact_search_model.dart';
import 'package:roasters/features/search/domain/entities/contact_search_entity.dart';

extension ContactSearchMapper on ContactSearchModel{
  ContactSearchEntity toEntity(){
    return ContactSearchEntity(id: id, type: type, number: number);
  }
}