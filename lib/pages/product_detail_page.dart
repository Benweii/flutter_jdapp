import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jdapp/components/loading.dart';
import 'package:flutter_jdapp/components/my_status_bar.dart';
import 'package:flutter_jdapp/components/my_title.dart';
import 'package:flutter_jdapp/components/price.dart';
import 'package:flutter_jdapp/components/primary_button.dart';
import 'package:flutter_jdapp/components/primary_counter.dart';
import 'package:flutter_jdapp/components/primary_text.dart';
import 'package:flutter_jdapp/configs/app_colors.dart';
import 'package:flutter_jdapp/models/product_detail_model.dart';
import 'package:flutter_jdapp/pages/components/pay_way_item.dart';
import 'package:flutter_jdapp/providers/bottom_navi_provider.dart';
import 'package:flutter_jdapp/providers/cart_provider.dart';
import 'package:flutter_jdapp/providers/product_detail_page_provider.dart';
import 'package:flutter_jdapp/utils/log_util.dart';
import 'package:flutter_jdapp/utils/toast_util.dart';
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
            return _buildBody(context, provider);
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ProductDetailPageProvider provider) {
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
        // 主体内容
        ListView(
          children: [
            // 轮播图
            _buildSwiperContainer(model),

            // 标题
            _buildTitle(model),

            // 价格
            _buildPrice(model),

            // 白条支付
            _buildPayStatusBar(model, provider),

            // 商品件数
            _buildBuyCountStatusBar(model, provider),
          ],
        ),

        // 底部菜单栏
        _buildBottomMenuBar(context, model),
      ],
    );
  }

  /// 底部菜单栏
  Widget _buildBottomMenuBar(BuildContext context, ProductDetailModel model) {
    return Positioned(
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
                icon: Stack(
                  children: [
                    Container(
                      width: 40.0,
                      height: 30.0,
                      child: Icon(Icons.shopping_cart),
                    ),
                    // 购物车中商品数据角标
                    Consumer<CartProvider>(builder: (_, cartProvider, __) {
                      return Positioned(
                        // top: 0,
                        right: 0,
                        child: PrimaryText(
                          padding: EdgeInsets.all(2.0),
                          text: cartProvider.getAllCount().toString(),
                          fontColor: AppColors.white,
                          decoration: BoxDecoration(
                            color: AppColors.red,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                onTap: () {
                  // 查看购物车
                  print('你点击了===>购物车');
                  // 先回到顶层
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                  // 跳转到购物车页面
                  Provider.of<BottomNaviProvider>(
                    context,
                    listen: false,
                  ).changeBottomActiveNaviIndex(2);
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
                  // 加入购物车
                  print('你点击了===>加入购物车');
                  // 加入购物车
                  Provider.of<CartProvider>(
                    context,
                    listen: false,
                  ).addToCart(model.partData);
                  ToastUtil.showShort('成功加入购物车');
                },
              ),
            ),
          ],
        ),
      ),
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
  MyStatusBar _buildPayStatusBar(
      ProductDetailModel model, ProductDetailPageProvider provider) {
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
        _showPayWayModal(model, provider);
      },
    );
  }

  /// 显示支付方式模态框
  Future<dynamic> _showPayWayModal(
      ProductDetailModel model, ProductDetailPageProvider provider) {
    List<Baitiao> baitiaoList = model.baitiao;

    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return ChangeNotifierProvider<ProductDetailPageProvider>.value(
            value: provider,
            child: Stack(
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
                        child: _buildCloseButton(context, onPressed: () {
                          // 关闭 选择支付方式模态框
                          Navigator.pop(context);
                          // Navigator.of(context).pop();
                        }),
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
                        icon: Consumer<ProductDetailPageProvider>(
                            builder: (_, provider, __) {
                          // 这里的形参变量名 可以仍然可以叫 provider，也可以叫 tmpProvider，没有关系
                          return Image.asset(
                            baitiao.select
                                ? 'assets/image/selected.png'
                                : 'assets/image/unselect.png',
                            width: 20.0,
                            height: 20.0,
                          );
                        }),
                        title: baitiao.desc,
                        content: baitiao.tip,
                        onTap: () {
                          // 选择分期类型
                          provider.changePayWay(index);
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
            ),
          );
        });
  }

  /// 关闭按钮
  Widget _buildCloseButton(BuildContext context,
      {EdgeInsets margin, Function onPressed}) {
    return Container(
      margin: margin,
      child: IconButton(
        icon: Icon(Icons.close),
        iconSize: 20.0,
        onPressed: onPressed,
      ),
    );
  }

  /// 商品数量
  MyStatusBar _buildBuyCountStatusBar(
      ProductDetailModel model, ProductDetailPageProvider provider) {
    return MyStatusBar(
      label: '已选',
      title: '${model.partData.count}件',
      icon: Icon(Icons.more_horiz),
      onTap: () {
        _showBuyCountModal(model, provider);
      },
    );
  }

  /// 显示购买数量模态框
  Future<dynamic> _showBuyCountModal(
    ProductDetailModel model,
    ProductDetailPageProvider provider,
  ) {
    List<String> imgUrlList = model.partData.loopImgUrl;

    return showModalBottomSheet(
      backgroundColor: AppColors.transparent,
      context: context,
      builder: (builder) {
        return ChangeNotifierProvider.value(
          value: provider,
          child: Stack(
            children: [
              // 背景颜色
              Container(
                // Container没有子元素的时候，默认充满父容器大小
                margin: EdgeInsets.only(top: 20),
                // width: double.infinity,  // 可不设置，建议设置
                // height: double.infinity, // 可不设置，建议设置
                color: Colors.white,
              ),
              // 顶部：图片 价格和已选 和关闭按钮
              Container(
                // color: Colors.pink,
                child: Row(
                  // 默认充满父容器大小
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Image.asset(
                        'assets${imgUrlList[1]}',
                        width: 90.0,
                        height: 90.0,
                      ),
                    ),
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // 不设置该属性，第一行与第二行左边会不对齐
                      children: [
                        SizedBox(
                          height: 30.0,
                        ),
                        // 价格
                        Price(
                          price: '${model.partData.price}',
                        ),
                        // 设置间距
                        SizedBox(height: 10.0),
                        PrimaryText(text: '已选${model.partData.count}件'),
                      ],
                    ),
                    // 占位容器，充满剩余空间
                    Spacer(),
                    _buildCloseButton(
                      context,
                      margin: EdgeInsets.only(top: 20.0),
                      onPressed: () {
                        // 关闭 添加商品件数模态框
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),

              // 中间：选择商品数量 加减号
              Container(
                margin: EdgeInsets.only(top: 90, bottom: 50),
                padding: EdgeInsets.only(top: 40, left: 40, right: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PrimaryText(
                      text: '数量',
                      fontSize: 14.0,
                    ),
                    Spacer(),
                    Consumer<ProductDetailPageProvider>(
                        builder: (_, tmpProvider, __) {
                      return PrimaryCounter(
                        count: model.partData.count,
                        onAdd: () {
                          // 增加商品
                          LogUtil.d('增加商品');
                          provider.changeProductCount(model.partData.count + 1);
                        },
                        onDeduct: () {
                          // 减少商品
                          LogUtil.d('减少商品');
                          if (model.partData.count > 1) {
                            provider
                                .changeProductCount(model.partData.count - 1);
                          } else {
                            LogUtil.d('当前商品数量已减至最低');
                          }
                        },
                      );
                    })
                  ],
                ),
              ),

              // 底部：加入购物车
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: PrimaryButton(
                  height: 50.0,
                  color: AppColors.white,
                  bgColor: AppColors.lightRed,
                  text: '加入购物车',
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  onTap: () {
                    // 加入购物车
                    Provider.of<CartProvider>(
                      context,
                      listen: false,
                    ).addToCart(model.partData);
                    // 关闭弹框
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
