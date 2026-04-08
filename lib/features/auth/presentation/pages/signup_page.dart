import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/core/constants/app_assets.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/di/service_locator.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';
import 'package:roasters/core/utils/validators.dart';
import 'package:roasters/features/auth/presentation/cubit/signup_cubit/cubit.dart';
import 'package:roasters/features/auth/presentation/cubit/signup_cubit/state.dart';
import 'package:roasters/features/auth/presentation/pages/login_page.dart';
import 'package:roasters/features/auth/presentation/pages/verification_page.dart';
import 'package:roasters/features/auth/presentation/widgets/dividers/or_divider.dart';
import 'package:roasters/shared/widgets/buttons/app_back_button.dart';
import 'package:roasters/shared/widgets/buttons/app_button.dart';
import 'package:roasters/shared/widgets/inputs/app_text_field.dart';
import 'package:roasters/shared/widgets/inputs/auth_switch_text.dart';
import 'package:roasters/shared/widgets/toast/toast_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size=AppSizes.instance;
    return BlocProvider(
      create: (_) => sl<SignUpCubit>(),
      child: BlocListener<SignUpCubit,SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            showToast(text: AppLocalizations.of(context).translate(state.message), state: ToastStates.SUCCESS);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => VerificationPage(email: emailController.text),
              ),
            );          }

          if (state is SignUpError) {
            showToast(text: state.message, state: ToastStates.SUCCESS);

          }
        },
        child: Scaffold(
          backgroundColor: AppColors.primaryLight,
          body: SafeArea(

            child: Padding(
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
                      ///TEXT SIGN IN
                      Text(
                        AppLocalizations.of(context).translate("signup"),

                        style: AppTextStyles.dosisExtraBold48(),
                        overflow: TextOverflow.ellipsis, // إذا ضاق المكان يختصر النص
                      ),
                      SizedBox(height: size.spacing.medium,),
                      Text( AppLocalizations.of(context).translate("signup_options"),style:AppTextStyles.firaMedium16() ,),
                      SizedBox(height: size.spacing.extraLarge,),
                      // Padding(
                      //   padding:  EdgeInsets.symmetric(horizontal:size.padding.authHorizontal ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center, // لتوسيط الزرين
                      //
                      //     children: [
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
                      //
                      // OrDivider(),
                      ///NAME
                      AppTextField(
                        hint: AppLocalizations.of(context).translate("name"),
                        controller:nameController ,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: size.spacing.medium,),
                      ///EMAIL
                      AppTextField(
                        hint: AppLocalizations.of(context).translate("email"),
                        controller:emailController ,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>AppValidators.email(value, context),

                      ),
                      SizedBox(height: size.spacing.medium,),
                      ///PASSWORD
                      AppTextField(
                        hint: AppLocalizations.of(context).translate("password"),
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        validator: (value) => AppValidators.password(value, context),

                      ),
                      SizedBox(height: size.spacing.medium,),
                      ///PHONE
                      AppTextField(
                        hint: AppLocalizations.of(context).translate("phone"),
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value) => AppValidators.phone(value, context),

                      ),
                      SizedBox(height: size.spacing.extraLarge,),
                      ///BOTTON SIGN IN
                      BlocBuilder<SignUpCubit,SignUpState>(
                          builder:(context, state) {
                            final isLoading = state is SignUpLoading;

                            return
                              AppButton(onPressed: () {

                                if (_formKey.currentState!.validate()) {
                                  context.read<SignUpCubit>().SignUp(
                                    role: "USER",
                                    phone:phoneController.text,
                                    name: nameController.text,
                                    email: emailController.text.trim(),
                                    password:
                                    passwordController.text.trim(),
                                  );
                                }
                            },
                                isLoading:isLoading,
                                type: AppButtonType.primary,title: AppLocalizations.of(context).translate("create_account"),);

                          },
                      ),
                      SizedBox(height: size.spacing.medium,),
                      ///LOGIN
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AuthSwitchText(  text: AppLocalizations.of(context).translate("have_account"),
                  actionText: AppLocalizations.of(context).translate("login"), onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
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
      ),
    );
  }
}
