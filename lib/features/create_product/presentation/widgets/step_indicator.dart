import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/theme/app_colors.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    var size=AppSizes.instance;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        bool isActive = index <= currentStep;
        bool isNext=index<currentStep;
        return Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: size.stepIndicator.widthLarge,
                  height: size.stepIndicator.heightLarge,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:isNext? AppColors.primaryDark:Colors.transparent,
                    border:Border.all(
                      color: isActive
                          ? AppColors.primaryDark
                          : AppColors.line,
                      width: 2,
                    ),
                  ),
                ),
                Container(
                  width: size.stepIndicator.widthSmall,
                  height: size.stepIndicator.heightSmall,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive
                        ? AppColors.primaryDark
                        : AppColors.line,
                  ),
                ),
              ],
            ),
            if (index != totalSteps - 1)
              Container(
                width: size.stepIndicator.widthLine,
                height: 3.h,
                color: isActive
                    ? AppColors.primaryDark
                    : AppColors.line,
              ),
          ],
        );
      }),
    );
  }
}