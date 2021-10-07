import 'package:flutter/material.dart';
import 'package:flutter_jdapp/configs/app_colors.dart';

class Menu extends StatelessWidget {
  double width;
  double height;
  EdgeInsets margin;
  EdgeInsets padding;
  Function onTap;

  /// icon配置参数
  String iconUrl;
  double iconWidth;
  double iconHeight;
  BoxFit iconFit;

  /// title配置参数
  String title;
  TextStyle titleStyle;

  Menu({
    Key key,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.onTap,
    this.iconUrl,
    this.iconWidth,
    this.iconHeight,
    this.iconFit = BoxFit.cover,
    this.title,
    this.titleStyle = const TextStyle(color: AppColors.color_333),
  }) : super(key: key) {
    iconHeight = iconWidth == null && iconHeight == null ? 50 : iconHeight;
    // print('iconWidth=$iconWidth, iconHeight=$iconHeight');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        child: Column(
          children: [
            Container(
              child: Image.asset(
                iconUrl,
                fit: iconFit,
                width: iconWidth,
                height: iconHeight,
              ),
            ),
            Text(
              title,
              style: titleStyle,
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
