
import 'package:roasters/features/my_favorits/data/models/contact_favorite_model.dart';
import 'package:roasters/features/my_favorits/data/models/image_favorite_model.dart';
import 'package:roasters/features/my_favorits/data/models/price_favorite_model.dart';
import 'package:roasters/features/my_favorits/data/models/province_favorite_model.dart';
import 'package:roasters/features/my_favorits/data/models/seller_model.dart';
import 'package:roasters/features/my_favorits/data/models/type_favorite_model.dart';

class ProductFavoriteModel {
  final int id;
  final String description;
  final bool isSold;
  final int userId;
  final int provinceId;
  final String addressText;
  final int typeId;
  final DateTime createdAt;
  final DateTime updatedAt;

  final List<ImageFavoriteModel> images;
  final List<ContactFavoriteModel> contacts;
  final ProvinceFavoriteModel province;
  final TypeFavoriteModel type;
  final PriceFavoriteModel? price;
  final SellerFavoriteModel user;
  final bool isFavorite;

  ProductFavoriteModel({
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

  factory ProductFavoriteModel.fromJson(Map<String, dynamic> json) {
    return ProductFavoriteModel(
      id: json['id'],
      description: json['description'],
      isSold: json['is_sold'],
      userId: json['user_id'],
      provinceId: json['province_id'],
      addressText: json['address_text'],
      typeId: json['type_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
       user:SellerFavoriteModel.fromJson(json['user']) ,

      images: (json['images'] as List)
          .map((e) => ImageFavoriteModel.fromJson(e))
          .toList(),

      contacts: (json['contacts'] as List)
          .map((e) => ContactFavoriteModel.fromJson(e))
          .toList(),

      province: ProvinceFavoriteModel.fromJson(json['province']),
      type: TypeFavoriteModel.fromJson(json['type']),

      price: json['price'] != null &&
          json['price']['price'] != null
          ? PriceFavoriteModel.fromJson(json['price'])
          : null,

      isFavorite: json['is_favorite'],
    );
  }
}