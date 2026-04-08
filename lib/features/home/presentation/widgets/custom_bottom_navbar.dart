import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/di/service_locator.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/features/create_product/presentation/cubit/cubit.dart';
import 'package:roasters/features/create_product/presentation/pages/create_product_page.dart';
import 'package:roasters/features/shared_types_provinces/presentation/cubit/cubit.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = AppSizes.instance;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: size.padding.fieldHorizontal,
              vertical: size.padding.authVertical),
          height: size.navigationBar.height,
          decoration: BoxDecoration(
            color: AppColors.lineDark,
            borderRadius:
            BorderRadius.circular(size.borderRadius.extraExtraLarge),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildItem(Icons.search, 0),
              _buildItem(Icons.list, 1),
              SizedBox(width: 60.w),
              _buildItem(Icons.favorite, 3),
              _buildItem(Icons.person, 4),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<CreateProductCubit>(
                      create: (_) => sl<CreateProductCubit>(),
                    ),
                    BlocProvider.value(
                      value: sl<SharedCubit>(),
                    ),
                  ],
                  child: const CreateProductPage(),

              ),
            ));
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: size.padding.navHorizontal,vertical: size.padding.navVertical),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color:AppColors.lineDark,width: 7.h ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color:AppColors.iconLight,
                    blurRadius:5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),

              child: Icon(
                Icons.camera_alt_outlined,
                color: AppColors.lineDark,

              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItem(IconData icon, int index) {
    final isSelected = index == currentIndex;
    final size = AppSizes.instance;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: size.padding.fieldHorizontal,
            vertical: size.padding.fieldVertical-6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondary : Colors.transparent,
          borderRadius: BorderRadius.circular(size.borderRadius.extraExtraLarge),
        ),
        child: Icon(
          icon,
          color: AppColors.iconLight,
        ),
      ),
    );
  }
}