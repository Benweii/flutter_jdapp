import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdapp/components/loading.dart';
import 'package:flutter_jdapp/components/menu.dart';
import 'package:flutter_jdapp/configs/app_colors.dart';
import 'package:flutter_jdapp/configs/jd_api.dart';
import 'package:flutter_jdapp/http/http.dart';
import 'package:flutter_jdapp/models/home_page_model.dart';
import 'package:flutter_jdapp/providers/home_page_provider.dart';
import 'package:flutter_jdapp/utils/log_util.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

/// 首页
class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // this.getData();
  }

  getData() async {
    var resp = await Http.request(JDApi.HOME_PAGE);
    print('2===>$resp');
  }

  @override
  Widget build(BuildContext context) {
    // Http.request(JDApi.HOME_PAGE).then((resp) => print('3===>$resp'));

    return ChangeNotifierProvider<HomePageProvider>(
      create: (BuildContext context) {
        var provider = new HomePageProvider();
        provider.loadHomePageData();
        return provider;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('首页'),
          centerTitle: true,
        ),
        body: Consumer<HomePageProvider>(
          builder: (_, provider, __) {
            // LogUtil.d('5===>${jsonEncode(provider.model)}');

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
                        provider.loadHomePageData();
                        setState(() {});
                      },
                    ),
                  ],
                ),
              );
            }

            HomePageModel model = provider.model;

            return ListView(
              children: [
                // 轮播图
                _buildBanners(model),
                // 图标分类
                _buildLogos(model),
                // 掌上秒杀
                _buildMS(model),
                // 底部广告
              ],
            );
          },
        ),
      ),
    );
  }

  /// 轮播图
  AspectRatio _buildBanners(HomePageModel model) {
    return AspectRatio(
      // 宽高通过比例自适应
      aspectRatio: 72 / 35, // 第一个改变位置，第二个改变大小
      child: Swiper(
        itemCount: model.swipers.length,
        pagination: SwiperPagination(),
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          // 'assets/image/jd1.jpg'
          return Image.asset('assets${model.swipers[index].image}');
        },
      ),
    );
  }

  /// 图标分类
  _buildLogos(HomePageModel model) {
    return Container(
      color: AppColors.white,
      height: 170,
      padding: EdgeInsets.all(10),
      child: Wrap(
        spacing: 7,
        runSpacing: 10,
        alignment: WrapAlignment.spaceBetween,
        children: model.logos
            .map((v) => Menu(
                  width: 60,
                  iconUrl: 'assets${v.image}',
                  title: v.title,
                ))
            .toList(),
      ),
    );
  }

  /// 掌上秒杀
  Widget _buildMS(HomePageModel model) {
    return Container(
      color: AppColors.white,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          // 掌上秒杀头部
          _buildMSHeader(model),
          // 掌上秒杀商品
          _buildMSGoods(model),
          // 广告1
          _buildAds(model.pageRow.ad1),
          // 广告2
          _buildAds(model.pageRow.ad2),
        ],
      ),
    );
  }

  /// 掌上秒杀头部
  Widget _buildMSHeader(HomePageModel model) {
    return Container(
      height: 50,
      child: Row(
        children: [
          Image.asset(
            'assets/image/bej.png',
            height: 20,
          ),
          Spacer(),
          Text('更多秒杀'),
          Icon(
            CupertinoIcons.right_chevron,
            size: 14,
          ),
        ],
      ),
    );
  }

  /// 掌上秒杀商品
  Widget _buildMSGoods(HomePageModel model) {
    if (!(model.quicks != null && model.quicks.length > 0)) {
      return Container();
    }

    // model.quicks.addAll(model.quicks);

    return Container(
      color: Colors.lightBlue,
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: model.quicks.length,
        itemBuilder: (BuildContext context, int index) {
          Quicks item = model.quicks[index];

          return Padding(
            padding: const EdgeInsets.only(
                top: 5.0, bottom: 5.0, left: 10, right: 10),
            child: Menu(
              iconUrl: 'assets${item.image}',
              iconWidth: 120.0, // 为什么宽度设置无效？
              iconHeight: 80,
              title: item.price,
              titleStyle: TextStyle(color: AppColors.red, fontSize: 16),
            ),
          );
        },
      ),
    );
  }

  /// 广告
  _buildAds(List<String> ads) {
    return Container(
      child: Row(
        children:
            ads.map((e) => Expanded(child: Image.asset('assets$e'))).toList(),
      ),
    );
  }
}
