import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/constants/url_image.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import 'package:roasters/core/services/options_menu_delete_edit.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';
import 'package:roasters/features/create_product/presentation/cubit/cubit.dart';
import 'package:roasters/features/create_product/presentation/cubit/state.dart';

class ProductImagesStep extends StatefulWidget {
  const ProductImagesStep({super.key});

  @override
  State<ProductImagesStep> createState() => _ProductImagesStepState();
}

class _ProductImagesStepState extends State<ProductImagesStep> {
  static const int maxImages = 5;
  final size = AppSizes.instance;

  /// ========== REMOVE NEW IMAGE ==========
  void _removeNewImage(int index) {
    final cubit = context.read<CreateProductCubit>();
    final updated = [...cubit.formState.images]..removeAt(index);
    cubit.setImages(updated);
  }

  /// ========== REMOVE OLD IMAGE ==========
  void _removeOldImage(int index) {
    final cubit = context.read<CreateProductCubit>();
    final updated = [...cubit.formState.uploadedImagePaths]..removeAt(index);
    cubit.setUploadedImagePaths(updated);
  }

  /// ========== ADD IMAGE ==========
  Widget _buildAddImageTile() {
    return GestureDetector(
      onTap: () {
        OptionsBottomSheet(
          context: context,
          isImage: true,
          showEdit: false,
          showDelete: false,
          onImageSelected: (file) {
            final cubit = context.read<CreateProductCubit>();

            final totalImages =
                cubit.formState.images.length +
                    cubit.formState.uploadedImagePaths.length;

            if (totalImages >= maxImages) return;

            final updated = [
              ...cubit.formState.images,
              File(file.path),
            ];

            cubit.setImages(updated);
          },
        ).show();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.borderRadius.medium),
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
          child: Icon(Icons.add, size: size.icons.extraLarge),
        ),
      ),
    );
  }

  /// ========== NEW IMAGE TILE ==========
  Widget _buildNewImageTile(File image, int index) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(size.borderRadius.medium),
          child: Image.file(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: GestureDetector(
            onTap: () => _removeNewImage(index),
            child: _buildCloseIcon(),
          ),
        ),
      ],
    );
  }

  /// ========== OLD IMAGE TILE ==========
  Widget _buildOldImageTile(String url, int index) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(size.borderRadius.medium),
          child: Image.network(
            url,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: GestureDetector(
            onTap: () => _removeOldImage(index),
            child: _buildCloseIcon(),
          ),
        ),
      ],
    );
  }

  /// ========== CLOSE ICON ==========
  Widget _buildCloseIcon() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black54,
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(4),
      child: Icon(
        Icons.close,
        size: size.icons.medium,
        color: AppColors.primaryLight,
      ),
    );
  }

  /// ========== BUILD ==========
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
      builder: (context, state) {
        final cubit = context.read<CreateProductCubit>();

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.padding.screenHorizontal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).translate("add_product_images"),
                style: AppTextStyles.firaMedium24(),
              ),
              SizedBox(height: size.spacing.tiny),
              Text(
                AppLocalizations.of(context)
                    .translate("upload_images_limit")
                    .replaceAll("{count}", maxImages.toString()),
                style: AppTextStyles.firaMedium14(),
              ),
              SizedBox(height: size.spacing.medium),

              Expanded(
                child: GridView.builder(
                  itemCount: cubit.canAddImage ? cubit.totalImagesCount + 1 : cubit.totalImagesCount,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    if (index == cubit.totalImagesCount && cubit.canAddImage) {
                      return _buildAddImageTile();
                    }

                    final isOld = index < cubit.formState.uploadedImagePaths.length;
                    if (isOld) {
                      return _buildOldImageTile(url+cubit.formState.uploadedImagePaths[index], index);
                    } else {
                      final newIndex = index - cubit.formState.uploadedImagePaths.length;
                      return _buildNewImageTile(cubit.formState.images[newIndex], newIndex);
                    }
                  },
                ),
              ),            ],
          ),
        );
      },
    );
  }
}