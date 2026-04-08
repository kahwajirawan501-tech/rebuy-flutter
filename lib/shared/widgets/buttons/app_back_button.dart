import 'package:flutter/material.dart';
import 'package:roasters/core/constants/dimensions.dart';
import '../../../../core/theme/app_colors.dart';

class AppBackButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? iconColor;
  final VoidCallback? onPressed;

  const AppBackButton({
    super.key,
    this.backgroundColor,
    this.iconColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final sizes = AppSizes.instance;
    final radius = BorderRadius.circular(sizes.borderRadius.medium);

    return SizedBox(
      width: sizes.buttonsBack.width,
      height: sizes.buttonsBack.height,
      child: ElevatedButton(
        onPressed: onPressed ?? () => Navigator.of(context).pop(),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primaryLight,
          padding: EdgeInsets.zero,
          side: BorderSide(color: AppColors.lineDark),
          shape: RoundedRectangleBorder(
            borderRadius:radius,
          ),
          elevation: 0,
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back_ios,
            size: sizes.icons.small,
            color: iconColor ?? AppColors.lineDark,
          ),
        ),
      ),
    );
  }
}