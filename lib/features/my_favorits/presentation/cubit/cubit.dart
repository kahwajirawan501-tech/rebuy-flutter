import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/features/my_favorits/domain/entities/favorite_entity.dart';
import 'package:roasters/features/my_favorits/domain/usecases/add_favorite_usecase.dart';
import 'package:roasters/features/my_favorits/domain/usecases/get_favorite_usecase.dart';
import 'package:roasters/features/my_favorits/domain/usecases/remove_favorite_usecase.dart';
import 'package:roasters/features/my_favorits/presentation/cubit/state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
 final GetFavoriteUseCase getFavoriteUseCase;
 final RemoveProductFromFavoriteUseCase removeFavoriteUseCase;
 final AddProductToFavoriteUseCase  addFavoriteUseCase;
  FavoriteCubit(this.getFavoriteUseCase, this.removeFavoriteUseCase, this.addFavoriteUseCase,
      ) : super(FavoriteInitial());
 List<FavoriteEntity> products = [];
 Future<void>getFavorites()async{
   try {
     emit(FavoriteLoading());
     final newProducts = await getFavoriteUseCase();
     products = newProducts;

     if (products.isEmpty) {
       emit(FavoriteEmpty("favorites_empty"));
     } else {
       emit(FavoriteSuccess(
         "favorites_loaded_success",
         favorite: newProducts,
       ));
     }
   } catch (e) {
     emit(FavoriteError(e.toString()));
   }
 }
  Future<void> toggleFavorite(int idProduct) async {
    try {
      final index = products.indexWhere((p) => p.product.id == idProduct);
      if (index == -1) return;

      final currentProduct = products[index].product;

      if (currentProduct.isFavorite) {
        // إزالة
        await removeFavoriteUseCase(idProduct: idProduct);
      } else {
        // إضافة
        await addFavoriteUseCase(idProduct: idProduct);
      }
      getFavorites();
      // تحديث الحالة محليًا
      final updatedProduct = currentProduct.copyWith(
        isFavorite: !currentProduct.isFavorite,
      );

      products[index].copyWith(product: updatedProduct);
      emit(FavoriteSuccess("favorites_updated",favorite: products));
    } catch (e) {
      emit(AddRemoveFavoriteError("favorites_update_error"));
    }
  }
}