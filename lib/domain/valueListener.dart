import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'heart_rate_calculator.dart';

class ValueListener extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ValueListenerState();
}

class _ValueListenerState extends State<ValueListener> {
  late HeartRateCalculator _notifier;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: _notifier,
        builder: (context, value, child) => SizedBox(),
      ),
    );
  }

}