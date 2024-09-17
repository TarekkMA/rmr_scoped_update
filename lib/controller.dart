import 'package:flutter/material.dart';

class Controller extends ChangeNotifier {
  List<int> counters = List.generate(20, (i) => 0);

  void incrementCounter(int index) {
    counters[index]++;
    notifyListeners();
  }

  void decrementCounter(int index) {
    counters[index]--;
    notifyListeners();
  }
}
