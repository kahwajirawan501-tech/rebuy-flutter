import 'dart:io';

import 'package:roasters/features/create_product/domain/entities/contact_entity.dart';
import 'package:roasters/features/create_product/domain/entities/price_entity.dart';
import 'package:roasters/features/create_product/domain/entities/update_produc_entity.dart';
import 'package:roasters/features/my_product/domain/entities/product_my_product_entity.dart';

abstract class CreateProductState {}

class CreateProductInitial extends CreateProductState {}

class CreateProductLoading extends CreateProductState {}

class CreateProductSuccess extends CreateProductState {
  final String message;
  CreateProductSuccess(this.message);
}
class UpdateProductSuccess extends CreateProductState {
  final String message;
  final ProductMyProductEntity updateProductEntity;
  UpdateProductSuccess(this.message, this.updateProductEntity);
}

class CreateProductError extends CreateProductState {
  final String error;
  CreateProductError(this.error);
}

class CreateProductFormState extends CreateProductState {
  final List<File> images;
  final List<String> uploadedImagePaths;

  final String description;
  final PriceEntity? price;
  final int? provinceId;
  final String address;

  final int? typeId;

  final List<ContactEntity> contacts;

  CreateProductFormState({
    this.images = const [],
    this.uploadedImagePaths = const [],
    this.description = '',
     this.price,
    this.provinceId,
    this.address = '',
    this.typeId,
    this.contacts = const [],
  });

  CreateProductFormState copyWith({
    List<File>? images,
    List<String>? uploadedImagePaths,
    String? description,
    PriceEntity? price,
    int? provinceId,
    String? address,
    int? typeId,
    List<ContactEntity>? contacts,
  }) {
    return CreateProductFormState(
      images: images ?? this.images,
      uploadedImagePaths: uploadedImagePaths ?? this.uploadedImagePaths,
      description: description ?? this.description,
      price: price ?? this.price,
      provinceId: provinceId ?? this.provinceId,
      address: address ?? this.address,
      typeId: typeId ?? this.typeId,
      contacts: contacts ?? this.contacts,
    );
  }
}