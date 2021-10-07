import 'package:flutter/material.dart';
import 'package:flutter_jdapp/configs/app_colors.dart';

class NavMenu extends StatelessWidget {
  double width;
  Color bgColor;
  Function onTap;

  /// 导航菜单名称
  String title;
  Color titleColor;
  double titleFontSize;
  FontWeight titleFontWeight;

  TextStyle titleStyle;

  NavMenu({
    Key key,
    this.width = double.infinity,
    this.bgColor = AppColors.color_f8f8f8,
    this.onTap,
    this.title,
    this.titleColor = AppColors.color_333,
    this.titleFontSize = 16,
    this.titleFontWeight = FontWeight.w500,
    this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: bgColor,
        padding: EdgeInsets.all(8),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: titleStyle != null
              ? titleStyle
              : TextStyle(
                  color: titleColor,
                  fontSize: titleFontSize,
                  fontWeight: titleFontWeight,
                ),
        ),
      ),
      onTap: onTap,
    );
  }
}
