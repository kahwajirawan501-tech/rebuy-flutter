import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/core/di/service_locator.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/features/create_product/presentation/pages/create_product_page.dart';
import 'package:roasters/features/home/presentation/widgets/custom_bottom_navbar.dart';
import 'package:roasters/features/my_favorits/presentation/cubit/cubit.dart';
import 'package:roasters/features/my_favorits/presentation/pages/favorit_page.dart';
import 'package:roasters/features/my_product/presentation/cubit/cubit.dart';
import 'package:roasters/features/my_product/presentation/page/my_product_page.dart';
import 'package:roasters/features/profile/presentation/cubit/cubit.dart';
import 'package:roasters/features/profile/presentation/pages/profile_page.dart';
import 'package:roasters/features/search/presentation/cubit/cubit.dart';
import 'package:roasters/features/search/presentation/pages/search_page.dart';
import 'package:roasters/features/shared_types_provinces/presentation/cubit/cubit.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;


  final pages = [];


  @override
  Widget build(BuildContext context) {


    final pages = [
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: sl<SharedCubit>()),
          BlocProvider(create: (_) => sl<SearchCubit>()),
        ],
        child: const SearchPage(),
      ),
      MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<MyProductCubit>()),

          ],
          child: MyProductPage()),
      CreateProductPage(),
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<FavoriteCubit>()),

        ],
          child: FavoritePage()),
      MultiBlocProvider(
          providers: [
            BlocProvider.value(value: sl<SharedCubit>()),
            BlocProvider(create: (_) => sl<ProfileCubit>()),

          ],
          child: ProfilePage()),
    ];

    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: pages[currentIndex],

      bottomNavigationBar: CustomBottomNavBar(

        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}