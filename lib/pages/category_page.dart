import 'package:flutter/material.dart';

/// 商品分类页面
class CategoryPage extends StatefulWidget {
  const CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分类'),
      ),
      body: Text('这是分类'),
    );
  }
}
