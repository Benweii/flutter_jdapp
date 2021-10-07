import 'package:flutter/material.dart';
import 'package:flutter_jdapp/configs/app_colors.dart';

class MyTitle extends StatelessWidget {
  String title;
  Color color;
  double fontSize;
  FontWeight fontWeight;
  TextStyle style;

  MyTitle({
    Key key,
    this.title = '',
    this.color = AppColors.color_333,
    this.fontSize = 16,
    this.fontWeight = FontWeight.bold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.title,
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
