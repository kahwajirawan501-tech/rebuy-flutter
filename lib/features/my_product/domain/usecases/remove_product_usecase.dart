import 'package:roasters/features/my_product/domain/repositories/my_product_repository.dart';

class RemoveProductUseCase {
  final MyProductRepository myProductRepository;

  RemoveProductUseCase(this.myProductRepository);
  Future<String>call({required int idProduct})async{
    return await myProductRepository.removeProduct(idProduct: idProduct);
  }
}