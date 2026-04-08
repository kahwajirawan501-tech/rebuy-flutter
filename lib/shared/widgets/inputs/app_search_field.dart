import 'package:flutter/material.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/theme/app_text_styles.dart';

class AppSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final ValueChanged<String>? onChanged;

  const AppSearchField({
    super.key,
    this.controller,
    this.hint,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final sizes = AppSizes.instance;

    return SizedBox(
      height: sizes.buttons.height,
      child: TextField(

        controller: controller,
        onChanged: onChanged,

        decoration: InputDecoration(
          hintText: hint ??  AppLocalizations.of(context).translate("search_"),
          hintStyle: AppTextStyles.firaMedium16(),
          suffixIcon: Icon(
            Icons.search,
            color: AppColors.icon,
            size: sizes.icons.medium,
          ),

          filled: true,
          fillColor: AppColors.backgroundSearchBox,



          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(sizes.borderRadius.extraLarge),
            borderSide: BorderSide.none,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(sizes.borderRadius.extraLarge),
            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(sizes.borderRadius.extraLarge),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}