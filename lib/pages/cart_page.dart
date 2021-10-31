import 'package:flutter/material.dart';
import 'package:flutter_jdapp/providers/cart_provider.dart';
import 'package:provider/provider.dart';

/// 购物车页面
class CartPage extends StatefulWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (_, provider, __) {
      return Scaffold(
        appBar: AppBar(
          title: Text('购物车'),
        ),
        body: Text('这是购物车'),
      );
    });
  }
}
