
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/features/create_product/domain/entities/update_produc_entity.dart';
import 'package:roasters/features/my_product/domain/entities/product_my_product_entity.dart';
import 'package:roasters/features/my_product/domain/usecases/get_my_product_usecase.dart';
import 'package:roasters/features/my_product/domain/usecases/remove_product_usecase.dart';
import 'package:roasters/features/my_product/domain/usecases/update_is_sold_usecase.dart';
import 'package:roasters/features/my_product/presentation/cubit/state.dart';

class MyProductCubit extends Cubit<MyProductState> {
  final GetMyProductUseCase getMyProductUseCase;
  final RemoveProductUseCase removeProductUseCase;
  final UpdateIsSoldUesCase updateIsSoldUesCase;
  MyProductCubit(this.getMyProductUseCase,
this.removeProductUseCase, this.updateIsSoldUesCase
      ) : super(MyProductInitial());
  List<ProductMyProductEntity> products = [];
  int page = 1;
  final int limit = 10;
  bool isFetching = false;
  Future<void>getMyProducts({bool isRefresh = false})async{
    if (isFetching) return;
    if (isRefresh) {
      page = 1;
      products.clear();
    }
    try {
      isFetching = true;
      if (page == 1) {
        emit(MyProductLoading());
      } else {
        emit(MyProductLoadingMore(products));
      }

      final newProducts = await getMyProductUseCase( page, limit);

      if (newProducts.isEmpty && page == 1) {
        emit(MyProductEmpty("my_products_no_products"));
      } else {
        products.addAll(newProducts);
        final hasReachedMax = newProducts.length < limit;
        emit(MyProductSuccess("my_products_fetch_success"
            ,myProduct:products, hasReachedMax: hasReachedMax));
        page++;
      }
    } catch (e) {
      emit(MyProductError(e.toString()));
    } finally {
      isFetching = false;
    }
}

  Future<void> removeProduct(int idProduct) async {
    try {
      await removeProductUseCase(idProduct: idProduct);

      // حذف من القائمة المحلية بعد نجاح الحذف
      final index = products.indexWhere((p) => p.id == idProduct);
      if (index != -1) {
        products.removeAt(index);
      }



      if (products.isEmpty) {
        emit(MyProductEmpty("my_products_empty"));
      } else {
        emit(MyProductSuccess(
          "my_products_delete_success",
          myProduct: products,
          hasReachedMax: true,
        ));
      }

    } catch (e) {
      emit(RemoveProductError("my_products_delete_error"));
    }
  }

  Future<void> updateIsSold(int productId, bool isSold) async {
    try {
      final index = products.indexWhere((p) => p.id == productId);
      if (index == -1) return;

      final success = await updateIsSoldUesCase(productId: productId, isSold: isSold);
      if (!success) {
        emit(UpdateIsSoldError("my_products_update_sold_error"));
        return;
      }

      products[index] = products[index].copyWith(isSold: isSold);

      emit(MyProductSuccess(
        "my_products_update_sold_success",
        myProduct: List.from(products),
        hasReachedMax: true,
      ));
    } catch (e) {
      emit(UpdateIsSoldError("my_products_update_sold_error"));
    }
  }

  void updateProduct(ProductMyProductEntity updatedProduct) {
    final index = products.indexWhere((p) => p.id == updatedProduct.id);
    if (index != -1) {
      products[index]=updatedProduct;
      emit(MyProductSuccess(
        "my_products_update_success",

        myProduct: List.from(products),

        hasReachedMax: true,
      ));
    }
  }
}