import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jdapp/configs/jd_api.dart';
import 'package:flutter_jdapp/http/http.dart';
import 'package:flutter_jdapp/models/category_content_model.dart';
import 'package:flutter_jdapp/utils/log_util.dart';

class CategoryPageProdiver with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMsg = '';
  // 分类菜单列表
  List<String> categoryNavList = [];
  // 分类内容
  List<CategoryContentModel> categoryContentList = [];
  // 当前选中索引
  int currentIndex = 0;

  // 请求左侧分类导航菜单列表
  loadCategoryNavData() {
    isLoading = true;
    isError = false;
    errorMsg = '';

    Http.request(JDApi.CATEGORY_NAV).then((res) {
      isLoading = false;

      if (res.code != 200) {
        print('未请求到有效数据===>code=${res.code}');
        throw Future.error('未请求到有效数据');
      }

      // print('navList===>${res.data}');
      if (res.data is List) {
        categoryNavList = res.data.cast<String>();
      }

      loadCategoryContentData(currentIndex);

      notifyListeners();
    }).catchError((error) {
      LogUtil.d(error);
      errorMsg = error;
      isLoading = false;
      isError = true;

      notifyListeners();
    });
  }

  // 请求右侧分类内容
  loadCategoryContentData(int index) {
    isLoading = true;
    isError = false;
    errorMsg = '';

    currentIndex = index;

    // 清空历史数据，实现仅右侧局部加载刷新
    categoryContentList.clear();

    Http.request(
      JDApi.CATEGORY_CONTENT,
      data: {
        'title': categoryNavList[index],
      },
      method: 'post',
    ).then((res) {
      isLoading = false;

      if (res.code != 200) {
        print('未请求到有效数据===>code=${res.code}');
        throw Future.error('未请求到有效数据');
      }

      // print('navList===>${res.data}');
      if (res.data is List) {
        categoryContentList = res.data
            .map((e) => CategoryContentModel.fromJson(e))
            .toList()
            .cast<CategoryContentModel>();
      }
      // LogUtil.d(jsonEncode(categoryContentList));
      notifyListeners();
    }).catchError((error) {
      LogUtil.d(error);
      errorMsg = error;
      isLoading = false;
      isError = true;

      notifyListeners();
    });

    notifyListeners();
  }
}
