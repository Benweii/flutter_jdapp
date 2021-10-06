class JDApi {
  // api基地址
  static const String BASE_URL = 'https://flutter-jdapi.herokuapp.com/api';
  // 首页请求的json
  static const String HOME_PAGE = '$BASE_URL/profiles/homepage';
  // 分类页导航的json
  static const String CATEGORY_NAV = '$BASE_URL/profiles/navigationLeft';
  // 分类页的商品类目的json数据
  static const String CATEGORY_CONTENT = '$BASE_URL/profiles/navigationRight';
  // 商品列表接口
  static const String PRODUCTIONS_LIST = '$BASE_URL/profiles/productionsList';
  // 商品详情接口
  static const String PRODUCTIONS_DETAIL =
      '$BASE_URL/profiles/productionDetail';
}
