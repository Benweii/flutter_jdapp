import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jdapp/components/loading.dart';
import 'package:flutter_jdapp/components/my_status_bar.dart';
import 'package:flutter_jdapp/components/my_title.dart';
import 'package:flutter_jdapp/components/price.dart';
import 'package:flutter_jdapp/components/primary_button.dart';
import 'package:flutter_jdapp/configs/app_colors.dart';
import 'package:flutter_jdapp/models/product_detail_model.dart';
import 'package:flutter_jdapp/pages/components/pay_way_item.dart';
import 'package:flutter_jdapp/providers/product_detail_page_provider.dart';
import 'package:flutter_jdapp/utils/log_util.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
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

    ProductDetailModel model = provider.model;

    return Stack(
      children: [
        /// 主题内容
        ListView(
          children: [
            /// 轮播图
            _buildSwiperContainer(model),

            /// 标题
            _buildTitle(model),

            /// 价格
            _buildPrice(model),

            /// 白条支付
            _buildPayStatusBar(model),

            /// 商品件数
            _buildBuyCountStatusBar(model),
          ],
        ),

        /// 底部菜单栏
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
                    bgColor: AppColors.deepRed,
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

  /// 轮播图
  Container _buildSwiperContainer(ProductDetailModel model) {
    return Container(
      height: 300,
      // color: AppColors.lightRed,
      child: Swiper(
        itemCount: model.partData.loopImgUrl.length,
        pagination: SwiperPagination(),
        autoplay: true,
        itemBuilder: (context, index) {
          return Image.asset(
            'assets${model.partData.loopImgUrl[index]}',
            height: 400,
            // height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          );
        },
      ),
    );
  }

  /// 标题
  MyTitle _buildTitle(ProductDetailModel model) {
    return MyTitle(
      title: model.partData.title,
      padding: EdgeInsets.all(10.0),
    );
  }

  /// 价格
  Price _buildPrice(ProductDetailModel model) {
    return Price(
      price: model.partData.price,
      padding: EdgeInsets.all(10.0),
      fontWeight: FontWeight.bold,
    );
  }

  /// 支付
  MyStatusBar _buildPayStatusBar(ProductDetailModel model) {
    String baitiaoTitle = '';
    if (model != null) {
      for (var item in model.baitiao) {
        // print(item.select);
        if (item.select) {
          baitiaoTitle = item.desc;
          break;
        }
      }
    }
    // print('支付===>$baitiaoTitle');

    return MyStatusBar(
      label: '支付',
      title: '$baitiaoTitle',
      icon: Icon(Icons.more_horiz),
      onTap: () {
        showPayWayModal(model);
      },
    );
  }

  /// 显示支付方式
  Future<dynamic> showPayWayModal(ProductDetailModel model) {
    List<Baitiao> baitiaoList = model.baitiao;

    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Stack(
            children: [
              /// 顶部标题栏
              Stack(
                children: [
                  Container(
                    // width: double.infinity,
                    height: 40.0,
                    color: AppColors.silvery,
                    child: Center(
                      child: MyTitle(
                        title: '打白条购买',
                        bgColor: AppColors.transparent,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    width: 40.0,
                    height: 40.0,
                    child: Center(
                      child: IconButton(
                        icon: Icon(Icons.close),
                        iconSize: 20.0,
                        onPressed: () {
                          // 关闭 选择支付方式模态框
                          // Navigator.pop(context);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ],
              ),

              /// 主体列表
              Container(
                margin: EdgeInsets.only(
                  top: 40,
                  bottom: 50,
                ),
                child: ListView.builder(
                  itemCount: baitiaoList.length,
                  itemBuilder: (context, index) {
                    Baitiao baitiao = baitiaoList[index];

                    return PayWayItem(
                      icon: Image.asset(
                        baitiao.select
                            ? 'assets/image/selected.png'
                            : 'assets/image/unselect.png',
                        width: 20.0,
                        height: 20.0,
                      ),
                      title: baitiao.desc,
                      content: baitiao.tip,
                      onTap: () {
                        // 选择分期类型
                        baitiaoList.forEach((element) {
                          element.select = false;
                        });
                        baitiaoList[index].select = true;
                      },
                    );
                  },
                ),
              ),

              /// 底部按钮
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: PrimaryButton(
                  text: '立即打白条',
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  height: 50.0,
                  bgColor: AppColors.deepRed,
                  onTap: () {
                    // 关闭 选择支付方式模态框
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          );
        });
  }

  /// 商品数量
  MyStatusBar _buildBuyCountStatusBar(ProductDetailModel model) {
    return MyStatusBar(
      label: '已选',
      title: '${model.partData.count}件',
      icon: Icon(Icons.more_horiz),
    );
  }
}
