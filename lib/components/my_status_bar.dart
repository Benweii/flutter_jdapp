import 'package:flutter/material.dart';
import 'package:flutter_jdapp/configs/app_colors.dart';

class MyStatusBar extends StatelessWidget {
  /// label
  final String label;
  final Color labelColor;
  final double labelFontSize;
  final FontWeight labelFontWeight;
  final TextStyle labelTextStyle;

  /// 标题
  final String title;
  final Color titleColor;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final TextStyle titleTextStyle;

  /// 图标
  final Icon icon;

  /// 事件
  final Function onTap;

  /// 容器样式
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color bgColor;
  final double topBorderWidth;
  final Color topBoderColor;
  final double bottomBorderWidth;
  final Color bottomBoderColor;
  final BoxDecoration decoration;

  const MyStatusBar({
    Key key,
    this.label = '',
    this.labelColor = AppColors.gray,
    this.labelFontSize = 16.0,
    this.labelFontWeight = FontWeight.normal,
    this.labelTextStyle,
    this.title = '',
    this.titleColor = AppColors.color_333,
    this.titleFontSize = 16.0,
    this.titleFontWeight = FontWeight.normal,
    this.titleTextStyle,
    this.icon,
    this.onTap,
    this.margin,
    this.padding = const EdgeInsets.all(10.0),
    this.bgColor = AppColors.white,
    this.topBorderWidth = 1.0,
    this.topBoderColor = AppColors.lightGray,
    this.bottomBorderWidth = 1.0,
    this.bottomBoderColor = AppColors.lightGray,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.margin,
      padding: this.padding,
      decoration: this.decoration != null
          ? this.decoration
          : BoxDecoration(
              color: this.bgColor,
              border: Border(
                top: BorderSide(
                  width: this.topBorderWidth,
                  color: this.topBoderColor,
                ),
                bottom: BorderSide(
                  width: this.bottomBorderWidth,
                  color: this.bottomBoderColor,
                ),
              ),
            ),
      child: InkWell(
        child: Row(
          children: [
            // label
            Text(
              this.label,
              style: this.labelTextStyle != null
                  ? this.labelTextStyle
                  : TextStyle(
                      color: this.labelColor,
                      fontSize: this.labelFontSize,
                      fontWeight: this.labelFontWeight,
                    ),
            ),
            // 标题
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  this.title,
                  style: this.titleTextStyle != null
                      ? this.titleTextStyle
                      : TextStyle(
                          color: this.titleColor,
                          fontSize: this.titleFontSize,
                          fontWeight: this.titleFontWeight,
                        ),
                ),
              ),
            ),
            // 图标
            this.icon != null ? this.icon : Container(),
          ],
        ),
        onTap: this.onTap,
      ),
    );
  }
}
