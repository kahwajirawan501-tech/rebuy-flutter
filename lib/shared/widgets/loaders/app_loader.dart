import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roasters/core/constants/dimensions.dart';
import '../../../core/theme/app_colors.dart';

class AppLoader extends StatelessWidget {
  final double? size;       // حجم الدائرة
  final Color? color;      // لون الدائرة

  const AppLoader({
    super.key,
    this.size ,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final loaderSize = (size ?? AppSizes.instance.spacing.large).w;
    final loaderStroke = 3.w;

    return Center(
      child: SizedBox(
        width: loaderSize,
        height: loaderSize,
        child: CircularProgressIndicator(
          strokeWidth:loaderStroke,
          color: color ?? AppColors.primaryDark,
        ),
      ),
    );
  }
}
