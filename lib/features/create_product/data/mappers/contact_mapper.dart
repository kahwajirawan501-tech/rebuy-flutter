import 'package:roasters/features/create_product/data/models/contact_model.dart';
import 'package:roasters/features/create_product/domain/entities/contact_entity.dart';

extension ContactMapper on ContactModel{
  ContactEntity toEntity(){
    return ContactEntity(type: type, number: number);
  }
}