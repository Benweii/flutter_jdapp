import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final double width;
  final double height;
  final Color bgColor;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  /// 按钮图标
  final Icon icon;

  /// 按钮文字样式设置
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextStyle textStyle;
  final Function onTap;

  const PrimaryButton({
    Key key,
    this.width,
    this.height = 60.0,
    this.bgColor,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.icon,
    this.text,
    this.color,
    this.fontSize = 16.0,
    this.fontWeight,
    this.textStyle,
    this.onTap,
  }) : super(key: key);

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: widget.width,
        height: widget.height,
        color: widget.bgColor,
        child: Column(
          mainAxisAlignment: widget.mainAxisAlignment,
          crossAxisAlignment: widget.crossAxisAlignment,
          children: [
            /// 按钮图标
            widget.icon != null ? widget.icon : Container(),

            /// 按钮文字
            Text(
              widget.text,
              style: widget.textStyle != null
                  ? widget.textStyle
                  : TextStyle(
                      color: widget.color,
                      fontSize: widget.fontSize,
                      fontWeight: widget.fontWeight,
                    ),
            ),
          ],
        ),
      ),
      onTap: widget.onTap,
    );
  }
}
