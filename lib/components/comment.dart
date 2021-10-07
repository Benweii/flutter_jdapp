import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdapp/configs/app_colors.dart';

class Comment extends StatelessWidget {
  final String comment;
  final String rate;
  final Color color;
  final double fontSize;

  Comment({
    Key key,
    this.comment,
    this.rate,
    this.color = AppColors.gray,
    this.fontSize = 13.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Text(
            '¥$comment条评价',
            style: TextStyle(
              color: this.color,
              fontSize: this.fontSize,
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            '好评率$rate',
            style: TextStyle(
              color: this.color,
              fontSize: this.fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
