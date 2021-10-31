import 'package:flutter/material.dart';
import 'package:flutter_jdapp/pages/index_page.dart';
import 'package:flutter_jdapp/providers/bottom_navi_provider.dart';
import 'package:flutter_jdapp/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // 解决报错问题：MissingPluginException(No implementation found for method getAll on channel plugins.flutter.io/shared_preferences)
  // 实际验证是热加载有问题，可以不用加这段代码，重新运行下程序就行了
  // SharedPreferences.setMockInitialValues({});

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: BottomNaviProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (BuildContext context) {
            return CartProvider();
          },
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '京东商城',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: IndexPage(),
    );
  }
}
