import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';
import 'package:roasters/features/shared_types_provinces/presentation/cubit/cubit.dart';
import 'package:roasters/features/shared_types_provinces/presentation/cubit/state.dart';
import 'package:roasters/shared/widgets/buttons/app_button.dart';
import 'package:roasters/shared/widgets/inputs/app_text_field.dart';
import 'package:roasters/shared/widgets/loaders/app_loader.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {

  final size = AppSizes.instance;

  int? selectedProvinceId;




  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(size.spacing.medium),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),

      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: EdgeInsets.only(bottom: size.spacing.small),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            /// title
            Center(
              child: Text(
                "Filter",
                style: AppTextStyles.firaMedium24(),
              ),
            ),

            SizedBox(height: size.spacing.extraLarge),

            /// PROVINCE
            BlocListener(
              listener: (context, state) {
                if (state is SharedLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const Center(
                      child: AppLoader(),
                    ),
                  );
                }
              },
              child: BlocBuilder<SharedCubit, SharedState>(
                builder: (context, state) {


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
                      label: "Select City",
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
                              "Select city",
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
                              setState(() {
                                selectedProvinceId=val;
                              });

                            },
                          ),
                        ),
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),


            SizedBox(height: size.spacing.extraExtraLarge),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                  AppButton(
                    onPressed: () {
                      Navigator.pop(context);

                    },
                    type: AppButtonType.text,
                    fullWidth: false,
                    width: size.buttons.smallWidth,
                    height: size.buttons.smallHeight,
                    title: "Reset",
                    textButtonVariant: TextButtonVariant.back,
                  ),
                SizedBox(width: size.spacing.small,),
                AppButton(
                  onPressed:() {
                    Navigator.pop(context);

                  },
                  type: AppButtonType.text,
                  fullWidth: false,
                  width: size.buttons.smallWidth,
                  height: size.buttons.smallHeight,
                  textButtonVariant:
                  TextButtonVariant.next,
                  title: "Apply",
                ),
              ],
            ),




          ],
        ),
      ),
    );
  }
}