import 'package:flutter/material.dart';
import 'package:flutter_jdapp/components/primary_text.dart';
import 'package:flutter_jdapp/configs/app_colors.dart';

class PrimaryCounter extends StatelessWidget {
  final int count;
  final Function onAdd;
  final Function onDeduct;
  final Color buttonColor;

  final double _buttonSize = 35.0;
  final Color _buttonColor = AppColors.color_f7f7f7;
  final Color _buttonFontColor = AppColors.color_b0b0b0;

  const PrimaryCounter({
    Key key,
    this.count,
    this.onAdd,
    this.onDeduct,
    this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 减号
          InkWell(
            child: PrimaryText(
              width: _buttonSize,
              height: _buttonSize,
              color: this.buttonColor ?? _buttonColor,
              text: '-',
              fontSize: 18.0,
              fontColor: _buttonFontColor,
              // textAlign: TextAlign.center,
              alignment: Alignment.center,
            ),
            onTap: this.onDeduct,
          ),
          // 数量
          PrimaryText(
            padding: EdgeInsets.only(
              left: 2.0,
              right: 2.0,
            ),
            width: _buttonSize,
            height: _buttonSize,
            text: this.count.toString(),
            alignment: Alignment.center,
          ),
          // 加号
          InkWell(
            child: PrimaryText(
              width: _buttonSize,
              height: _buttonSize,
              color: this.buttonColor ?? _buttonColor,
              text: '+',
              fontSize: 18.0,
              fontColor: _buttonFontColor,
              alignment: Alignment.center,
            ),
            onTap: this.onAdd,
          ),
        ],
      ),
    );
  }
}
