import 'package:roasters/features/create_product/data/models/create_product_request.dart';
import 'package:roasters/features/create_product/domain/entities/product_entity.dart';
import 'package:roasters/features/create_product/domain/entities/update_produc_entity.dart';
import 'package:roasters/features/create_product/domain/repositories/create_product_repository.dart';
import 'package:roasters/features/my_product/domain/entities/product_my_product_entity.dart';

class UpdateProductUseCase  {
  final CreateProductRepository createProductRepository;

  UpdateProductUseCase( this.createProductRepository);

  Future  <ProductMyProductEntity> call({required UpdateProductEntity  product,required int id})async{
    return await createProductRepository.updateProduct(id: id,product: product);
  }
}