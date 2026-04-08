import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import 'package:roasters/core/network/network_cubit.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';

class NetworkOverlay extends StatelessWidget {
  const NetworkOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkCubit, bool>(
      builder: (context, isConnected) {
        final size = AppSizes.instance;
        final local = AppLocalizations.of(context);

        if (isConnected) return const SizedBox.shrink();
        return Stack(
          children: [
            // خلفية مظللة
            Opacity(
              opacity: 0.8,
              child: ModalBarrier(
                dismissible: false,
                  color: AppColors.primaryLight
              ),
            ),

            // محتوى Overlay
            Center(
              child: Container(
                padding:  EdgeInsets.symmetric(horizontal: size.padding.screenHorizontal,
                vertical: size.padding.screenVertical),
                margin:  EdgeInsets.symmetric(horizontal: size.padding.screenHorizontal,),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusGeometry.circular(size.borderRadius.extraLarge),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.wifi_off,
                      color: AppColors.primaryDark,
                      size: size.icons.extraLarge,
                    ),
                     SizedBox(height: size.spacing.medium),
                    Text(
                      local.translate("network_overlay_no_connection"),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.firaBold24(color: AppColors.lineDark),
                    ),
                    SizedBox(height: size.spacing.small),
                    Text(
                      local.translate("network_overlay_check_connection"),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.firaBold18(color: AppColors.text),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}