import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/di/service_locator.dart';
import 'package:roasters/core/network/network_cubit.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/features/home/presentation/pages/main_page.dart';
import 'package:roasters/features/profile/presentation/cubit/cubit_languages.dart';
import 'package:roasters/features/shared_types_provinces/presentation/cubit/cubit.dart';
import 'package:roasters/features/splash/presentation/page/splash_page.dart';
import 'package:roasters/shared/widgets/buttons/app_back_button.dart';
import 'package:roasters/shared/widgets/buttons/app_button.dart';
import 'package:roasters/shared/widgets/inputs/app_search_field.dart';
import 'package:roasters/shared/widgets/inputs/app_text_field.dart';
import 'package:roasters/shared/widgets/inputs/auth_switch_text.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:flutter_localizations/flutter_localizations.dart';
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  timeago.setLocaleMessages('en', timeago.EnMessages());

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>(
          create: (_) => sl<LanguageCubit>(),
        ),

        BlocProvider<NetworkCubit>(
          create: (_) => sl<NetworkCubit>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      builder: (context, child) {
        AppSizes.init();
        AppSizes.instance.initSizes();

        return BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: state.locale, // اللغة الحالية
              supportedLocales: const [
                Locale('en'),
                Locale('ar'),
              ],
              localizationsDelegates:  [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: SplashPage(),
            );
          },
        );
      },
    );
  }
}
