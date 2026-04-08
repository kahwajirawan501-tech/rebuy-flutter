import 'package:roasters/features/search/domain/entities/contact_search_entity.dart';
import 'package:roasters/features/search/domain/entities/price_search_entity.dart';

class ProductDetailsEntity {
  final String sellerName;
  final String? sellerProfileImage;
  final String description;
  final PriceSearchEntity? price;
  final List<String> images;
  final List<ContactSearchEntity> contacts;
  final String location;
  final String addressText;
  final bool isSold;


  ProductDetailsEntity({
    required this.sellerName,
    this.sellerProfileImage,
    required this.description,
    required this.images,
    required this.contacts,
    required this.location, required this.price, required this.addressText, required this.isSold,
  });
}