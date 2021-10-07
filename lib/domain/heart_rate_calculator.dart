import 'package:flutter/cupertino.dart';

class HeartRateCalculator extends ValueNotifier<int>{
  late List<int> _list = [];

  HeartRateCalculator() : super(0);

  addValue(int rate) {
    _list.add(rate);
    value++;
  }

  int calculate() {
    //int amount = value;
    int count = 0;
    for (int i = 0; i < _list.length; i++) {
      count+= _list[i];
    }
    return count ~/ _list.length;
  }

  void cleanList() {
    _list = [];
    value = 0;
  }
}