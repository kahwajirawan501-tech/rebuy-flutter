import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/features/search/domain/entities/product_search_entity.dart';
import 'package:roasters/features/search/domain/usecases/add_favorite_usecase.dart';
import 'package:roasters/features/search/domain/usecases/remove_favorite_usecase.dart';
import 'package:roasters/features/search/domain/usecases/search_product_usecase.dart';
import 'package:roasters/features/search/presentation/cubit/state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchProductUseCase searchProductUseCase;
  final AddFavoriteUseCase addFavoriteUseCase;
  final RemoveFavoriteUseCase removeFavoriteUseCase;
  int page = 1;
  final int limit = 10;
  bool isFetching = false;
  List<ProductSearchEntity> products = [];

  SearchCubit(this.searchProductUseCase,  this.addFavoriteUseCase, this.removeFavoriteUseCase) : super(SearchInitial());

  Future<void> getSearch(
      {bool isRefresh = false,
        required int typeId,  int? provinceId,  String? text})
  async {
    if (isFetching) return;

    if (isRefresh) {
      page = 1;
      products.clear();
    }

    try {
      isFetching = true;
      if (page == 1) {
        emit(SearchLoading());
      } else {
        emit(SearchLoadingMore(products));
      }

      final newProducts = await searchProductUseCase(typeId, provinceId, text, page, limit);

      if (newProducts.isEmpty && page == 1) {
        emit(SearchEmpty("search_page_no_products_found"));
      } else {
        products.addAll(newProducts);
        final hasReachedMax = newProducts.length < limit;
        emit(SearchSuccess("search_page_search_successful", products, hasReachedMax: hasReachedMax));
        page++;
      }
    } catch (e) {
      emit(SearchError(e.toString()));
    } finally {
      isFetching = false;
    }
  }
  Future<void> toggleFavorite(int idProduct) async {
    try {
      final index = products.indexWhere((p) => p.id == idProduct);
      if (index == -1) return;

      final currentProduct = products[index];

      if (currentProduct.isFavorite) {
        // إزالة
        await removeFavoriteUseCase(idProduct: idProduct);
      } else {
        // إضافة
        await addFavoriteUseCase(idProduct: idProduct);
      }

      // تحديث الحالة محليًا
      final updatedProduct = currentProduct.copyWith(
        isFavorite: !currentProduct.isFavorite,
      );

      products[index] = updatedProduct;
      emit(SearchSuccess("search_page_updated_favorite", List.from(products),));
    } catch (e) {
      emit(SearchFavoriteError(e.toString()));
    }
  }
}