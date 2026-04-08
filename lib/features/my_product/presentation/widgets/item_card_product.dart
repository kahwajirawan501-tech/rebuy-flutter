import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/constants/url_image.dart';
import 'package:roasters/core/di/service_locator.dart';
import 'package:roasters/core/localization/app_localizations.dart' show AppLocalizations;
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';
import 'package:roasters/core/services/options_menu_delete_edit.dart';
import 'package:roasters/core/utils/capitalize.dart';
import 'package:roasters/features/create_product/presentation/cubit/cubit.dart';
import 'package:roasters/features/create_product/presentation/pages/create_product_page.dart';
import 'package:roasters/features/my_product/domain/entities/product_my_product_entity.dart';
import 'package:roasters/features/my_product/presentation/cubit/cubit.dart';
import 'package:roasters/features/shared_types_provinces/presentation/cubit/cubit.dart';

class ItemCardProduct extends StatelessWidget {
  final ProductMyProductEntity product;

  const ItemCardProduct({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    var size = AppSizes.instance;
    final locale = Localizations.localeOf(context).languageCode;
    String price = NumberFormat("#,##0.##", locale == 'ar' ? 'ar' : 'en')
        .format(product.price!.price);

    if (locale == 'ar') {
      price = toArabicNumbers(price);
    }
    String formattedDate = DateFormat('yyyy-MM-dd').format(product.createdAt);

    if (locale == 'ar') {
      formattedDate = toArabicNumbers(formattedDate);
    }
    final imageUrl = product.images.isNotEmpty
        ? url + (product.images.first.imageUrl ?? '')
        : "https://via.placeholder.com/150";

    return Stack(
      children: [
        Card(
          elevation: 0,
          color: AppColors.secondaryLight,
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(size.borderRadius.large),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: size.padding.cardVertical,
              horizontal: size.padding.cardHorizontal,
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ///  IMAGE
                  SizedBox(
                    height: size.productImage.heightSmall - 150,
                    width: size.productImage.widthSmall - 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          size.borderRadius.large),
                      child: Image.network(
                        imageUrl,
                        width: size.productImage.widthSmall,

                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(width: size.spacing.medium),

                  ///  INFO
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        /// 📝 DESCRIPTION
                        Text(
                          product.description.isNotEmpty
                              ? product.description
                              : AppLocalizations.of(context).translate("no_description"),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.firaBold16(
                            color: AppColors.textPrimaryDark,
                          ),
                        ),

                        SizedBox(height: size.spacing.small),

                        ///  PRICE
                        Row(
                          children: [
                            Text(
                              price,
                              style: AppTextStyles.firaMedium16(
                                color: AppColors.secondary,
                              ),
                            ),
                            SizedBox(width: size.spacing.tiny),
                            Text(
                              AppLocalizations.of(context)
                                  .translate(product.price!.type),
                              style: AppTextStyles.firaMedium14(
                                color: AppColors.secondary,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: size.spacing.small),

                        ///  LOCATION + TYPE
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                size: size.icons.small,
                                color: AppColors.textSecondary),
                            SizedBox(width: size.spacing.tiny),
                            Expanded(
                              child: Text(
                                product.province.name,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.firaMedium14(),
                              ),
                            ),

                            SizedBox(width:  size.spacing.small),

                            Icon(Icons.category,
                                size: size.icons.small,
                                color: AppColors.textSecondary),
                            SizedBox(width:  size.spacing.tiny),
                            Text(
                              product.type.name ,
                              style: AppTextStyles.firaMedium14(),
                            ),
                          ],
                        ),

                        SizedBox(height: size.spacing.small),
                        /// 📅 CREATE DATE
                        Row(
                          children: [
                            Icon(Icons.access_time,
                                size: size.icons.small,
                                color: AppColors.textSecondary),
                            SizedBox(width: size.spacing.tiny),
                            Expanded(
                              child: Text(
                                formattedDate,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.firaMedium14(),
                              ),
                            ),

                          ],
                        ),

                        /// STATUS
                        Row(
                          children: [
                            Spacer(),

                            Text(
                              product.isSold ?    AppLocalizations.of(context).translate("sold")
                    : AppLocalizations.of(context).translate("available"),
                              style: AppTextStyles.firaMedium14(
                                color: product.isSold
                                    ? AppColors.secondary
                                    : AppColors.primary,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                              child: Switch(
                                value: !product.isSold, // ✅ عكس القيمة
                                onChanged: (value) {
                                  // هنا نرسل القيمة الصحيحة للمخزن
                                  context.read<MyProductCubit>().updateIsSold(
                                    product.id,
                                    !value, // ✅ عكسها قبل الإرسال
                                  );
                                },
                                thumbColor: MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return AppColors.primary; // لون المتوفر
                                  }
                                  return AppColors.secondary;   // لون المباعة
                                }),
                                trackColor: MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return AppColors.primary.withOpacity(0.3);
                                  }
                                  return AppColors.secondary.withOpacity(0.2);
                                }),
                              ),
                            ),
                          ],
                        )


                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        /// ⋮ OPTIONS BUTTON (EDIT / DELETE)
        Align(
          alignment:   AlignmentDirectional.topEnd,
          child: IconButton(
            onPressed: () {
              OptionsBottomSheet(
                context: context,
                isImage: false,
                showEdit: true,
                showDelete: true,
                onEdit: () async{

                  final updatedProduct = await   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MultiBlocProvider(
                          providers: [
                            BlocProvider.value(value: sl<SharedCubit>()),
                            BlocProvider(create: (_) => sl<CreateProductCubit>()),
                          ],
                          child: CreateProductPage(product: product),
                        ),
                      ),
                    );
                  if (context.mounted && updatedProduct != null) {
                    context.read<MyProductCubit>().updateProduct(updatedProduct);
                  }
                },
                onDelete: () {
                  BlocProvider.of<MyProductCubit>(context).removeProduct(product.id);

                },
              ).show();
            },
            icon: Icon(
              Icons.more_vert,
              color: AppColors.icon,
              size: size.icons.medium,
            ),
          ),
        ),
      ],
    );
  }
}