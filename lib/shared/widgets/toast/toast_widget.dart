import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roasters/core/theme/app_colors.dart';

void showToast({
  required String text,
  required ToastStates state,
})=>Fluttertoast.showToast(
  msg: text,

  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,//ظهور
  timeInSecForIosWeb: 5,
  backgroundColor: chooseToastColor(state),
  textColor:AppColors.text,
  fontSize: 16.0,

);
enum ToastStates{
  SUCCESS,EROOR,WARNING
}
Color chooseToastColor(ToastStates state)
{  Color color;
switch(state){
  case ToastStates.SUCCESS:
    color=AppColors.primaryLight;

    break;
  case ToastStates.EROOR:
    color= AppColors.error;
    break;
  case ToastStates.WARNING:
    color=  AppColors.warning;
    break;

}
return color;

}