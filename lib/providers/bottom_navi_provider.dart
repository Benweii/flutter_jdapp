import 'package:flutter/foundation.dart';

class BottomNaviProvider with ChangeNotifier {
  int bottomActiveNaviIndex = 1;

  void changeBottomActiveNaviIndex(int index) {
    bottomActiveNaviIndex = index;
    notifyListeners();
  }
}
