import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/cupertino.dart';

class ScrollableSingleChip extends StatefulWidget {
  @override
  _ScrollableSingleChipState createState() => _ScrollableSingleChipState();

}

class _ScrollableSingleChipState extends State<ScrollableSingleChip> {

  Color lightPink = new Color(0xFFFFF1F3);
  Color pink = new Color(0xFFFF6A89);

  int tag = 1;
  List<String> options = [
    'Rest',
    'Normal',
    'Active',
  ];

  @override
  Widget build(BuildContext context) {
    return ChipsChoice<int>.single(
        value: tag,
        onChanged: (val) => setState(() => tag = val),
        choiceItems: C2Choice.listFrom<int, String>(
          source: options,
          value: (i, v) => i,
          label: (i, v) => v,
          tooltip: (i, v) => v,
        ),
      choiceStyle: C2ChoiceStyle(
        borderColor: pink,
        color: lightPink,
        borderRadius: BorderRadius.circular(24),
      ),
      choiceActiveStyle: C2ChoiceStyle(
        color: pink,
      ),
    );
  }

}