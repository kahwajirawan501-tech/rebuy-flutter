import 'package:roasters/features/my_product/domain/entities/product_my_product_entity.dart';
import 'package:roasters/features/my_product/domain/repositories/my_product_repository.dart';

class GetMyProductUseCase {
  final MyProductRepository myProductRepository;

  GetMyProductUseCase(this.myProductRepository);
  Future<List<ProductMyProductEntity>>call(int page,int limit)async{
    return await myProductRepository.getProductForUser(  page, limit);
  }
}