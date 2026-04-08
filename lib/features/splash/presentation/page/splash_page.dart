import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/core/di/service_locator.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import 'package:roasters/features/auth/presentation/pages/login_page.dart';
import 'package:roasters/features/auth/presentation/pages/signup_page.dart';
import 'package:roasters/features/home/presentation/pages/main_page.dart';
import 'package:roasters/features/search/presentation/cubit/cubit.dart';
import 'package:roasters/features/shared_types_provinces/presentation/cubit/cubit.dart';
import 'package:roasters/features/splash/presentation/cubit/cubit.dart';
import 'package:roasters/features/splash/presentation/cubit/states.dart';
import 'package:roasters/features/splash/presentation/widgets/widgets.dart';
import '../../../../core/theme/app_colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sharedCubit = sl<SharedCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      sharedCubit.loadSharedData(forceRefresh: true);
    });

    return BlocProvider(
      create:  (_) => sl<SplashCubit>()..start(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      HomePage()),
            );
          } else if (state is SplashUnauthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => LoginPage()),
            );
          }
        },
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
            child:  Center(
              child: SplashLogo(text:  AppLocalizations.of(context).translate("rebuy"),),
            ),
          ),
        ),
      ),
    );
  }
}