import 'package:flutter/foundation.dart';
import 'package:livewebtv/utils/consts/consts.dart';

class ThemeProvider extends ChangeNotifier {
  int _colorIndex = 0;

  int get colorIndex => _colorIndex;

  setColorIndex(index) {
    _colorIndex = index;
    notifyListeners();
  }
}
