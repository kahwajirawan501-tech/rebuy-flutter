import 'package:roasters/features/create_product/domain/entities/contact_entity.dart';
import 'package:roasters/features/create_product/domain/entities/price_entity.dart';

class ProductEntity {
  final String description;
 final int provinceId;
  final String addressText;
  final int typeId;
  final List<String> images;
  final List<ContactEntity> contacts;
  final PriceEntity? price;

  ProductEntity({
    required this.description,
    required this.price,
    required this.provinceId,
    required this.addressText,
    required  this.typeId,
    required this.images,
    required this.contacts,
  });
}