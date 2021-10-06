import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdapp/configs/jd_api.dart';
import 'package:flutter_jdapp/http/http.dart';
import 'package:flutter_jdapp/utils/log_util.dart';

class CategoryPageProdiver with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMsg = '';
  // 业务数据
  List<String> categoryNavList = [];

  // 请求左侧分类导航菜单列表
  loadCategoryNavList() {
    isLoading = true;
    isError = false;
    errorMsg = '';

    Http.request(JDApi.CATEGORY_NAV).then((res) {
      isLoading = false;

      if (res.code != 200) {
        throw Future.error('未请求到有效数据');
      }

      if (res.data is List) {
        categoryNavList = res.data.map((e) => e).toList();
      }

      notifyListeners();
    }).catchError((error) {
      LogUtil.d(error);
      errorMsg = error;
      isLoading = false;
      isError = true;

      notifyListeners();
    });
  }
}
