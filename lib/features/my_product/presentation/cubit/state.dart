

import 'package:roasters/features/my_product/domain/entities/product_my_product_entity.dart';

abstract class MyProductState {}

class MyProductInitial extends MyProductState {}
class MyProductLoading extends MyProductState {}
class MyProductSuccess extends MyProductState {
  final String message;
  final List<ProductMyProductEntity>myProduct;
  final bool hasReachedMax;
  MyProductSuccess(this.message, {required this.myProduct,this.hasReachedMax = false});
}
class MyProductError extends MyProductState {
  final String message;
  MyProductError(this.message);
}
class MyProductEmpty extends MyProductState {
  final String message;
  MyProductEmpty(this.message);
}
class MyProductLoadingMore extends MyProductState {
  final List<ProductMyProductEntity> products;
  MyProductLoadingMore(this.products);
}
class RemoveMyProductLoading extends MyProductState {}


class UpdateIsSoldError extends MyProductState {
  final String message;
  UpdateIsSoldError(this.message);
}
class RemoveProductError extends MyProductState {
  final String message;
  RemoveProductError(this.message);
}

class UpdateProductError extends MyProductState {
  final String message;
  UpdateProductError(this.message);
}
