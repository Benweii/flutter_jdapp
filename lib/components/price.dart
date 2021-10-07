import 'package:flutter/material.dart';
import 'package:flutter_jdapp/configs/app_colors.dart';

class Price extends StatelessWidget {
  final String price;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextStyle textStyle;

  /// 容器样式修饰
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color bgColor;

  const Price({
    Key key,
    this.price,
    this.color = AppColors.lightRed,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.normal,
    this.textStyle,
    this.margin,
    this.padding,
    this.bgColor = AppColors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.margin,
      padding: this.padding,
      child: Text(
        '¥$price',
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
