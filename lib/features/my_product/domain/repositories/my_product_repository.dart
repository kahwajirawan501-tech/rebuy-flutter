import 'package:roasters/features/my_product/domain/entities/product_my_product_entity.dart';

abstract class MyProductRepository {
  Future<List<ProductMyProductEntity>>getProductForUser(int page,int limit);
  Future <String> removeProduct({required int idProduct});
  Future<bool>updateIsSold({required int productId,required bool isSold});

}