import 'package:roasters/core/localization/app_localizations.dart';

class AppValidators {

  static String? email(String? value, context) {
    final t = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return t.translate("email_required");
    }

    final emailRegex =
    RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return t.translate("invalid_email");
    }

    return null;
  }

  static String? password(String? value, context) {
    final t = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return t.translate("password_required");
    }

    if (value.length < 6) {
      return t.translate("password_min_length");
    }

    return null;
  }

  static String? phone(String? value, context) {
    final t = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return t.translate("phone_required");
    }

    if (value.length != 10) {
      return t.translate("phone_length");
    }

    final numericRegex = RegExp(r'^\d+$');
    if (!numericRegex.hasMatch(value)) {
      return t.translate("phone_digits_only");
    }

    return null;
  }
}