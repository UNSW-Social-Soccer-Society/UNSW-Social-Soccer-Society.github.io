import 'package:flutter/foundation.dart';

class TimerState with ChangeNotifier {
  bool isRunning = false;

  void update(bool newValue) {
    isRunning = newValue;
    notifyListeners();
  }
}
