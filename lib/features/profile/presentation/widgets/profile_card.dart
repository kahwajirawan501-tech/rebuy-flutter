import 'package:flutter/material.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String description;
  final VoidCallback? onTap;

  const ProfileCard( {super.key,
    required this.title, required this.icon, required this.description,this.onTap});

  @override
  Widget build(BuildContext context) {
    var size=AppSizes.instance;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: AppColors.secondaryLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size.borderRadius.extraLarge),
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical:size.padding.cardVertical,horizontal:size.padding.cardHorizontal ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Icon( icon
              ,color:AppColors.icon,size: size.icons.large,),
              SizedBox(width: size.spacing.small,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                      style: AppTextStyles.firaMedium18(color: AppColors.textPrimaryDark),),
                    SizedBox(height: size.spacing.tiny,),
                    Text(description,style: AppTextStyles.firaMedium14(),),


                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
