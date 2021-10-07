import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jdapp/models/product_info_model.dart';
import 'package:flutter_jdapp/pages/components/product_item.dart';
import 'package:flutter_jdapp/providers/product_list_page_provider.dart';
import 'package:flutter_jdapp/utils/log_util.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  /// 页面标题
  String title;
  ProductListPage({Key key, this.title}) : super(key: key);

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
        List<ProductInfoModel> productList = provider.productList;

        LogUtil.d('productList===>${jsonEncode(productList)}');
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            centerTitle: true,
          ),
          body: Container(
            child: ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return ProductItem(
                  info: productList[index],
                  onTap: () {
                    print('查看商品详情===>${productList[index].id}');
                  },
                );
              },
            ),
          ),
        );
      },
    ));
  }
}
