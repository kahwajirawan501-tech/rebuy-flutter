

import 'package:roasters/features/my_product/domain/entities/contact_my_product_entity.dart';
import 'package:roasters/features/my_product/domain/entities/image_my_product_entity.dart';
import 'package:roasters/features/my_product/domain/entities/price_my_product_entity.dart';
import 'package:roasters/features/my_product/domain/entities/province_my_product_entity.dart';
import 'package:roasters/features/my_product/domain/entities/type_my_product_entity.dart';

class ProductMyProductEntity {
  final int id;
  final String description;
  final bool isSold;
  final int userId;
  final int provinceId;
  final String addressText;
  final int typeId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ImageMyProductEntity> images;
  final List<ContactMyProductEntity> contacts;
  final ProvinceMyProductEntity province;
  final TypeMyProductEntity type;
  final PriceMyProductEntity? price;
  final bool isFavorite;

  ProductMyProductEntity({
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

  ProductMyProductEntity copyWith({
    int? id,
    String? description,
    bool? isSold,
    int? userId,
    int? provinceId,
    String? addressText,
    int? typeId,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<ImageMyProductEntity>? images,
    List<ContactMyProductEntity>? contacts,
    ProvinceMyProductEntity? province,
    TypeMyProductEntity? type,
    PriceMyProductEntity? price,
    bool? isFavorite,
  }) {
    return ProductMyProductEntity(
      id: id ?? this.id,
      description: description ?? this.description,
      isSold: isSold ?? this.isSold,
      userId: userId ?? this.userId,
      provinceId: provinceId ?? this.provinceId,
      addressText: addressText ?? this.addressText,
      typeId: typeId ?? this.typeId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      images: images ?? this.images,
      contacts: contacts ?? this.contacts,
      province: province ?? this.province,
      type: type ?? this.type,
      price: price ?? this.price,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}