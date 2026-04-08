import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';
import 'package:roasters/features/auth/presentation/pages/login_page.dart';
import 'package:roasters/features/profile/presentation/cubit/cubit.dart';
import 'package:roasters/features/profile/presentation/cubit/state.dart';
import 'package:roasters/features/profile/presentation/pages/change_password_page.dart';
import 'package:roasters/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:roasters/features/profile/presentation/pages/setting_page.dart';
import 'package:roasters/features/profile/presentation/widgets/profile_card.dart';
import 'package:roasters/features/shared_types_provinces/presentation/cubit/cubit.dart';
import 'package:roasters/shared/widgets/loaders/app_loader.dart';
import 'package:roasters/shared/widgets/toast/toast_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    var size = AppSizes.instance;
    final cubit = context.read<ProfileCubit>();
    final listProfile = [
      {
        "title": AppLocalizations.of(context).translate("profile_page_my_account"),
        "icon": Icons.person,
        "description": AppLocalizations.of(context).translate("profile_page_edit_details"),
        "builder": (context) => EditProfilePage(cubit.authLocalDataSource)
      },
      {
        "title": AppLocalizations.of(context).translate("profile_page_languages"),
        "icon": Icons.language,
        "description": AppLocalizations.of(context).translate("profile_page_select_language"),
        "builder": (context) => ChangeLanguagePage()
      },
      {
        "title": AppLocalizations.of(context).translate("profile_page_change_password"),
        "icon": Icons.password,
        "description": AppLocalizations.of(context).translate("profile_page_update_password"),
        "builder": (context) => ChangePasswordPage()
      },
      {
        "title": AppLocalizations.of(context).translate("profile_page_sign_out"),
        "icon": Icons.logout,
        "description": AppLocalizations.of(context).translate("profile_page_sign_out"),
      }
    ];
    return Scaffold(
      backgroundColor: AppColors.primaryLight,

      body: SafeArea(

        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.padding.screenHorizontal,

          ),

          child: Column(
            children: [

              /// Title
              Padding(
          padding:  EdgeInsets.only(top:size.padding.screenVertical),

                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context).translate("rebuy"),
                      style: AppTextStyles.dosisExtraBold32(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.spacing.medium,),

              /// Profile list
              BlocListener<ProfileCubit,ProfileState>(
                listener: (context, state) {
                  if (state is ProfileSignOutLoading) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => const AppLoader(),
                    );
                  }

                  if (state is ProfileSignOutSuccess) {
                    Navigator.pop(context);
                 showToast( text: AppLocalizations.of(context).translate(state.message),
                   state: ToastStates.SUCCESS);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => LoginPage()),
                          (route) => false,
                    );
                  }

                  if (state is ProfileSignOutError) {
                    Navigator.pop(context);

                    showToast(text: AppLocalizations.of(context).translate(state.message), state: ToastStates.SUCCESS);

                  }
                },

                child: BlocBuilder<ProfileCubit,ProfileState>(
                  builder:(context, state) {
                    return  Expanded(
                      child: ListView.separated(

                        itemCount: listProfile.length,

                        separatorBuilder: (context, index) =>
                            SizedBox(height: size.spacing.small),

                        itemBuilder: (context, index) {

                          final item = listProfile[index];

                          return  ProfileCard(
                            title: item["title"] as String,
                            icon: item["icon"] as IconData,
                            description: item["description"] as String,
                            onTap: () {
                              if (item["title"] == AppLocalizations.of(context).translate("profile_page_sign_out")) {
                                context.read<ProfileCubit>().signOut();

                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MultiBlocProvider(
                                      providers: [
                                        BlocProvider.value(value: context.read<ProfileCubit>()),
                                        BlocProvider.value(value: context.read<SharedCubit>()), // 👈 المهم
                                      ],
                                      child: (item["builder"] as WidgetBuilder)(context),
                                    ),
                                  ),
                                );
                              }
                            },
                          );

                        },
                      ),
                    );
                  },

                ),
              ),
            //  SizedBox(height: size.spacing.extraExtraLarge),

              // Row(
              //   children: [
              //     Expanded(
              //       child: AppButton(onPressed: () {
              //
              //
              //         },
              //       secondaryVariant: SecondaryButtonVariant.light,
              //         type: AppButtonType.secondary,
              //         height: size.buttons.buttonSecundHeight,
              //         title: "Feedback",
              //       ),
              //     ),
              //     SizedBox(width: size.spacing.small,),
              //     Expanded(
              //       child: AppButton(onPressed: () {
              //
              //
              //       },
              //         secondaryVariant: SecondaryButtonVariant.dark,
              //         type: AppButtonType.secondary,
              //         height: size.buttons.buttonSecundHeight,
              //         title: "Sign Out",
              //       ),
              //     )
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}