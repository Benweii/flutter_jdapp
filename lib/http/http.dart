import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_jdapp/utils/log_util.dart';

class ComResponse<T> {
  int code;
  String msg;
  T data;

  ComResponse({this.code, this.msg, this.data});
}

class Http {
  static var dio = new Dio();

  static Future request(String path,
      {Map<String, dynamic> queryParams,
      dynamic data,
      String method = 'get'}) async {
    try {
      Response resp = method == 'get'
          ? await dio.get(path, queryParameters: queryParams)
          : await dio.post(path, data: data);

      var respData = resp.data;

      if (resp.statusCode == 200) {
        print('http request===>请求成功=>${resp.realUri}');
      } else {
        print('http request===>请求失败=>${resp.realUri}');
      }

      // LogUtil.d('1===>resp===>${jsonDecode(respData)}'); // 无法decode
      // LogUtil.d('1===>code===>${respData(code)}');
      // LogUtil.d('1===>msg===>${respData['msg']}');
      // LogUtil.d('1===>data===>${respData['data']}');

      return ComResponse(
        code: respData['code'],
        msg: respData['msg'],
        data: respData['data'],
      );
    } on DioError catch (e) {
      // DioError 只会返回服务器的错误 500
      print(e.message);

      String message = e.message;

      if (e.type == DioErrorType.connectTimeout) {
        message = 'Connection Timeout';
      } else if (e.type == DioErrorType.receiveTimeout) {
        message = 'Receive Timeout';
      } else if (e.type == DioErrorType.response) {
        /// When the server response, but with a incorrect status, such as 404, 503...
        message = '404 server not found ${e.response.statusCode}';
      }

      return Future.error(message);
    }
  }
}
