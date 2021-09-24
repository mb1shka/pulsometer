import 'dart:async';

import 'package:flutter/widgets.dart';

class HeartRateListener with ChangeNotifier {

  HeartRateListener({
    required this.currentValue,
});

  int currentValue = 0;

  int _AVGRate = 0;
  //средний пульс

  int counter = 1;
  int _allCountedHeartRates = 0;

  int get getAVGRate => _AVGRate;
  // avgrate getter

  StreamSubscription? _timer;
  StreamSubscription? _minuteTimer;
  final interval = const Duration(milliseconds: 1);
  final minuteInterval = const Duration(minutes: 1, milliseconds: 2);


  void measurement() {
    _minuteTimer = Stream<void>.periodic(minuteInterval).listen((event) {
      _AVGRate = 0;
      counter = 1;
      _allCountedHeartRates = 0;
      _timer = Stream<void>.periodic(interval).listen((event) {
        _allCountedHeartRates = _allCountedHeartRates + currentValue;
        _AVGRate = (_allCountedHeartRates / counter) as int;
        counter++;
        notifyListeners();
      });
    });
    /*_AVGRate = 0;
    counter = 1;
    _allCountedHeartRates = 0;
    _timer = Stream<void>.periodic(interval).listen((event) {
      _allCountedHeartRates = _allCountedHeartRates + currentValue;
      _AVGRate = (_allCountedHeartRates / counter) as int;
      counter++;
      notifyListeners();
    });*/
  }
}