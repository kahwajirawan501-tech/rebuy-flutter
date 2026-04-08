import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';

class BoxTypeProduct extends StatelessWidget {
  final String text;
  final bool isSelected;
  const BoxTypeProduct({super.key, required this.text, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final size=AppSizes.instance;
    return  Container(
      height: size.buttons.smallHeight,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: size.padding.cardHorizontal,

      ),

      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.lineDark
            : AppColors.textType,
        borderRadius: BorderRadius.circular(
          size.borderRadius.extraLarge,
        ),
      ),

      child: Text(
        text,
        style: AppTextStyles.firaBold16(
          color: isSelected
              ? AppColors.textType
              : AppColors.lineDark,
        ),
      ),
    );
  }
}
