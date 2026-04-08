import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';
import 'package:roasters/core/di/service_locator.dart';
import 'package:roasters/features/profile/presentation/cubit/cubit_languages.dart';
import 'package:roasters/features/shared_types_provinces/data/repositories/shared_repository_impl.dart';
import 'package:roasters/features/shared_types_provinces/presentation/cubit/cubit.dart';
import 'package:roasters/shared/widgets/buttons/app_back_button.dart';
import 'package:roasters/shared/widgets/buttons/app_button.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({super.key});

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  final size = AppSizes.instance;

  // جلب LanguageCubit من Service Locator
  final LanguageCubit cubit = sl<LanguageCubit>();

  // قائمة اللغات (كود + اسم عرض)
  final List<String> languageCodes = ["en", "ar"];
  final List<String> languageNames = ["English", "العربية"];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.padding.screenHorizontal,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // رأس الصفحة
                Padding(
                  padding: EdgeInsets.only(top: size.padding.screenVertical),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppBackButton(),
                      Text(
                        AppLocalizations.of(context).translate("rebuy"),
                        style: AppTextStyles.dosisExtraBold32(),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.spacing.extraExtraLarge,),

                // عنوان اللغة
                Text(
                  AppLocalizations.of(context).translate("language"),
                  style: AppTextStyles.dosisExtraBold32(),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: size.spacing.medium),

                // شرح اختيار اللغة
                Text(
                  AppLocalizations.of(context).translate("select_language"),
                    style:AppTextStyles.firaMedium16()
                ),
                SizedBox(height: size.spacing.extraLarge),

                // قائمة اللغات
                SizedBox(
                  height: 200.h,
                  child: ListView.separated(
                    itemCount: languageCodes.length,
                    separatorBuilder: (_, __) => Divider(),
                    itemBuilder: (context, index) {
                      final code = languageCodes[index];
                      final name = languageNames[index];

                      return ListTile(
                        title: Text(
                          name,
                          style: AppTextStyles.firaMedium16(
                            color: cubit.state.locale.languageCode == code
                                ? AppColors.primaryDark
                                : AppColors.textPrimary,
                          ),
                        ),
                        trailing: cubit.state.locale.languageCode == code
                            ? Icon(Icons.check, color: AppColors.primary)
                            : null,
                        onTap: () {
                          cubit.changeLanguage(code);
                          sl<SharedRepositoryImpl>().clearCache();
                          sl<SharedCubit>().loadSharedData(forceRefresh: true);                          // تغيير اللغة
                        },
                      );
                    },
                  ),
                ),

                // // زر حفظ
                // AppButton(
                //   onPressed: () {
                //     Navigator.pop(context); // إغلاق الصفحة
                //   },
                //   type: AppButtonType.primary,
                //   title: AppLocalizations.of(context).translate("save"),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}