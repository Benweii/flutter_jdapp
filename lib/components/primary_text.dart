import 'package:flutter/material.dart';
import 'package:flutter_jdapp/configs/app_colors.dart';

class PrimaryText extends StatelessWidget {
  final String text;
  final Color fontColor;
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
  final Color color;
  final Alignment alignment;
  final BoxDecoration decoration;

  const PrimaryText({
    Key key,
    @required this.text,
    this.fontColor,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.textStyle,
    this.maxLing,
    this.overflow,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.color,
    this.alignment,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.margin,
      padding: this.padding,
      width: this.width,
      height: this.height,
      alignment: this.alignment,
      decoration: this.decoration ??
          BoxDecoration(
            color: this.color ?? Colors.transparent,
          ),
      child: Text(
        this.text ?? '',
        maxLines: this.maxLing,
        overflow: this.overflow,
        textAlign: this.textAlign,
        style: this.textStyle != null
            ? this.textStyle
            : TextStyle(
                color: this.fontColor ?? AppColors.color_333,
                fontSize: this.fontSize ?? 12.0,
                fontWeight: this.fontWeight ?? FontWeight.normal,
              ),
      ),
    );
  }
}
