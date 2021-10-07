import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jdapp/components/loading.dart';
import 'package:flutter_jdapp/components/primary_button.dart';
import 'package:flutter_jdapp/configs/app_colors.dart';
import 'package:flutter_jdapp/providers/product_detail_page_provider.dart';
import 'package:flutter_jdapp/utils/log_util.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  // 页面标题
  final String title;

  /// 商品id
  final String id;
  ProductDetailPage({
    Key key,
    this.title = '',
    @required this.id,
  }) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        ProductDetailPageProvider provider = ProductDetailPageProvider();
        provider.loadProductDetailPageData(id: widget.id);
        return provider;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Consumer<ProductDetailPageProvider>(
          builder: (_, provider, __) {
            LogUtil.d('productDetail===>${jsonEncode(provider.model)}');
            return _buildBody(provider);
          },
        ),
      ),
    );
  }

  Widget _buildBody(ProductDetailPageProvider provider) {
    // 加载动画
    if (provider.isLoading) {
      return Loading();
    }

    // 捕获异常
    if (provider.isError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(provider.errorMsg),
            ElevatedButton(
              child: Text('刷新'),
              onPressed: () {
                provider.loadProductDetailPageData();
                // setState(() {});
              },
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        // Text('商品详情页面'),

        /// 底部按钮
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1.0,
                  color: AppColors.lightGray,
                ),
              ),
            ),
            child: Row(
              children: [
                /// 购物车
                Expanded(
                  child: PrimaryButton(
                    bgColor: AppColors.lightWhite,
                    text: '购物车',
                    icon: Icon(Icons.shopping_cart),
                    onTap: () {
                      print('你点击了===>购物车');
                    },
                  ),
                ),

                /// 加入购物车
                Expanded(
                  child: PrimaryButton(
                    bgColor: AppColors.lightRed,
                    text: '加入购物车',
                    color: AppColors.lightWhite,
                    fontWeight: FontWeight.bold,
                    onTap: () {
                      print('你点击了===>加入购物车');
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
