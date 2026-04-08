import 'package:roasters/features/create_product/data/models/contact_model.dart';
import 'package:roasters/features/create_product/domain/entities/contact_entity.dart';

extension ContactToModelMapper on ContactEntity {
  ContactModel toModel() {
    return ContactModel(
      type: type,
      number: number,
    );
  }
}