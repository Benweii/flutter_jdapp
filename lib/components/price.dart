import 'package:flutter/material.dart';
import 'package:flutter_jdapp/configs/app_colors.dart';

class Price extends StatelessWidget {
  String price;

  Price({Key key, this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '¥$price',
      style: TextStyle(color: AppColors.lightRed, fontSize: 16.0),
    );
  }
}
