import 'package:flutter/material.dart';
import 'package:flutter_jdapp/configs/app_colors.dart';

class Menu extends StatelessWidget {
  double width;
  double height;
  String iconUrl;
  double iconWidth;
  double iconHeight;
  BoxFit iconFit;
  String title;
  TextStyle titleStyle;

  Menu({
    Key key,
    this.width,
    this.height,
    this.iconUrl,
    this.iconWidth,
    this.iconHeight,
    this.iconFit = BoxFit.cover,
    this.title,
    this.titleStyle = const TextStyle(color: AppColors.color_333),
  }) : super(key: key) {
    iconHeight = iconWidth == null && iconHeight == null ? 50 : iconHeight;
    print('iconWidth=$iconWidth, iconHeight=$iconHeight');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
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
    );
  }
}
