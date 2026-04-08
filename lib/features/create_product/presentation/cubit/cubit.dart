import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/features/create_product/data/mappers/update_product_builder.dart';
import 'package:roasters/features/create_product/domain/entities/contact_entity.dart';
import 'package:roasters/features/create_product/domain/entities/price_entity.dart';
import 'package:roasters/features/create_product/domain/entities/product_entity.dart';
import 'package:roasters/features/create_product/domain/usecases/create_product_usecase.dart';
import 'package:roasters/features/create_product/domain/usecases/update_product_usecase.dart';
import 'package:roasters/features/create_product/domain/usecases/upload_image_usecase.dart';
import 'package:roasters/features/create_product/presentation/cubit/state.dart';
import 'package:roasters/features/my_product/domain/entities/price_my_product_entity.dart';
import 'package:roasters/features/my_product/domain/entities/product_my_product_entity.dart';

class CreateProductCubit extends Cubit<CreateProductState> {
  final CreateProductUseCase createProductUseCase;
  final UploadImageUseCase uploadImageUseCase;
  final UpdateProductUseCase updateProductUseCase;
  CreateProductCubit(
      this.createProductUseCase,
      this.uploadImageUseCase, this.updateProductUseCase,
      ) : super(CreateProductFormState());


  int? productId;
  ProductMyProductEntity? originalProduct;

  CreateProductFormState get formState {
    if (state is CreateProductFormState) {
      return state as CreateProductFormState;
    } else {
      return CreateProductFormState();
    }
  }
  int get totalImagesCount {
    return formState.images.length + formState.uploadedImagePaths.length;
  }

  bool get canAddImage {
    return totalImagesCount < 5; // maxImages
  }

  List<dynamic> get allImages {
    return [...formState.uploadedImagePaths, ...formState.images];
  }
  /// ================== SETTERS ==================
  void setImages(List<File> images) {
    if (state is CreateProductFormState) {
      emit(formState.copyWith(images: images));
    }
  }
 void setUploadedImagePaths(List<String>uploadedImagePaths){
   if (state is CreateProductFormState) {
     emit(formState.copyWith(uploadedImagePaths: uploadedImagePaths));
   }
 }
  void setDescription(String description) {
    if (state is CreateProductFormState) {
      emit(formState.copyWith(description: description));
    }
  }

  void setPrice(PriceEntity price) {
    if (state is CreateProductFormState) {
      emit(formState.copyWith(price: price));
    }
  }

  void setProvince(int id) {
    if (state is CreateProductFormState) {
      emit(formState.copyWith(provinceId: id));
    }
  }

  void setAddress(String address) {
    if (state is CreateProductFormState) {
      emit(formState.copyWith(address: address));
    }
  }

  void setType(int id) {
    if (state is CreateProductFormState) {
      emit(formState.copyWith(typeId: id));
    }
  }

  void setContacts(List<ContactEntity> contacts) {
    if (state is CreateProductFormState) {
      emit(formState.copyWith(contacts: contacts));
    }
  }

  /// ================== SUBMIT ==================
  Future<void> submit() async {
    if (state is! CreateProductFormState) return;

    final currentForm = formState;

    try {
      emit(CreateProductLoading());

      List<String> imagePaths = currentForm.uploadedImagePaths;

      if (imagePaths.isEmpty && currentForm.images.isNotEmpty) {
        final uploaded = await uploadImageUseCase(files: currentForm.images);
        imagePaths = uploaded.map((e) => e.path).toList();
      }

      if (originalProduct != null) {
        // ===== UPDATE =====
        final updateEntity = UpdateProductBuilder.build(

          old: originalProduct!,
          current: currentForm,
          imagePaths: imagePaths,
        );

        final result = await updateProductUseCase(
          id: originalProduct!.id,
          product: updateEntity,
        );

        emit(UpdateProductSuccess("product_update_success", result));
      } else {
        // ===== CREATE =====
        final product = ProductEntity(
          description: currentForm.description,
          price: currentForm.price,
          provinceId: currentForm.provinceId!,
          addressText: currentForm.address,
          typeId: currentForm.typeId!,
          images: imagePaths,
          contacts: currentForm.contacts,
        );

        final result = await createProductUseCase(product: product);

        emit(CreateProductSuccess(result));
      }

    } catch (e) {
      emit(CreateProductError(e.toString()));
    }
  }
}