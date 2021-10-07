import 'package:flutter/material.dart';
import 'package:flutter_jdapp/configs/app_colors.dart';

class MyTitle extends StatelessWidget {
  String title;
  Color color;
  double fontSize;
  FontWeight fontWeight;
  TextStyle style;
  int maxLing;
  TextOverflow overflow;

  MyTitle({
    Key key,
    this.title = '',
    this.color = AppColors.color_333,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.bold,
    this.maxLing = 2,
    this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.title,
      maxLines: this.maxLing,
      overflow: this.overflow,
      style: this.style != null
          ? this.style
          : TextStyle(
              color: this.color,
              fontSize: this.fontSize,
              fontWeight: this.fontWeight,
            ),
    );
  }
}
