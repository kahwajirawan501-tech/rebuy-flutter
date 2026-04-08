import 'package:flutter/material.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    var size=AppSizes.instance;
    return Row(
      children: [
         Expanded(child: Divider(color:AppColors.divider ,)),

        Padding(
          padding:  EdgeInsets.symmetric(horizontal: size.padding.authHorizontal),
          child: Text(
    AppLocalizations.of(context).translate("or"),
            style: AppTextStyles.caption(),
          ),
        ),

         Expanded(child: Divider(color: AppColors.divider,)),
      ],
    );
  }
}