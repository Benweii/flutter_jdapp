import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_jdapp/models/product_detail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  List<PartData> models = [];

  static const String CART_INFO_KEY = 'cartInfo';

  Future<void> addToCart(PartData data) async {
    // print(data.toJson()); // 输出非标准json格式：不带引号的json格式
    // print(jsonEncode(data.toJson())); // 输出标准json格式：带有引号的json格式
    print('1===>${jsonEncode(data)}'); // 输出标准json格式：带有引号的json格式

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 存入缓存 测试
    // List<String> list = [];
    // list.add(jsonEncode(data));
    // prefs.setStringList('cartInfo', list);

    // 取出缓存 测试
    // list = prefs.getStringList('cartInfo');
    // print('2===>$list');

    // 先从缓存中把数据取出来
    List<String> list = [];
    list = prefs.getStringList(CART_INFO_KEY);

    // 判断取出来的list有没有数据
    if (list == null) {
      // 缓存中没有数据直接存
      print('缓存中没有任何商品数据');
      // 将传递过来的数据存到缓存数据中
      list = [];
      list.add(jsonEncode(data));
      // 存到缓存中
      prefs.setStringList(CART_INFO_KEY, list);
      // 更新本地数据
      this.models.add(data);
      // 通知听众 可提取到外面
      // notifyListeners();
    } else {
      print('缓存中有商品数据');
      // 是否更新已缓存过的数据标识位
      bool isUpdate = false;
      List<String> tmpList = [];

      // 缓存中有数据，需判断是否已经存过该数据
      for (var item in list) {
        PartData tmpData = PartData.fromJson(jsonDecode(item));

        // 判断商品id是否相同
        if (tmpData.id == data.id) {
          tmpData.count = data.count;
          isUpdate = true;
        }

        // 更新缓存数据（磁盘中数据）
        tmpList.add(jsonEncode(tmpData));
        // 更新本地数据（内存中数据）
        this.models.add(tmpData);
      }

      // 缓存中没有数据，直接添加
      if (!isUpdate) {
        // 更新缓存数据（磁盘中数据）
        tmpList.add(jsonEncode(data));
        // 更新本地数据（内存中数据）
        this.models.add(data);
      }

      // 把数据存到缓存中
      prefs.setStringList(CART_INFO_KEY, tmpList);

      // 通知听众 可提取到外面
      // notifyListeners();
    }

    // 通知听众
    notifyListeners();
  }

  // 获取已添加商品总数
  int getAllCount() {
    int count = 0;
    for (PartData item in this.models) {
      count += item.count;
    }
    return count;
  }
}
