import 'package:roasters/features/auth/data/LocalDataSource/auth_local_data_source.dart';
import 'package:roasters/features/my_product/data/datasources/my_product_remote_data_sources.dart';
import 'package:roasters/features/my_product/data/mappers/product_my_product_mapper.dart';
import 'package:roasters/features/my_product/domain/entities/product_my_product_entity.dart';
import 'package:roasters/features/my_product/domain/repositories/my_product_repository.dart';

class MyProductRepositoryImpl implements MyProductRepository {
  final MyProductRemoteDataSources myProductRemoteDataSources;
  final AuthLocalDataSource localDataSource;

  MyProductRepositoryImpl(this.myProductRemoteDataSources, this.localDataSource);

  @override
  Future<List<ProductMyProductEntity>> getProductForUser(int page,int limit) async{
    final userId = await localDataSource.getIdUser();

    if (userId == null) {
      throw Exception('User not logged in');
    }
    final model=await myProductRemoteDataSources.getProductForUser(userId,page,limit);
    return model.map((e)=>e.toEntity()).toList();
  }
  @override
  Future<String> removeProduct({required int idProduct})async {
    final message=await myProductRemoteDataSources.removeProduct(idProduct: idProduct);
    return message;
  }

  @override
  Future<bool> updateIsSold({required int productId, required bool isSold})async {

    return await myProductRemoteDataSources.updateIsSold(productId: productId, isSold: isSold);
  }

}