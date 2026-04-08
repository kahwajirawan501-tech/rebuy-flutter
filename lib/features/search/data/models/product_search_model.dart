import 'package:roasters/features/search/data/models/contact_search_model.dart';
import 'package:roasters/features/search/data/models/image_search_model.dart';
import 'package:roasters/features/search/data/models/price_search_model.dart';
import 'package:roasters/features/search/data/models/seller_model.dart';
import 'package:roasters/features/search/data/models/type_search_model.dart';
import 'package:roasters/features/search/data/models/province_search_model.dart';

class ProductSearchModel {
  final int id;
  final String description;
  final bool isSold;
  final int userId;
  final int provinceId;
  final String addressText;
  final int typeId;
  final DateTime createdAt;
  final DateTime updatedAt;

  final List<ImageSearchModel> images;
  final List<ContactSearchModel> contacts;
  final ProvinceSearchModel province;
  final TypeSearchModel type;
  final PriceSearchModel? price;
  final SellerModel user;
  final bool isFavorite;

  ProductSearchModel({
    required this.id,
    required this.description,
    required this.isSold,
    required this.userId,
    required this.provinceId,
    required this.addressText,
    required this.typeId,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
    required this.contacts,
    required this.province,
    required this.type,
    required this.price,
    required this.isFavorite, required this.user,
  });

  factory ProductSearchModel.fromJson(Map<String, dynamic> json) {
    return ProductSearchModel(
      id: json['id'],
      description: json['description'],
      isSold: json['is_sold'],
      userId: json['user_id'],
      provinceId: json['province_id'],
      addressText: json['address_text'],
      typeId: json['type_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
       user:SellerModel.fromJson(json['user']) ,

      images: (json['images'] as List)
          .map((e) => ImageSearchModel.fromJson(e))
          .toList(),

      contacts: (json['contacts'] as List)
          .map((e) => ContactSearchModel.fromJson(e))
          .toList(),

      province: ProvinceSearchModel.fromJson(json['province']),
      type: TypeSearchModel.fromJson(json['type']),

      price: json['price'] != null &&
          json['price']['price'] != null
          ? PriceSearchModel.fromJson(json['price'])
          : null,

      isFavorite: json['is_favorite'],
    );
  }
}