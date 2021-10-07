import 'package:flutter/foundation.dart';
import 'package:flutter_jdapp/configs/jd_api.dart';
import 'package:flutter_jdapp/http/http.dart';
import 'package:flutter_jdapp/models/product_info_model.dart';

class ProductListPageProvider with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMsg = '';
  List<ProductInfoModel> productList = [];

  /// 加载商品列表数据
  loadProductListPageData() {
    isLoading = true;
    isError = false;
    errorMsg = '';

    Http.request(JDApi.PRODUCTIONS_LIST).then((res) {
      isLoading = false;

      if (res.code != 200) {
        print('未请求到有效数据===>code=${res.code}');
        throw Future.error('未请求到有效数据');
      }

      if (res.data is List) {
        productList = res.data
            .map((e) => ProductInfoModel.fromJson(e))
            .toList()
            .cast<ProductInfoModel>();
      }

      notifyListeners();
    }).catchError((error) {
      print('loadProductListPageData===>error===>');
      print(error);
      errorMsg = error;
      isLoading = false;
      isError = true;

      notifyListeners();
    });
  }
}
