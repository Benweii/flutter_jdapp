import 'package:flutter/material.dart';

class PayWayItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final String content;

  /// 事件
  final Function onTap;

  const PayWayItem({
    Key key,
    this.icon,
    this.title = '',
    this.content = '',
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Row(
          children: [
            // 左侧 图标
            this.icon != null
                ? Padding(
                    padding: EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                    ),
                    child: this.icon,
                  )
                : SizedBox(
                    height: 20.0,
                    width: 20.0,
                  ),
            // 右侧 内容
            Padding(
              padding: EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 标题
                  Text(this.title),
                  // 内容
                  Text(this.content),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: this.onTap,
    );
  }
}
