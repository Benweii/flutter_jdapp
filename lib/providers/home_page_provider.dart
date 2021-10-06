import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_jdapp/configs/jd_api.dart';
import 'package:flutter_jdapp/http/http.dart';
import 'package:flutter_jdapp/models/home_page_model.dart';
import 'package:flutter_jdapp/utils/log_util.dart';

class HomePageProvider with ChangeNotifier {
  HomePageModel model;
  bool isLoading = false;
  bool isError = false;
  String errorMsg = '';

  loadHomePageData() {
    isLoading = true;
    isError = false;
    errorMsg = '';

    Http.request(JDApi.HOME_PAGE).then((res) {
      isLoading = false;
      if (res.code == 200) {
        // print('4===>${res.data}');
        model = HomePageModel.fromJson(res.data);
        // print('4===>swipers===>${jsonEncode(model.swipers)}');  // 可以正常输出json数据
      }
      notifyListeners();
    }).catchError((error) {
      print('loadHomePageData===>error===>');
      print(error);
      errorMsg = error;
      isLoading = false;
      isError = true;
      notifyListeners();
    });
  }
}
