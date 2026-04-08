
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:roasters/core/constants/app_assets.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/constants/url_image.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import 'package:roasters/core/services/handle_contact_tap.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';
import 'package:roasters/core/utils/capitalize.dart';
import 'package:roasters/features/search/domain/entities/contact_search_entity.dart';
import 'package:roasters/features/search/domain/entities/product_details_entity.dart';
import 'package:roasters/features/search/domain/entities/product_search_entity.dart';
import 'package:roasters/shared/widgets/buttons/app_back_button.dart';
import 'package:roasters/shared/widgets/buttons/app_button.dart';
import 'package:roasters/shared/widgets/loaders/app_loader.dart';

class ProductDetails extends StatefulWidget {
  final ProductDetailsEntity product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var size=AppSizes.instance;
  int currentIndex = 0;
  final PageController _controller = PageController();



  @override
  Widget build(BuildContext context) {

    final locale = Localizations.localeOf(context).languageCode;
    String price = NumberFormat("#,##0.##", locale == 'ar' ? 'ar' : 'en')
        .format(widget.product.price!.price);

    if (locale == 'ar') {
      price = toArabicNumbers(price);
    }
    return Scaffold(
      backgroundColor: AppColors.primaryLight,

      body: SafeArea(

        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal:size.padding.screenHorizontal
              ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(top:size.padding.screenVertical),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      AppBackButton(),
                      Text(
                        AppLocalizations.of(context).translate("rebuy"),
                        style: AppTextStyles.dosisExtraBold32(),
                        overflow: TextOverflow.ellipsis, // إذا ضاق المكان يختصر النص
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.spacing.medium,),

                Stack(
                  children: [
                    SizedBox(
                      height: size.productImage.height-50,
                      child: PageView.builder(

                        controller: _controller,
                        itemCount: widget.product.images.length,
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Image.network(
                            url + widget.product.images[index],
                            width: double.infinity,
                            fit: BoxFit.contain,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return AppLoader();
                            },
                            errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          widget.product.images.length,
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
                SizedBox(height: size.spacing.medium,),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(20),

                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context).translate("search_page_description"),
                          style: AppTextStyles.firaMedium18(
                              color: AppColors.textPrimaryDark)),
                      SizedBox(height: size.spacing.small,),

                      Text(widget.product.description,
                          style: AppTextStyles.firaMedium16()),

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
                                    "${widget.product.location} ${widget.product.addressText}",
                                    style: AppTextStyles.firaMedium16(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          if (widget.product.price != null) ...[


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
            .translate(widget.product.price!.type),
        style: AppTextStyles.firaMedium14(
          color: AppColors.secondary,
        ),
      ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: size.spacing.medium,),


                      Divider(),

                      Column(
                        children: widget.product.contacts.map((contact) {
                          return _buildContactRow(contact,size.icons.small,size.borderRadius.small);
                        }).toList(),
                      ),

                      Divider(),


                    ],
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
Widget _buildContactRow(ContactSearchEntity contact,sizeIcon,borderRadius,) {
  String imagePath;
  Color color;
  switch (contact.type) {
    case "whatsapp": imagePath = AppAssets.whatsapp;
    color = Colors.green; break;
    case "call": imagePath = AppAssets.phone;
    color = Colors.blue; break;
    default: imagePath = AppAssets.phone; color = Colors.grey; }

  return InkWell(
    onTap: () => handleContactTap(contact),
    borderRadius: BorderRadius.circular(borderRadius),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [

      CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
      child: Image.asset( imagePath, width: sizeIcon, height: sizeIcon, )),

           SizedBox(width: 12),

          Expanded(
            child: Text(
              contact.number,
              style: AppTextStyles.firaMedium16(),
            ),
          ),


          Icon(
            Icons.arrow_forward_ios,
            size: sizeIcon,
            color: Colors.grey,
          ),
        ],
      ),
    ),
  );
}