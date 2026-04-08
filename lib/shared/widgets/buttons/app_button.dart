import 'package:flutter/material.dart';
import 'package:roasters/core/constants/dimensions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../widgets/loaders/app_loader.dart';

enum AppButtonType {
  primary,
  secondary,
  social,
  text,
}
enum SecondaryButtonVariant {
  light,
  dark,
}
enum TextButtonVariant {
  back,
  next,
}
class AppButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final bool isLoading;
  final SecondaryButtonVariant? secondaryVariant;
  final Widget? prefix;
  final Widget? suffix;
  final TextButtonVariant? textButtonVariant;

  final bool fullWidth;
  final double? width;
  final double? height;

  const AppButton({
    super.key,
     this.title,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.isLoading = false,
    this.prefix,
    this.suffix,
    this.fullWidth = true,
    this.width,
    this.height,
    this.secondaryVariant, this.textButtonVariant,
  });

  @override
  Widget build(BuildContext context) {
    final sizes = AppSizes.instance;

    if (type == AppButtonType.text) {
      return SizedBox(
        width: fullWidth ? double.infinity : width,
        height: height ?? sizes.buttons.height,
        child: TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            foregroundColor: _defaultTextColor(),
            overlayColor: Colors.transparent, // بدون تأثير ضغط
          ),
          child: _content(sizes),
        ),
      );
    }

    // باقي الأنواع
    return SizedBox(
      width: fullWidth ? double.infinity : width,
      height: height ?? sizes.buttons.height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: _style(sizes),
        child: type == AppButtonType.primary
            ? _gradientButton(sizes)
            : _content(sizes),
      ),
    );
  }

  Widget _content(AppSizes sizes) {
    if (isLoading) {
      return const AppLoader();
    }
    if ((title == null || title!.isEmpty) &&
        (prefix != null || suffix != null)) {
      return Center(child: prefix ?? suffix!);

    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:type!=AppButtonType.text? MainAxisAlignment.center: MainAxisAlignment.start,
        children: [
          if (prefix != null) ...[
            prefix!,
            SizedBox(width: sizes.spacing.small),
          ],

          if (title != null && title!.isNotEmpty)
            Text(
              title!,
              style: AppTextStyles.button(
                color: _defaultTextColor(),
              ),
            ),

          if (suffix != null) ...[
            SizedBox(width: sizes.spacing.small),
            suffix!,
          ],

        ],
      ),
    );
  }

  ButtonStyle _style(AppSizes sizes) {
    final radius = BorderRadius.circular(sizes.borderRadius.extraLarge);

    switch (type) {
      case AppButtonType.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: radius,
          ),
        );

      case AppButtonType.secondary:
        if (secondaryVariant == SecondaryButtonVariant.dark) {
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.lineDark,
          side: BorderSide.none,
          padding: EdgeInsets.symmetric(
            horizontal: sizes.padding.authHorizontal,
            vertical: sizes.padding.authVertical,
          ),
          shape: RoundedRectangleBorder(borderRadius: radius),
        );

        }
        else{
          return ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            side: const BorderSide(color: AppColors.lineDark),
            padding: EdgeInsets.symmetric(
              horizontal: sizes.padding.authHorizontal,
              vertical: sizes.padding.authVertical,
            ),
            shape: RoundedRectangleBorder(borderRadius: radius),
          );
        }

      case AppButtonType.social:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.backgroundSearchBox,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(sizes.borderRadius.extraLarge),
          ),
        );


      case AppButtonType.text:
        return ElevatedButton.styleFrom(
          elevation: 0,

          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: radius),

        );
    }
  }
  Widget _gradientButton(AppSizes sizes) {
    return Ink(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(
          sizes.borderRadius.extraLarge,
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        child: _content(sizes),
      ),
    );
  }
  Color _defaultTextColor() {
    switch (type) {
      case AppButtonType.primary:
        return Colors.white;
      case AppButtonType.secondary:
        if(secondaryVariant==SecondaryButtonVariant.light){
          return AppColors.lineDark;

        }
        else{
          return Colors.white;

        }
      case AppButtonType.social:
        return AppColors.primaryDark;
      case AppButtonType.text:
        if(textButtonVariant==TextButtonVariant.next||textButtonVariant==null)
        {
          return AppColors.textSecondary;
        }
        else{
          return AppColors.textPrimaryDark;

        }
    }
  }
}
