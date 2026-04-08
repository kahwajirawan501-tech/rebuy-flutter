import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';

class OptionsBottomSheet {
  final BuildContext context;
  final bool isImage;
  final bool showEdit;
  final bool showDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final Function(File)? onImageSelected;

  OptionsBottomSheet({
    required this.context,
    this.isImage = false,
    this.showEdit = false,
    this.showDelete = false,
    this.onEdit,
    this.onDelete,
    this.onImageSelected,
  });

  final ImagePicker _picker = ImagePicker();

  void show() {
    final size = AppSizes.instance;
    bool showImageOptions = !showEdit;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        final t = AppLocalizations.of(context);
        return StatefulBuilder(
          builder: (context, setState) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: EdgeInsets.symmetric(
                horizontal: size.spacing.medium,
                vertical: size.spacing.small,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(size.borderRadius.extraExtraLarge),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ===== زر التعديل =====
                  if (showEdit && onEdit != null)
                    _buildListTile(
                      icon: Icons.edit_note,
                      iconColor: AppColors.primary,
                      title:  t.translate("edit"),
                      onTap: () {
                        if (isImage && onImageSelected != null) {
                          setState(() => showImageOptions = true);
                        } else {
                          Navigator.pop(context);
                          onEdit!();
                        }
                      },
                    ),

                  // ===== خيارات الصورة =====
                  if (isImage && onImageSelected != null && showImageOptions) ...[
                    if(showEdit)
                     const Divider(),
                    _buildImageOption(Icons.camera_alt, t.translate("camera") , ImageSource.camera),
                    _buildImageOption(Icons.photo, t.translate("gallery"), ImageSource.gallery),
                  ],

                  // ===== زر الحذف =====
                  if (showDelete && onDelete != null) ...[
                    const Divider(),
                    _buildListTile(
                      icon: Icons.delete,
                      iconColor: AppColors.primaryDark,
                      title:  t.translate("delete"),
                      onTap: () {
                        Navigator.pop(context);
                        onDelete!();
                      },
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    final size = AppSizes.instance;
    return ListTile(
      leading: Icon(icon, size: size.icons.medium, color: iconColor),
      title: Text(title, style: AppTextStyles.firaMedium14()),
      onTap: onTap,
    );
  }

  Widget _buildImageOption(IconData icon, String title, ImageSource source) {
    return _buildListTile(
      icon: icon,
      iconColor: AppColors.secondaryDark,

      title: title,
      onTap: () async {
        Navigator.pop(context);
        final pickedFile = await _picker.pickImage(source: source);
        if (pickedFile != null) onImageSelected!(File(pickedFile.path));
      },
    );
  }
}