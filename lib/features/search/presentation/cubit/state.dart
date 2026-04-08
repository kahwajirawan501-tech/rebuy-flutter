import 'package:roasters/features/search/domain/entities/product_search_entity.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}
class SearchLoading extends SearchState {}
class SearchSuccess extends SearchState {
  final String message;
  final List<ProductSearchEntity> products;
  final bool hasReachedMax;

  SearchSuccess(this.message, this.products, {this.hasReachedMax = false});
}
class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}
class SearchEmpty extends SearchState {
  final String message;
  SearchEmpty(this.message);
}
class SearchLoadingMore extends SearchState {
  final List<ProductSearchEntity> products;
  SearchLoadingMore(this.products);
}
class SearchFavoriteError extends SearchState {
  final String message;
  SearchFavoriteError(this.message);
}