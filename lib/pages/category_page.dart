import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdapp/components/loading.dart';
import 'package:flutter_jdapp/components/nav_menu.dart';
import 'package:flutter_jdapp/components/menu.dart';
import 'package:flutter_jdapp/components/my_title.dart';
import 'package:flutter_jdapp/configs/app_colors.dart';
import 'package:flutter_jdapp/models/category_content_model.dart';
import 'package:flutter_jdapp/pages/product_list_page.dart';
import 'package:flutter_jdapp/providers/category_page_provider.dart';
import 'package:flutter_jdapp/utils/log_util.dart';
import 'package:provider/provider.dart';

/// 商品分类页面
class CategoryPage extends StatefulWidget {
  const CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoryPageProdiver>(
      create: (contetc) {
        var provider = new CategoryPageProdiver();
        provider.loadCategoryNavData();
        return provider;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('分类'),
          centerTitle: true,
        ),
        body: Container(
          color: AppColors.bgColor,
          child: Consumer<CategoryPageProdiver>(
            builder: (_, provider, __) {
              LogUtil.d('categoryNavList===>${provider.categoryNavList}');

              // 加载动画
              if (provider.isLoading && provider.categoryNavList.length == 0) {
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
                          provider.loadCategoryNavData();
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                );
              }

              return Row(
                children: [
                  /// 左侧 分类导航菜单
                  _buildNavMenus(provider),

                  /// 右侧 分类内容
                  _buildCategoryContent(provider),
                ],
              );

              // return Container(child: Text('这是一个空白页面'));
            },
          ),
        ),
      ),
    );
  }

  /// 左侧 分类导航菜单
  Container _buildNavMenus(CategoryPageProdiver provider) {
    return Container(
      width: 90,
      child: ListView.builder(
        itemCount: provider.categoryNavList.length,
        itemBuilder: (context, index) {
          return NavMenu(
            bgColor: provider.currentIndex == index
                ? AppColors.white
                : AppColors.color_f8f8f8,
            title: provider.categoryNavList[index],
            titleColor:
                provider.currentIndex == index ? AppColors.lightRed : null,
            onTap: () {
              print('你点击了菜单===>${provider.categoryNavList[index]}');
              provider.loadCategoryContentData(index);
            },
          );
        },
      ),
    );
  }

  /// 右侧 分类内容
  _buildCategoryContent(CategoryPageProdiver provider) {
    List<CategoryContentModel> contentList = provider.categoryContentList;

    return Expanded(
      child: Container(
        width: double.infinity,
        color: AppColors.white,
        child: contentList.length == 0
            ? Loading()
            : ListView.builder(
                itemCount: contentList.length,
                itemBuilder: (context, index) {
                  CategoryContentModel item = contentList[index];

                  /// 商品分类 子元素
                  return Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 子分类 标题
                        MyTitle(
                          title: item.title,
                        ),
                        // 子分类 内容
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Wrap(
                            spacing: 7,
                            runSpacing: 10,
                            alignment: WrapAlignment.start,
                            children: item.desc
                                .map((e) => Menu(
                                      padding: EdgeInsets.only(top: 3, left: 6),
                                      iconUrl: 'assets${e.img}',
                                      iconWidth: 50,
                                      iconHeight: 50,
                                      title: e.text,
                                      onTap: () {
                                        // 跳转子分类商品列表页面
                                        // print('你点击了===>${e.text}');
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => ProductListPage(
                                            title: e.text,
                                          ),
                                        ));
                                      },
                                    ))
                                .toList(),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
