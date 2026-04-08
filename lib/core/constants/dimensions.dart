import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSizes {
  static late AppSizes _instance;
  factory AppSizes() => _instance;
  AppSizes._internal();

  static AppSizes get instance => _instance;

  static void init() {
    _instance = AppSizes._internal();
  }

  // === Sub-classes ===
  late _Buttons buttons;
  late _ButtonsBack buttonsBack;
  late _Padding padding;
  late _Spacing spacing;
  late _BorderRadius borderRadius;
  late _Icons icons;
  late _NavigationBar navigationBar;
  late _ProductImage  productImage;
  late _ProfileImage   profileImage;
  late _field field;
late _StepIndicator stepIndicator;
  void initSizes() {
    buttons = _Buttons(
       height: 57.h,
       buttonSeconddHeight:44.h,
      smallHeight: 35.h,
      smallWidth: 75.w
    );

    navigationBar=_NavigationBar(height:54.h);

    buttonsBack=_ButtonsBack(height: 46.h,width: 46.w);

    productImage=_ProductImage(
      height :500.h,
      heightSmall: 300.h,
      widthSmall: 120.w
    );
    stepIndicator=_StepIndicator(
        heightSmall: 18.h,
        widthSmall: 18.w,

        heightLarge: 30.h,
        widthLarge: 30.w,

        widthLine: 45.w
    );
    profileImage=_ProfileImage(
        heightSmall: 38.h,
        widthSmall: 35.w,

        heightMedium: 60.h,
        widthMedium: 50.w,

        heightLarge: 400.h,
        widthLarge: 30.w
    );

    padding = _Padding(
      authHorizontal: 32.w,
      authVertical: 16.h,

      fieldHorizontal: 16.w,
      fieldVertical: 14.h,

      navHorizontal: 14.w,
      navVertical: 28.h,//

      screenHorizontal:16.w,//
      screenVertical: 32.h,//

      cardHorizontal:16.w,
      cardVertical:16.h,

    );

    spacing = _Spacing(
      tiny: 4.w,
      small: 8.w,
      medium: 16.w,
      large: 24.w,
      extraLarge: 32.w,
      extraExtraLarge:64.w
    );

    borderRadius = _BorderRadius(
      small: 8.r,
      medium: 12.r,
      large: 16.r,
      extraLarge: 24.r,
      extraExtraLarge:32.r,
      circular:50.r
    );

    icons = _Icons(
      small: 16.spMin,
      medium: 24.spMin,
      large: 32.spMin,
      extraLarge: 48.spMin,
    );
    field =_field(
        heightSmall: 43,
        heightLarge: 57,
    );
  }
}

// === Sub-classes ===
class _Buttons {
  final double height;
  final double buttonSeconddHeight;
  final double smallWidth;
  final double smallHeight;
  _Buttons({required this.height, required this.buttonSeconddHeight, required this.smallWidth, required this.smallHeight});
}
class _ButtonsBack {
  final double height;
  final double width;
  _ButtonsBack({required this.height,required this.width});
}
class _NavigationBar{
  final double height;

  _NavigationBar({required this.height});
}
class _Padding {
  final double authHorizontal;
  final double authVertical;


  final double fieldHorizontal;
  final double fieldVertical;

  final double navHorizontal;
  final double navVertical;

  final double screenHorizontal;
  final double screenVertical;
  final double cardHorizontal;
  final double cardVertical;
  _Padding({
    required this.authHorizontal,
    required this.authVertical,
    required this.fieldHorizontal,

    required this.fieldVertical, required this.navHorizontal, required this.navVertical, required this.screenHorizontal, required this.screenVertical, required this.cardHorizontal, required this.cardVertical,
  });
}

class _Spacing {
  final double tiny;
  final double small;
  final double medium;
  final double large;
  final double extraLarge;
  final double extraExtraLarge;

  _Spacing({
    required this.tiny,
    required this.small,
    required this.medium,
    required this.large,
    required this.extraLarge, required this.extraExtraLarge,
  });
}

class _BorderRadius {
  final double small;
  final double medium;
  final double large;
  final double extraLarge;
  final double extraExtraLarge;
  final double circular;
  _BorderRadius({
    required this.small,
    required this.medium,
    required this.large,
    required this.extraLarge, required this.extraExtraLarge, required this.circular,
  });
}

class _Icons {
  final double small;
  final double medium;
  final double large;
  final double extraLarge;
  _Icons({
    required this.small,
    required this.medium,
    required this.large,
    required this.extraLarge,
  });

}
class _ProductImage{
  final double height;
  final double heightSmall;
  final double widthSmall;
  _ProductImage({required this.height, required this.heightSmall, required this.widthSmall});
}

class _ProfileImage{
  final double heightSmall;
  final double widthSmall ;
  final double heightMedium;
  final double widthMedium ;
  final double heightLarge;
  final double widthLarge;

  _ProfileImage({required this.heightSmall, required this.widthSmall, required this.heightMedium, required this.widthMedium, required this.heightLarge, required this.widthLarge});

}
class _field{
  final double heightSmall;
  final double heightLarge;

  _field({required this.heightSmall, required this.heightLarge});
}

class _StepIndicator{
  final double heightSmall;
  final double widthLarge;
  final double widthSmall;
  final double heightLarge;
  final double widthLine;

  _StepIndicator({required this.heightSmall, required this.heightLarge, required this.widthLarge, required this.widthSmall, required this.widthLine});
}