import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SplashLogo extends StatelessWidget {
  final String text;

  const SplashLogo({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: AppTextStyles.dosisExtraBold32()),
      textDirection: TextDirection.ltr,
    )..layout();

    final circleDiameter = textPainter.width * 1.5;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: circleDiameter,
          height: circleDiameter,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
        Text(
          text,
          style: AppTextStyles.dosisExtraBold32()
        ),
      ],
    );
  }
}