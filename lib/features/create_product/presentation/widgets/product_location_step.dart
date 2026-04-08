import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';
import 'package:roasters/features/create_product/presentation/cubit/cubit.dart';
import 'package:roasters/shared/widgets/inputs/app_text_field.dart';
import 'package:roasters/features/shared_types_provinces/presentation/cubit/cubit.dart';
import 'package:roasters/features/shared_types_provinces/presentation/cubit/state.dart';
import 'package:roasters/shared/widgets/loaders/app_loader.dart';

class ProductLocationStep extends StatefulWidget {
  const ProductLocationStep({super.key});

  @override
  State<ProductLocationStep> createState() => _ProductLocationStepState();
}

class _ProductLocationStepState extends State<ProductLocationStep> {
  int? selectedProvinceId;
  late TextEditingController areaController;
  final size = AppSizes.instance;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CreateProductCubit>();
    selectedProvinceId = cubit.formState.provinceId;
    areaController = TextEditingController(text: cubit.formState.address);
  }

  @override
  void dispose() {
    areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.padding.fieldHorizontal),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<SharedCubit, SharedState>(
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
                  final provinces = state.provinces;

                  return AppTextField(
                    label:AppLocalizations.of(context).translate("select_city"),
                    readOnly: true,
                    suffix: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.padding.screenHorizontal,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          isExpanded: true,
                          dropdownColor: AppColors.backgroundSearchBox,
                          borderRadius: BorderRadius.circular(size.borderRadius.extraLarge),
                          value: selectedProvinceId,
                          hint: Text(
                            AppLocalizations.of(context).translate("select_city_hint"),
                            style: AppTextStyles.firaMedium16(color: AppColors.textPrimaryLight),
                          ),
                          items: provinces.map((province) {
                            return DropdownMenuItem<int>(
                              value: province.id,
                              child: Text(
                                province.name,
                                style: AppTextStyles.firaMedium16(color: AppColors.textPrimaryDark),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {

                              if (val != null) {
                                setState(() => selectedProvinceId = val);
                                context.read<CreateProductCubit>().setProvince(val);
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
            SizedBox(height: size.spacing.small),
            AppTextField(
              controller: areaController,
              label: AppLocalizations.of(context).translate("area"),
              hint:AppLocalizations.of(context).translate("area"),
              onChanged: (val) {
                context.read<CreateProductCubit>().setAddress(val);
              },
            ),
          ],
        ),
      ),
    );
  }
}