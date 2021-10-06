import 'package:flutter/foundation.dart';

class BottomNaviProvider with ChangeNotifier {
  int bottomActiveNaviIndex = 0;

  void changeBottomActiveNaviIndex(int index) {
    bottomActiveNaviIndex = index;
    notifyListeners();
  }
}