import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:roasters/core/constants/app_assets.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/constants/url_image.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';
import 'package:roasters/core/utils/capitalize.dart';
import 'package:roasters/features/search/data/models/province_search_model.dart';
import 'package:roasters/features/search/domain/entities/contact_search_entity.dart';
import 'package:roasters/features/search/domain/entities/image_search_entity.dart';
import 'package:roasters/features/search/domain/entities/price_search_entity.dart';
import 'package:roasters/features/search/domain/entities/product_details_entity.dart';
import 'package:roasters/features/search/domain/entities/product_search_entity.dart';
import 'package:roasters/features/search/domain/entities/seller_entity.dart';
import 'package:roasters/features/search/presentation/cubit/cubit.dart';
import 'package:roasters/features/search/presentation/pages/product_details.dart';
import 'package:roasters/shared/widgets/buttons/app_button.dart';import 'package:timeago/timeago.dart' as timeago;

class ProductItem extends StatefulWidget {
  final int id;
  final SellerEntity sellerName;
  final String? sellerProfileImage;
  final String productDescription;
  final PriceSearchEntity? productPrice;
  final List<ImageSearchEntity> imageUrls;
  final List<ContactSearchEntity>contact;
  final bool isSold;
  final bool isFavorite;
  final String province;
  final String addressText;
  final DateTime createdAt;

  const ProductItem({
    super.key,
    required this.sellerName, required this.sellerProfileImage, required this.productDescription,
     required this.imageUrls, required this.productPrice, required this.contact, required this.isSold, required this.province, required this.addressText, required this.createdAt, required this.isFavorite, required this.id,

  });

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int currentIndex = 0;
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final size = AppSizes.instance;
    String localeCode = Localizations.localeOf(context).languageCode;

    final locale = Localizations.localeOf(context).languageCode;
    String price = NumberFormat("#,##0.##", locale == 'ar' ? 'ar' : 'en')
        .format(widget.productPrice!.price);

    if (locale == 'ar') {
     price = toArabicNumbers(price);
    }


    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.spacing.small,),

        ListTile(
          leading: widget.sellerProfileImage == null
              ? Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.primaryGradient, // الحواف الملونة
            ),
            padding: const EdgeInsets.all(3),
            child: CircleAvatar(
              radius: size.borderRadius.extraLarge,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: size.icons.large,
                color: AppColors.primary,
              ),
            ),
          )
              : CircleAvatar(
            radius: size.borderRadius.extraLarge,
            backgroundImage: NetworkImage(url + widget.sellerProfileImage!),
          ),
          title: Text(widget.sellerName.name, style: AppTextStyles.firaMedium16(color: AppColors.textPrimaryDark)),
          subtitle: Text(
            timeago.format(widget.createdAt, locale: localeCode),
            style: AppTextStyles.firaMedium14(color: Colors.grey),
          ),
        ),
          SizedBox(height: size.spacing.small,),

          Stack(
            children: [
              SizedBox(
                height: size.productImage.heightSmall,
                child: widget.imageUrls.isNotEmpty
                    ? PageView.builder(
                  controller: _controller,
                  itemCount: widget.imageUrls.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final image = widget.imageUrls[index];

                    if (image.imageUrl.isEmpty) {
                      return Image.asset(
                        AppAssets.person, // حط صورة افتراضية
                        fit: BoxFit.contain,
                      );
                    }

                    return Image.network(
                      url + image.imageUrl,
                      width: double.infinity,
                      height: size.productImage.heightSmall,
                      fit: BoxFit.contain,
                    );
                  },
                )
                    : Image.asset(
                  AppAssets.person,
                  width: double.infinity,
                  height: size.productImage.heightSmall,
                  fit: BoxFit.contain,
                ),
              ),


              PositionedDirectional(
                bottom: 10,
                end: 10,
                child: GestureDetector(
                  onTap:() {
                    BlocProvider.of<SearchCubit>(context).toggleFavorite(widget.id);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryDark.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(6),
                    child: Icon(
                      widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: AppColors.primaryDark,
                      size: size.icons.large,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.imageUrls.length,
                        (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: currentIndex == index ? 10 : 6,
                      height: currentIndex == index ? 10 : 6,
                      decoration: BoxDecoration(
                        color: currentIndex == index
                            ? Colors.white
                            : Colors.white54,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(size.spacing.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context).translate("search_page_description"), style: AppTextStyles.firaMedium18(color: AppColors.textPrimaryDark)),
                SizedBox(height: size.spacing.small,),
                Text(widget.productDescription, style: AppTextStyles.firaMedium16()),
                SizedBox(height: size.spacing.medium,),
                Row(
                  children: [

                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.location_on,
                              size: size.icons.medium,
                              color: AppColors.textSecondary),
                          SizedBox(width: size.spacing.tiny),
                          SizedBox(width:size.spacing.tiny),
                          Expanded(
                            child: Text(
                              "${widget.province} ${widget.addressText}",
                              style: AppTextStyles.firaMedium16(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (widget.productPrice != null) ...[


                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(size.borderRadius.small),
                        ),
                        child: Row(
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
                                  .translate(widget.productPrice!.type),
                              style: AppTextStyles.firaMedium14(
                                color: AppColors.secondary,
                              ),
                            ),
                          ],
                        )
                      ),
                    ],
                  ],
                ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [

                AppButton(

                  onPressed: !widget.isSold?() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetails(product:
                        ProductDetailsEntity(
                            sellerName: widget.sellerName.name,
                            description: widget.productDescription,
                            images: widget.imageUrls.map((e)=>e.imageUrl).toList(),
                            contacts: widget.contact,
                            location: widget.province,
                            price: widget.productPrice,
                            addressText: widget.addressText,
                            isSold: widget.isSold)),
                      ),
                    );
                  }:(){

                  },
                  type: AppButtonType.text,
                  fullWidth: false,
                  width: size.buttons.smallWidth+15,
                  height: size.buttons.smallHeight+15,
                  title: !widget.isSold?AppLocalizations.of(context).translate("search_page_see_more")
                      :AppLocalizations.of(context).translate("search_page_sold"),
                ),
                SizedBox(width: size.spacing.small),
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
    );
  }
}