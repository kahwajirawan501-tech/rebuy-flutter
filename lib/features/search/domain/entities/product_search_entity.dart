import 'package:roasters/features/search/domain/entities/contact_search_entity.dart';
import 'package:roasters/features/search/domain/entities/image_search_entity.dart';
import 'package:roasters/features/search/domain/entities/price_search_entity.dart';
import 'package:roasters/features/search/domain/entities/province_search_entity.dart';
import 'package:roasters/features/search/domain/entities/seller_entity.dart';
import 'package:roasters/features/search/domain/entities/type_search_entity.dart';

class ProductSearchEntity {
  final int id;
  final String description;
  final bool isSold;
  final int userId;
  final int provinceId;
  final String addressText;
  final int typeId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SellerEntity user;
  final List<ImageSearchEntity> images;
  final List<ContactSearchEntity> contacts;
  final ProvinceSearchEntity province;
  final TypeSearchEntity type;
  final PriceSearchEntity? price;
  final bool isFavorite;

  ProductSearchEntity({
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
    required this.user,
  });

  // copyWith كامل
  ProductSearchEntity copyWith({
    int? id,
    String? description,
    bool? isSold,
    int? userId,
    int? provinceId,
    String? addressText,
    int? typeId,
    DateTime? createdAt,
    DateTime? updatedAt,
    SellerEntity? user,
    List<ImageSearchEntity>? images,
    List<ContactSearchEntity>? contacts,
    ProvinceSearchEntity? province,
    TypeSearchEntity? type,
    PriceSearchEntity? price,
    bool? isFavorite,
  }) {
    return ProductSearchEntity(
      id: id ?? this.id,
      description: description ?? this.description,
      isSold: isSold ?? this.isSold,
      userId: userId ?? this.userId,
      provinceId: provinceId ?? this.provinceId,
      addressText: addressText ?? this.addressText,
      typeId: typeId ?? this.typeId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
      images: images ?? this.images,
      contacts: contacts ?? this.contacts,
      province: province ?? this.province,
      type: type ?? this.type,
      price: price ?? this.price,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}