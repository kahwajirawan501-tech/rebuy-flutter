import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';

class AuthSwitchText extends StatelessWidget {
  final String text;
  final String actionText;
  final VoidCallback onTap;

  const AuthSwitchText({
    super.key,
    required this.text,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: AppTextStyles.firaBold16(),
        children: [
          TextSpan(
            text: actionText,
            style: AppTextStyles.firaBold18().copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}