import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jdapp/components/loading.dart';
import 'package:flutter_jdapp/models/product_info_model.dart';
import 'package:flutter_jdapp/pages/components/product_item.dart';
import 'package:flutter_jdapp/pages/product_detail_page.dart';
import 'package:flutter_jdapp/providers/product_list_page_provider.dart';
import 'package:flutter_jdapp/utils/log_util.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  /// 页面标题
  final String title;
  ProductListPage({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) {
      ProductListPageProvider provider = ProductListPageProvider();
      provider.loadProductListPageData();
      return provider;
    }, child: Consumer<ProductListPageProvider>(
      builder: (_, provider, __) {
        LogUtil.d('productList===>${jsonEncode(provider.productList)}');

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            centerTitle: true,
          ),
          body: _buildBody(provider),
        );
      },
    ));
  }

  Widget _buildBody(ProductListPageProvider provider) {
    // 加载动画
    if (provider.isLoading && provider.productList.length == 0) {
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
                provider.loadProductListPageData();
                // setState(() {});
              },
            ),
          ],
        ),
      );
    }

    List<ProductInfoModel> productList = provider.productList;
    return Container(
      child: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return ProductItem(
            info: productList[index],
            onTap: () {
              // 跳转商品详情页面
              // print('查看商品详情===>${productList[index].id}');
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return ProductDetailPage(
                    id: productList[index].id,
                  );
                },
              ));
            },
          );
        },
      ),
    );
  }
}
