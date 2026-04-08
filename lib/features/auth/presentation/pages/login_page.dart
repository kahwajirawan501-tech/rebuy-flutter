import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:roasters/core/constants/app_assets.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/di/service_locator.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';
import 'package:roasters/core/utils/validators.dart';
import 'package:roasters/features/auth/presentation/cubit/login_cubit/cubit.dart';
import 'package:roasters/features/auth/presentation/cubit/login_cubit/state.dart';
import 'package:roasters/features/auth/presentation/pages/signup_page.dart';
import 'package:roasters/features/auth/presentation/widgets/dividers/or_divider.dart';
import 'package:roasters/features/home/presentation/pages/main_page.dart';
import 'package:roasters/shared/widgets/buttons/app_back_button.dart';
import 'package:roasters/shared/widgets/buttons/app_button.dart';
import 'package:roasters/shared/widgets/inputs/app_text_field.dart';
import 'package:roasters/shared/widgets/inputs/auth_switch_text.dart';
import 'package:roasters/shared/widgets/toast/toast_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
     var size=AppSizes.instance;
    return BlocProvider(
      create:(_) => sl<LoginCubit>(),
      child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              showToast(text: AppLocalizations.of(context).translate(state.message), state: ToastStates.SUCCESS);

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => HomePage()),
                    (route) => false,
              );            }

            if (state is LoginError) {
              showToast(text: state.message, state: ToastStates.SUCCESS);

            }
          },
        child: Scaffold(
          backgroundColor: AppColors.primaryLight,
          body: SafeArea(

            child: Padding(
              padding:  EdgeInsets.symmetric(
                  horizontal:size.padding.authHorizontal ),
              child: SingleChildScrollView(

                child: Form(
                  key: _formKey,
                  child: Column(
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
                              overflow: TextOverflow.ellipsis, //
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.spacing.extraExtraLarge,),
                     ///TEXT LOGIN
                      Text(
                        AppLocalizations.of(context).translate("login"),
                        style: AppTextStyles.dosisExtraBold48(),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: size.spacing.medium,),
                      Text( AppLocalizations.of(context).translate("login_options"),style:AppTextStyles.firaMedium16() ,),
                      SizedBox(height: size.spacing.extraLarge,),
                      // Padding(
                      //   padding:  EdgeInsets.symmetric(horizontal:size.padding.authHorizontal ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center, // لتوسيط الزرين
                      //
                      //     children: [
                      //       ///GOOGLE
                      //       Expanded(
                      //         child: AppButton(
                      //           type: AppButtonType.social,
                      //           fullWidth: false,
                      //           onPressed: () {},
                      //           prefix: Image.asset(AppAssets.google, width: size.icons.medium, height:size.icons.medium,),
                      //
                      //         ),
                      //       ),
                      //       SizedBox(width: size.spacing.large),
                      //       ///FACE BOOK
                      //       Expanded(
                      //         child: AppButton(
                      //           type: AppButtonType.social,
                      //           onPressed: () {},
                      //           prefix: Image.asset(AppAssets.facebook,width: size.icons.large, height:size.icons.large,),
                      //
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(height: size.spacing.extraLarge,),
                      // ///LINE
                      // OrDivider(),
                      // SizedBox(height: size.spacing.extraLarge,),
                      ///EMAIL
                      AppTextField(
                        hint: AppLocalizations.of(context).translate("email"),
                        controller:emailController ,
                        keyboardType: TextInputType.emailAddress,
                        validator:(value) => AppValidators.email(value, context),

                      ),
                      SizedBox(height: size.spacing.medium,),
                      ///PASSWORD
                      AppTextField(
                        hint: AppLocalizations.of(context).translate("password"),
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        validator: (value) =>AppValidators.password(value, context),

                      ),
                      SizedBox(height: size.spacing.extraLarge,),
                      ///BOTTON LOGIN
                      BlocBuilder<LoginCubit, LoginState>(
                        builder:(context, state) {
                          final isLoading = state is LoginLoading;

                        return  AppButton(
                          onPressed: (){

                            if (_formKey.currentState!.validate()) {
                              context.read<LoginCubit>().login(
                                email: emailController.text.trim(),
                                password:
                                passwordController.text.trim(),
                              );
                            }},
                          isLoading:isLoading,
                          type: AppButtonType.primary,
                          title:AppLocalizations.of(context).translate("login"),
                        );

                        },
                      ),
                      SizedBox(height: size.spacing.medium,),
                      ///SIGN UP
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AuthSwitchText( text: AppLocalizations.of(context).translate("no_account"),
                            actionText: AppLocalizations.of(context).translate("signup"), onTap: () {

                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  SignupPage()));

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
      )

    );
  }
}
