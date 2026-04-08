


import 'package:roasters/features/my_product/data/models/contact_my_product_model.dart';
import 'package:roasters/features/my_product/data/models/image_favorite_model.dart';
import 'package:roasters/features/my_product/data/models/price_my_product_model.dart';
import 'package:roasters/features/my_product/data/models/province_my_product_model.dart';
import 'package:roasters/features/my_product/data/models/type_my_product_model.dart';

class ProductMyProductModel {
  final int id;
  final String description;
  final bool isSold;
  final int userId;
  final int provinceId;
  final String addressText;
  final int typeId;
  final DateTime createdAt;
  final DateTime updatedAt;

  final List<ImageMyProductModel> images;
  final List<ContactMyProductModel> contacts;
  final ProvinceMyProductModel province;
  final TypeMyProductModel type;
  final PriceMyProductModel? price;
  final bool isFavorite;

  ProductMyProductModel({
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
    required this.isFavorite,
  });

  factory ProductMyProductModel.fromJson(Map<String, dynamic> json) {
    return ProductMyProductModel(
      id: json['id'],
      description: json['description'],
      isSold: json['is_sold'],
      userId: json['user_id'],
      provinceId: json['province_id'],
      addressText: json['address_text'],
      typeId: json['type_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),

      images: (json['images'] as List)
          .map((e) => ImageMyProductModel.fromJson(e))
          .toList(),

      contacts: (json['contacts'] as List)
          .map((e) => ContactMyProductModel.fromJson(e))
          .toList(),

      province: ProvinceMyProductModel.fromJson(json['province']),
      type: TypeMyProductModel.fromJson(json['type']),

      price: json['price'] != null &&
          json['price']['price'] != null
          ? PriceMyProductModel.fromJson(json['price'])
          : null,

      isFavorite: json['is_favorite'],
    );
  }
}