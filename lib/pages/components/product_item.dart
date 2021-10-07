import 'package:flutter/material.dart';
import 'package:flutter_jdapp/components/comment.dart';
import 'package:flutter_jdapp/components/my_title.dart';
import 'package:flutter_jdapp/components/price.dart';
import 'package:flutter_jdapp/models/product_info_model.dart';

class ProductItem extends StatelessWidget {
  final ProductInfoModel info;
  final Function onTap;

  const ProductItem({
    Key key,
    @required this.info,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Row(
          children: [
            // 左边缩略图
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Image.asset(
                'assets${info.cover}',
                width: 95,
                height: 120,
              ),
            ),
            // 右边摘要信息
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 简介
                    MyTitle(
                      title: info.title,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    // 价格
                    Price(
                      price: info.price,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    // 评论与好评率
                    Comment(
                      comment: info.comment,
                      rate: info.rate,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: this.onTap,
    );
  }
}
