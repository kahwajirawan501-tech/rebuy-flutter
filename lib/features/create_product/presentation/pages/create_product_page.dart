import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/di/service_locator.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';
import 'package:roasters/core/utils/validators.dart';
import 'package:roasters/features/create_product/domain/entities/contact_entity.dart';
import 'package:roasters/features/create_product/domain/entities/price_entity.dart';
import 'package:roasters/features/create_product/presentation/cubit/cubit.dart';
import 'package:roasters/features/create_product/presentation/cubit/state.dart';
import 'package:roasters/features/create_product/presentation/widgets/product_contact_step.dart';
import 'package:roasters/features/create_product/presentation/widgets/product_description_step.dart';
import 'package:roasters/features/create_product/presentation/widgets/product_images_step..dart';
import 'package:roasters/features/create_product/presentation/widgets/product_location_step.dart';
import 'package:roasters/features/create_product/presentation/widgets/product_type_step.dart';
import 'package:roasters/features/create_product/presentation/widgets/step_indicator.dart';
import 'package:roasters/features/my_product/domain/entities/product_my_product_entity.dart';
import 'package:roasters/shared/widgets/buttons/app_back_button.dart';
import 'package:roasters/shared/widgets/buttons/app_button.dart';
import 'package:roasters/shared/widgets/loaders/app_loader.dart';
import 'package:roasters/shared/widgets/toast/toast_widget.dart';

class CreateProductPage extends StatefulWidget {
  final ProductMyProductEntity? product;
  const CreateProductPage({super.key,this.product});

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  int currentStep = 0;

  final List<Widget> steps = const [
    ProductImagesStep(),
    ProductDescriptionStep(),
    ProductTypeStep(),
    ProductLocationStep(),
    ProductContactStep(),
  ];

  /// ================= VALIDATION =================
  void nextStep() {
    final cubit = context.read<CreateProductCubit>();
    final state = cubit.formState;

    switch (currentStep) {
      case 0:
        if (state.images.isEmpty && (widget.product?.images.isEmpty ?? true)) {
          _showMessage(AppLocalizations.of(context).translate("validation_add_image"));          return;
        }
        break;
      case 1:
        if ((state.description ?? "").isEmpty) {
          _showMessage(AppLocalizations.of(context).translate("validation_description"));          return;
        }
        break;
      case 2:
        if (state.typeId == null) {
          _showMessage(AppLocalizations.of(context).translate("validation_select_type"));          return;
        }
        break;
      case 3:
        if (state.provinceId == null) {
          _showMessage(AppLocalizations.of(context).translate("validation_select_city"));          return;
        }
        break;
    }

    if (currentStep < steps.length - 1) {
      setState(() => currentStep++);
    }
  }  /// ================= PREVIOUS STEP =================
  void previousStep() {
    if (currentStep > 0) {
      setState(() => currentStep--);
    }
  }
  /// ================= VALIDATION FOR CONTACTS =================
  bool validateStep4(CreateProductFormState state) {
    if (state.contacts.isEmpty) {
      _showMessage(AppLocalizations.of(context).translate("validation_phone_required"));
      return false;
    }

    for (var contact in state.contacts) {
      final error = AppValidators.phone(contact.number,context);
      if (error != null) {
        _showMessage(error);
        return false;
      }
    }

    return true;
  }
  /// ================= VALIDATION MESSAGE =================
  void _showMessage(String msg) {
   showToast(text: msg, state: ToastStates.SUCCESS);
  }


  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      final cubit = context.read<CreateProductCubit>();
      final product = widget.product!;

      cubit.productId = widget.product!.id;
      cubit.originalProduct = widget.product;
      cubit.setDescription(product.description);

      if (product.price != null) {
        cubit.setPrice(
          PriceEntity(
            price: product.price!.price,
            type: product.price!.type,
          ),
        );
      }

      cubit.setProvince(product.province.id);
      cubit.setType(product.type.id);

      cubit.setAddress(product.addressText);

      cubit.setContacts(
        product.contacts
            .map((e) => ContactEntity(
          type: e.type,
          number: e.number,
        ))
            .toList(),
      );
      cubit.setUploadedImagePaths(product.images.map((e)=>e.imageUrl).toList());

    }
  }
  /// ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    var size = AppSizes.instance;

    return BlocListener<CreateProductCubit, CreateProductState>(
      listener: (context, state) {
        if (state is CreateProductLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(
              child: AppLoader(),
            ),
          );
        }

        if (state is CreateProductSuccess) {
          Navigator.pop(context);

          _showMessage(state.message);

          Navigator.pop(context);
        }

        if (state is UpdateProductSuccess) {
          Navigator.pop(context);

          _showMessage(AppLocalizations.of(context).translate(state.message));

          Navigator.pop(context,state.updateProductEntity);
        }
        if (state is CreateProductError) {
          Navigator.pop(context);

          _showMessage(state.error);
          Navigator.pop(context);


        }
      },

      child: Scaffold(
        backgroundColor: AppColors.primaryLight,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.padding.screenHorizontal,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ========== APP BAR ==========

                Padding(
                  padding: EdgeInsets.only(
                      top: size.padding.screenVertical),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AppBackButton(),
                      Text(
                          widget.product == null ? AppLocalizations.of(context).translate("add_item")
                  : AppLocalizations.of(context).translate("edit_item"),
                        style: AppTextStyles.dosisExtraBold32(),
                      ),
                    ],
                  ),
                ),
                // ========== STEP INDICATOR ==========
                SizedBox(height: size.spacing.medium),

                StepIndicator(
                  currentStep: currentStep,
                  totalSteps: steps.length,
                ),

                SizedBox(height: size.spacing.medium),
                // ========== STEP PAGE ==========

                Expanded(
                  child: steps[currentStep],
                ),
                // ========== BUTTON ==========

                Padding(
                  padding: EdgeInsets.only(
                    bottom: size.padding.navVertical,
                  ),
                  child: BlocBuilder<CreateProductCubit, CreateProductState>(
                    builder: (context, state) {
                      final isLoading = state is CreateProductLoading;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (currentStep > 0)
                            AppButton(
                              onPressed: isLoading ? null : previousStep,
                              type: AppButtonType.text,
                              fullWidth: false,
                              width: size.buttons.smallWidth,
                              height: size.buttons.smallHeight,
                              title: AppLocalizations.of(context).translate("back"),
                              textButtonVariant: TextButtonVariant.back,
                            ),
                          SizedBox(width: size.spacing.small,),
                          AppButton(
                            onPressed: isLoading
                                ? null
                                : () {
                              final cubit = context.read<CreateProductCubit>();

                              if (currentStep ==
                                  steps.length - 1) {
                                if (!validateStep4(cubit.formState)) return;

                                context
                                    .read<CreateProductCubit>()
                                    .submit();
                              } else {
                                nextStep();
                              }
                            },
                            type: AppButtonType.text,
                            fullWidth: false,
                            width: size.buttons.smallWidth,
                            height: size.buttons.smallHeight,
                            textButtonVariant:
                            TextButtonVariant.next,
                            title: currentStep ==
                                steps.length - 1
                                ? (widget.product == null ? AppLocalizations.of(context).translate("publish")
                                : AppLocalizations.of(context).translate("update"))
                                :  AppLocalizations.of(context).translate("next"),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}