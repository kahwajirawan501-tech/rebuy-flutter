import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';
import 'package:roasters/features/create_product/presentation/cubit/cubit.dart';
import 'package:roasters/features/shared_types_provinces/presentation/cubit/cubit.dart';
import 'package:roasters/features/shared_types_provinces/presentation/cubit/state.dart';
import 'package:roasters/shared/widgets/inputs/app_text_field.dart';
import 'package:roasters/shared/widgets/loaders/app_loader.dart';

class ProductTypeStep extends StatefulWidget {
  const ProductTypeStep({super.key});

  @override
  State<ProductTypeStep> createState() => _ProductTypeStepState();
}

class _ProductTypeStepState extends State<ProductTypeStep> {
  int? selectedTypeId;
  final size = AppSizes.instance;

  @override
  void initState() {
    super.initState();
    selectedTypeId = context.read<CreateProductCubit>().formState.typeId;
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.symmetric(horizontal: size.padding.screenHorizontal),
        child: BlocBuilder<SharedCubit, SharedState>(
          builder: (context, state) {
            if (state is SharedLoading) {
              return Center(
                child: AppLoader(),
              );

            }
            if (state is SharedError) {
              return Center(
                child: IconButton(
                  onPressed: () {
                    context.read<SharedCubit>().loadSharedData(forceRefresh: true);
                  },
                  icon: Icon(Icons.refresh),
                ),
              );
            }

            if (state is SharedLoaded) {
              final types = state.types;

              return AppTextField(
                label: AppLocalizations.of(context).translate("select_type"),
                readOnly: true,
                suffix: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.padding.screenHorizontal),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      isExpanded: true,
                      dropdownColor: AppColors.backgroundSearchBox,
                      borderRadius: BorderRadius.circular(size.borderRadius.extraLarge),
                      value:  types.any((e) => e.id == selectedTypeId) ? selectedTypeId : null,
                      hint: Text(
                        AppLocalizations.of(context).translate("select_type_hint"),
                        style: AppTextStyles.firaMedium16(color: AppColors.textPrimaryLight),
                      ),
                      items: types.map((type) {
                        return DropdownMenuItem<int>(
                          value: type.id,
                          child: Text(
                            type.name,
                            style: AppTextStyles.firaMedium16(color: AppColors.textPrimaryDark),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => selectedTypeId = val);
                          context.read<CreateProductCubit>().setType(val);
                        }
                      },
                    ),
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      );

  }
}