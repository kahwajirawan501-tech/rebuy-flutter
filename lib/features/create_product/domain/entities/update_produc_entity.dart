import 'package:roasters/features/create_product/domain/entities/contact_entity.dart';
import 'package:roasters/features/create_product/domain/entities/price_entity.dart';

class UpdateProductEntity {
  final String? description;
  final PriceEntity? price;
  final int? provinceId;
  final String? addressText;
  final int? typeId;
  final List<String>? images;
  final List<ContactEntity>? contacts;

  const UpdateProductEntity( {
    this.description,
    this.price,
    this.provinceId,
    this.addressText,
    this.typeId,
    this.images,
    this.contacts,
  });
}