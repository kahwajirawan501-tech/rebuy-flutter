import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';
import 'package:roasters/core/utils/validators.dart';
import 'package:roasters/features/profile/presentation/cubit/cubit.dart';
import 'package:roasters/features/profile/presentation/cubit/state.dart';
import 'package:roasters/shared/widgets/buttons/app_back_button.dart';
import 'package:roasters/shared/widgets/buttons/app_button.dart';
import 'package:roasters/shared/widgets/inputs/app_text_field.dart';
import 'package:roasters/shared/widgets/loaders/app_loader.dart';
import 'package:roasters/shared/widgets/toast/toast_widget.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final passwordNewController = TextEditingController();
  final passwordOldController = TextEditingController();
  @override
  void dispose() {
    passwordNewController.dispose();
    passwordOldController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var size=AppSizes.instance;
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: SafeArea(

        child: Padding(
          padding:  EdgeInsets.symmetric(
              horizontal:size.padding.screenHorizontal ),
          child: SingleChildScrollView(

            child: Form(
              key: _formKey,
              child: BlocListener<ProfileCubit,ProfileState>
                (
                listener: (context, state) {
                  if (state is ProfileChangePasswordLoading) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => AppLoader()
                    );

                  }
                  if(state is ProfileChangePasswordError)
                  {
                    Navigator.pop(context);

                    showToast(
                      text: AppLocalizations.of(context).translate(state.message),
                      state: ToastStates.SUCCESS,
                    );
                  }
                  if(state is ProfileChangePasswordSuccess)
                  {                    Navigator.pop(context);

                  showToast(
                    text: AppLocalizations.of(context).translate(state.message),
                    state: ToastStates.SUCCESS,
                  );                    Navigator.pop(context);
                  }

                },

                child: BlocBuilder<ProfileCubit,ProfileState>(
                  builder: (context, state) {
                    return  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///APPBAR
                        Padding(
                          padding:  EdgeInsets.only(top:size.padding.screenVertical),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              AppBackButton(),
                              Text(
                                AppLocalizations.of(context).translate("rebuy"),
                                style: AppTextStyles.dosisExtraBold32(),
                                overflow: TextOverflow.ellipsis, // إذا ضاق المكان يختصر النص
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.spacing.extraExtraLarge,),
                        ///TEXT CHANGE PASSWORD
                        Text(
                          AppLocalizations.of(context).translate("change_password_title"),
                          style: AppTextStyles.dosisExtraBold32(),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: size.spacing.medium,),
                        Text(  AppLocalizations.of(context).translate("change_password_description"),
                            style: AppTextStyles.firaMedium16(),),
                        SizedBox(height: size.spacing.extraLarge,),
                        ///OLD PASSWORD
                        AppTextField(
                          hint:  AppLocalizations.of(context).translate("old_password"),
                          controller:passwordOldController ,
                          keyboardType: TextInputType.text,
                          validator:  (value) =>AppValidators.password(value,context),

                        ),
                        SizedBox(height: size.spacing.medium,),
                        ///NEW PASSWORD
                        AppTextField(
                          hint:AppLocalizations.of(context).translate("new_password"),
                          controller: passwordNewController,
                          keyboardType: TextInputType.text,
                          validator: (value) => AppValidators.password(value,context),

                        ),
                        SizedBox(height: size.spacing.extraLarge,),

                        AppButton(onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<ProfileCubit>().changePassWord(
                              oldPassword: passwordOldController.text.trim(),
                              newPassword: passwordNewController.text.trim(),

                            );
                          }

                        },type: AppButtonType.primary,title:  AppLocalizations.of(context).translate("change_button"),),
                        SizedBox(height: size.spacing.extraLarge,),

                      ],
                    );
                  },

                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
