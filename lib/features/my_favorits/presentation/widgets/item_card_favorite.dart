import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/constants/url_image.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';
import 'package:roasters/core/utils/capitalize.dart';
import 'package:roasters/features/my_favorits/domain/entities/favorite_to_details.dart';
import 'package:roasters/features/my_favorits/domain/entities/product_favorite_entity.dart';
import 'package:roasters/features/my_favorits/presentation/cubit/cubit.dart';
import 'package:roasters/features/search/presentation/pages/product_details.dart';
import 'package:roasters/shared/widgets/buttons/app_button.dart';

class ItemCard extends StatelessWidget {
  final ProductFavoriteEntity product;

  const ItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    var size = AppSizes.instance;
    final locale = Localizations.localeOf(context).languageCode;
    String price = NumberFormat("#,##0.##", locale == 'ar' ? 'ar' : 'en')
        .format(product.price!.price);

    if (locale == 'ar') {
      price = toArabicNumbers(price);
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
            borderRadius: BorderRadius.circular(size.borderRadius.large),
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
                    height: size.productImage.heightSmall-150,

                    width: size.productImage.widthSmall-10,
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.circular(size.borderRadius.large),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///  DESCRIPTION
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

                        ///  SELLER + STATUS
                        Row(
                          children: [
                            Icon(Icons.person,
                                size: size.icons.small,
                                color: AppColors.textSecondary),
                            SizedBox(width:  size.spacing.tiny),
                            Expanded(
                              child: Text(
                                product.user.name ?? AppLocalizations.of(context).translate("unknown_seller"),
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.firaMedium14(),
                              ),
                            ),

                            // /// STATUS
                            // Container(
                            //   padding: EdgeInsets.symmetric(
                            //     horizontal: size.spacing.small,
                            //     vertical: size.spacing.tiny,),
                            //   decoration: BoxDecoration(
                            //     color: product.isSold
                            //         ? AppColors.secondary.withOpacity(0.1)
                            //         : AppColors.primary.withOpacity(0.1),
                            //     borderRadius: BorderRadius.circular(size.borderRadius.small),
                            //   ),
                            //   child: Text(
                            //     product.isSold  ? AppLocalizations.of(context).translate("sold")
                            //         : AppLocalizations.of(context).translate("available"),
                            //     style: AppTextStyles.firaMedium14(color: product.isSold
                            //         ? AppColors.secondary
                            //         : AppColors.primary,)
                            //   ),
                            // ),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [

                            AppButton(

                              onPressed:!product.isSold
                ? () {
          Navigator.push(
          context,
          MaterialPageRoute(
          builder: (_) => ProductDetails(product: product.toDetailsEntity()),
          ),
          );
          }
              : null,
                              type: AppButtonType.text,
                              fullWidth: false,
                              width: size.buttons.smallWidth-8,
                              height: size.buttons.smallHeight-8,
                              title:!product.isSold?AppLocalizations.of(context).translate("search_page_see_more")
                                  :AppLocalizations.of(context).translate("search_page_sold"),
                            ),

                            SizedBox(width: size.spacing.tiny),

                            Icon(
                              Icons.arrow_forward_ios,
                              size: size.icons.small,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
        ///  FAVORITE BUTTON
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment:   AlignmentDirectional.topEnd,
            child: GestureDetector(
              onTap: () {
                context
                    .read<FavoriteCubit>()
                    .toggleFavorite(product.id);
              },
              child: Container(
                margin: EdgeInsets.only(left: size.spacing.small),
                decoration: BoxDecoration(
                  color: AppColors.primaryDark.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(8),
                child: Icon(
                  product.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: AppColors.primaryDark,
                  size: size.icons.medium,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}