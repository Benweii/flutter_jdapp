import 'package:flutter_jdapp/configs/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static showShort(String msg, {double fontSize}) {
    Fluttertoast.showToast(
      msg: msg ?? '',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      fontSize: fontSize ?? 16.0,
      backgroundColor: AppColors.color_333,
    );
  }

  static showLong(String msg, {double fontSize}) {
    Fluttertoast.showToast(
      msg: msg ?? '',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      fontSize: fontSize ?? 16.0,
      backgroundColor: AppColors.color_333,
    );
  }
}
