import 'package:flutter/foundation.dart';
import 'package:flutter_jdapp/configs/jd_api.dart';
import 'package:flutter_jdapp/http/http.dart';
import 'package:flutter_jdapp/models/product_detail_model.dart';

class ProductDetailPageProvider with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMsg = '';
  ProductDetailModel model;

  /// 加载商品详情数据
  loadProductDetailPageData({String id}) {
    isLoading = true;
    isError = false;
    errorMsg = '';

    Http.request(JDApi.PRODUCTIONS_DETAIL).then((res) {
      isLoading = false;

      if (res.code != 200) {
        print('未请求到有效数据===>code=${res.code}');
        throw Future.error('未请求到有效数据');
      }

      if (res.data is List) {
        for (var item in res.data) {
          if (item['partData']['id'] == id) {
            model = ProductDetailModel.fromJson(item);
          }
        }
      }
      print('loadProductDetail===>${model.toJson()}');

      notifyListeners();
    }).catchError((error) {
      print('loadProductDetailPageData===>error===>');
      print(error);
      errorMsg = error;
      isLoading = false;
      isError = true;

      notifyListeners();
    });
  }

  // 切换分期方式
  changePayWay(int index) {
    List<Baitiao> baitiao = this.model.baitiao;

    if (baitiao[index].select == false) {
      for (var i = 0; i < baitiao.length; i++) {
        baitiao[i].select = i == index;
      }

      notifyListeners();
    }
  }

  // 更改商品数量
  changeProductCount(int count) {
    if (count > 0 && count != this.model.partData.count) {
      this.model.partData.count = count;
      notifyListeners();
    }
  }
}
