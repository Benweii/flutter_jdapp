import 'package:flutter/material.dart';
import 'package:flutter_jdapp/configs/app_colors.dart';

class MyTitle extends StatelessWidget {
  final String title;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextStyle textStyle;
  final int maxLing;
  final TextOverflow overflow;

  /// 容器样式修饰
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double width;
  final double height;
  final Color bgColor;

  const MyTitle({
    Key key,
    this.title = '',
    this.color = AppColors.color_333,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.bold,
    this.textAlign,
    this.textStyle,
    this.maxLing = 2,
    this.overflow = TextOverflow.ellipsis,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.bgColor = AppColors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.margin,
      padding: this.padding,
      width: this.width,
      height: this.height,
      color: this.bgColor,
      child: Text(
        this.title,
        maxLines: this.maxLing,
        overflow: this.overflow,
        textAlign: this.textAlign,
        style: this.textStyle != null
            ? this.textStyle
            : TextStyle(
                color: this.color,
                fontSize: this.fontSize,
                fontWeight: this.fontWeight,
              ),
      ),
    );
  }
}
