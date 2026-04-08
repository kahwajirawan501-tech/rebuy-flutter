
import 'package:flutter/material.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/theme/app_text_styles.dart';
import '../../../core/theme/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final double? height;
  final IconData? prefixIcon;
  final Widget? suffix;

  final bool obscureText;
  final bool readOnly;
  final bool enabled;

  final TextInputType? keyboardType;

  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.prefixIcon,
    this.suffix,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.onTap,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    final sizes = AppSizes.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppTextStyles.firaBold16(color: AppColors.textPrimaryDark),
          ),
          SizedBox(height: sizes.spacing.small),
        ],

        SizedBox(
         height:height?? sizes.field.heightLarge,

          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            readOnly: readOnly,
            enabled: enabled,
            keyboardType: keyboardType,
            validator: validator,
            onChanged: onChanged,
            onTap: onTap,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.top,
            style: AppTextStyles.firaMedium16(color:AppColors.textPrimaryLight ),
            maxLines: height != null ? null :1,
            expands: height != null,

            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyles.firaMedium16(color:AppColors.textPrimaryLight ),

              prefixIcon: prefixIcon != null
                  ? Icon(
                prefixIcon,
                size: sizes.icons.medium,
                color: AppColors.textPrimaryDark,
              )
                  : null,

              suffixIcon: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 4),
                child: suffix,
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
        ),
      ],
    );
  }
}