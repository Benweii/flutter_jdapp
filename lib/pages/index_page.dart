import 'package:flutter/material.dart';
import 'package:flutter_jdapp/pages/cart_page.dart';
import 'package:flutter_jdapp/pages/category_page.dart';
import 'package:flutter_jdapp/pages/home_page.dart';
import 'package:flutter_jdapp/pages/mine_page.dart';
import 'package:flutter_jdapp/providers/bottom_navi_provider.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomNaviProvider>(
        builder: (_, bottomNaviProvider, __) => IndexedStack(
          index: bottomNaviProvider.bottomActiveNaviIndex,
          children: [
            HomePage(),
            CategoryPage(),
            CartPage(),
            MinePage(),
          ],
        ),
      ),
      bottomNavigationBar: Consumer<BottomNaviProvider>(
        builder: (_, bottomNaviProvider, __) => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: bottomNaviProvider.bottomActiveNaviIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '首页',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: '分类',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: '购物车',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: '我的',
            ),
          ],
          onTap: (index) {
            // setState(() {
            //   bottomNaviProvider.bottomActiveNaviIndex = index;
            // });

            bottomNaviProvider.changeBottomActiveNaviIndex(index);
          },
        ),
      ),
    );
  }
}
