import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/features/create_product/domain/entities/price_entity.dart';
import 'package:roasters/features/create_product/presentation/cubit/cubit.dart';
import 'package:roasters/shared/widgets/inputs/app_text_field.dart';

class ProductDescriptionStep extends StatefulWidget {
  const ProductDescriptionStep({super.key});

  @override
  State<ProductDescriptionStep> createState() => _ProductDescriptionStepState();
}

class _ProductDescriptionStepState extends State<ProductDescriptionStep> {
  final size = AppSizes.instance;

  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late String selectedCurrency;

  final List<String> currencies = ["USD", "SYP"];

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CreateProductCubit>();
    descriptionController = TextEditingController(text: cubit.formState.description);
    priceController = TextEditingController(
        text: cubit.formState.price?.price.toString() ?? "");
    selectedCurrency = cubit.formState.price?.type ?? "USD";
  }

  @override
  void dispose() {
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateProductCubit>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.padding.screenHorizontal),
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppTextField(
              controller: descriptionController,
              label: AppLocalizations.of(context).translate("description"),
              height: 200.h,
              hint: AppLocalizations.of(context).translate("description_hint"),
              onChanged: (val) => cubit.setDescription(val),
            ),
            SizedBox(height: size.spacing.small),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: AppTextField(
                    controller: priceController,
                    label:AppLocalizations.of(context).translate("price"),
                    keyboardType: TextInputType.number,
                    hint:  AppLocalizations.of(context).translate("price_hint"),
                    onChanged: (val) {
                      final price = double.tryParse(val);
                      if (price != null) {
                        cubit.setPrice(
                          PriceEntity(type: selectedCurrency, price: price),
                        );
                      }
                    },
                    suffix: DropdownButton<String>(
                      value: selectedCurrency,
                      underline: const SizedBox(),
                      dropdownColor: AppColors.backgroundSearchBox,
                      borderRadius: BorderRadius.circular(size.borderRadius.extraLarge),
                      items: currencies
                          .map((e) => DropdownMenuItem(
                        value: e,
                        child:  Text(
                          AppLocalizations.of(context).translate(e),
                        ),
                      ))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => selectedCurrency = val);
                          final price = double.tryParse(priceController.text);
                          if (price != null) {
                            cubit.setPrice(
                              PriceEntity(type: selectedCurrency, price: price),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}