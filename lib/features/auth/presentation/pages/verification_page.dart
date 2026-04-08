import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/di/service_locator.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';
import 'package:roasters/features/auth/presentation/cubit/verification_cubit/cubit.dart';
import 'package:roasters/features/auth/presentation/cubit/verification_cubit/state.dart';
import 'package:roasters/features/home/presentation/pages/main_page.dart';
import 'package:roasters/shared/widgets/buttons/app_back_button.dart';
import 'package:roasters/shared/widgets/buttons/app_button.dart';
import 'package:roasters/shared/widgets/inputs/app_text_field.dart';
import 'package:roasters/shared/widgets/inputs/auth_switch_text.dart';
import 'package:roasters/shared/widgets/toast/toast_widget.dart';

class VerificationPage extends StatefulWidget {
  final String email;
  const VerificationPage({super.key, required this.email});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size=AppSizes.instance;

    return BlocProvider(
      create: (_) =>sl<VerificationCubit>() ,
      child: BlocListener<VerificationCubit,VerificationState>(
        listener: (context, state) {
          if (state is VerificationSuccess) {
            showToast(text:   AppLocalizations.of(context).translate(state.message), state: ToastStates.SUCCESS);

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => HomePage()),
                  (route) => false,
            );
          }

          if (state is VerificationError) {
            showToast(text: state.message, state: ToastStates.SUCCESS);

          }
        },
        child: Scaffold(
          backgroundColor: AppColors.primaryLight,
          body: Padding(
            padding:  EdgeInsets.symmetric(horizontal:size.padding.authHorizontal
                ),
            child: SingleChildScrollView(

              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///APPBAR
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical:size.padding.screenVertical),
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
                    ///TEXT VERIFICATION
                    Text(
                      AppLocalizations.of(context).translate("verification"),
                      style: AppTextStyles.dosisExtraBold48(),
                      overflow: TextOverflow.ellipsis, // إذا ضاق المكان يختصر النص
                    ),
                    SizedBox(height: size.spacing.medium,),
                    Text(AppLocalizations.of(context).translate("enter_code"),style:AppTextStyles.firaMedium16() ,),
                    SizedBox(height: size.spacing.extraLarge,),
                    ///CODE
                    AppTextField(
                      hint: AppLocalizations.of(context).translate("enter_code"),
                      controller: _otpController,
                      keyboardType: TextInputType.text,

                    ),

                    SizedBox(height: size.spacing.extraLarge,),
                    ///BOTTON VERIFICATION
                    BlocBuilder<VerificationCubit,VerificationState>(builder: (context, state) {
                      final isLoading = state is VerificationLoading;
                      return       AppButton(onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<VerificationCubit>().verifyEmail(
                            email: widget.email,
                           code: _otpController.text,
                          );
                        }
                      },
                        isLoading: isLoading
                      ,type: AppButtonType.primary,title: AppLocalizations.of(context).translate("verify"),);
                    },),

                    SizedBox(height: size.spacing.medium,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AuthSwitchText(
                            text: AppLocalizations.of(context).translate("no_code"),
                            actionText: AppLocalizations.of(context).translate("resend"), onTap: () {

                        },),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}