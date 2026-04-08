import 'package:roasters/features/my_product/domain/repositories/my_product_repository.dart';

class UpdateIsSoldUesCase {
  final MyProductRepository myProductRepository;

  UpdateIsSoldUesCase(this.myProductRepository);
  Future<bool>call({required int productId,required bool isSold})async{
    return await myProductRepository.updateIsSold(productId: productId,isSold:isSold );
  }
}