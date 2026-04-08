import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/constants/url_image.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import 'package:roasters/core/services/options_menu_delete_edit.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';
import 'package:roasters/features/auth/data/LocalDataSource/auth_local_data_source.dart';
import 'package:roasters/features/profile/domain/entities/update_profile_entity.dart';
import 'package:roasters/features/profile/presentation/cubit/cubit.dart';
import 'package:roasters/features/profile/presentation/cubit/state.dart';
import 'package:roasters/shared/widgets/buttons/app_back_button.dart';
import 'package:roasters/shared/widgets/buttons/app_button.dart';
import 'package:roasters/shared/widgets/inputs/app_text_field.dart';
import 'package:roasters/shared/widgets/loaders/app_loader.dart';
import 'package:roasters/shared/widgets/toast/toast_widget.dart';

class EditProfilePage extends StatefulWidget {
  final AuthLocalDataSource authLocalDataSource;
  const EditProfilePage(this.authLocalDataSource, {super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  var size = AppSizes.instance;
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  File? _selectedImage;
  String? _networkImage;
   String? email;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = await widget.authLocalDataSource.getUser();

    if (user != null) {
      setState(() {
        nameController.text = user.name ?? "";
        phoneController.text = user.phone ?? "";
        _networkImage = user.profileImage;
        email=user.email;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: SafeArea(

        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.padding.screenHorizontal,

            ),
          child: SingleChildScrollView(

            child: BlocListener<ProfileCubit,ProfileState>(
              listener: (context, state) {
                if (state is UpdateProfileLoading) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => AppLoader()
                  );

                }
                if(state is UpdateProfileError)
                {
                  Navigator.pop(context);

                  showToast(
                    text: AppLocalizations.of(context).translate(state.message),
                    state: ToastStates.SUCCESS,
                  );
                }
                if(state is UpdateProfileSuccess)
                {   Navigator.pop(context);

                showToast(
                  text: AppLocalizations.of(context).translate(state.message),
                  state: ToastStates.SUCCESS,
                );                setState(() {
                  _networkImage = state.image;
                  _selectedImage = null;
                });

               // Navigator.pop(context);
                }
              },
              child:  BlocBuilder<ProfileCubit,ProfileState>(
                builder: (context, state) {
                  return Column(
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
                      ///TEXT MY ACCOUNT
                      Text(
                  AppLocalizations.of(context).translate("edit_profile_title"),

                        style: AppTextStyles.dosisExtraBold32(),
                        overflow: TextOverflow.ellipsis, // إذا ضاق المكان يختصر النص
                      ),

                      SizedBox(height: size.spacing.extraLarge),
                      ///IMAGE
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              OptionsBottomSheet(
                                context: context,
                                isImage: true,
                                showEdit: true,
                                showDelete: true,
                                onEdit: () { /* تعديل */ },
                                onDelete: () async {
                                  if (_selectedImage != null) {
                                    setState(() => _selectedImage = null);
                                  } else if (_networkImage != null && _networkImage!.isNotEmpty) {
                                    await BlocProvider.of<ProfileCubit>(context).removeLocalProfileImage();
                                    setState(() => _networkImage = null);
                                  }
                                },
                                onImageSelected: (file) { setState(() => _selectedImage = file); },
                              ).show();

                            },
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: size.borderRadius.circular,
                                  backgroundImage: _selectedImage != null
                                      ? FileImage(_selectedImage!)
                                      : (_networkImage != null && _networkImage!.isNotEmpty
                                      ? NetworkImage(url + _networkImage!)
                                      : null)
                                  ,
                                    child: (_selectedImage == null && (_networkImage == null || _networkImage!.isEmpty))
                                        ? Icon(Icons.person, size: size.icons.extraLarge, color: AppColors.primary,)
                                        : null,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.lineDark),
                                      color: AppColors.primaryLight,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: EdgeInsets.all(6),
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: size.icons.small,
                                      color:AppColors.icon,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: size.spacing.medium),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nameController.text,
                                style: AppTextStyles.firaMedium24(
                                    color: AppColors.primaryDark),
                              ),
                              Text(
                                email??"",
                                style: AppTextStyles.firaMedium14(),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: size.spacing.medium,),
                      ///NAME
                      AppTextField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        label: AppLocalizations.of(context).translate("name_label"),
                        hint: AppLocalizations.of(context).translate("name_hint"),
                        suffix: Icon(Icons.edit_note,size: size.icons.large,color: AppColors.icon,),

                      ),
                      SizedBox(height: size.spacing.medium,),
                      ///PHONE
                      AppTextField(
                        controller: phoneController,
                        keyboardType: TextInputType.name,
                        label: AppLocalizations.of(context).translate("phone_label"),
                        hint: AppLocalizations.of(context).translate("phone_hint"),
                        suffix: Icon(Icons.edit_note,size: size.icons.large,color: AppColors.icon,),
                      ),
                      SizedBox(height: size.spacing.extraLarge),
                  AppButton(
                  onPressed: () {

                    BlocProvider.of<ProfileCubit>(context).updateProfile(
                  UpdateProfileEntity(
                  name: nameController.text,
                  phone: phoneController.text,
                  image: _networkImage,
                  ),
                  _selectedImage,
                  );
                  },
                  type: AppButtonType.primary,
                  title:AppLocalizations.of(context).translate("update_button"),
                  ),


                    ],
                  );
                },

              ),
            ),
          ),
        ),
      ),
    );
  }
}
