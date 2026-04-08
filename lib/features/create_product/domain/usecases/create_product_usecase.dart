import 'package:roasters/features/create_product/data/models/create_product_request.dart';
import 'package:roasters/features/create_product/domain/entities/product_entity.dart';
import 'package:roasters/features/create_product/domain/repositories/create_product_repository.dart';

class CreateProductUseCase  {
  final CreateProductRepository createProductRepository;

  CreateProductUseCase( this.createProductRepository);

  Future  <String> call({required ProductEntity  product})async{
    return await createProductRepository.createProduct(product: product);
  }
}