import 'package:flutter/material.dart';
import 'choice_chips_data.dart';

class ChoiceChips {

  Color lightPink = new Color(0xFFFFF1F3);
  Color pink = new Color(0xFFFF6A89);


  static final all = <ChoiceChipData>[
    ChoiceChipData(
      label: 'Rest',
      isSelected: false,
      selectedColor: new Color(0xFFFF6A89),
      textColor: new Color(0xFFFFF1F3),
    ),
    ChoiceChipData(
      label: 'Normal',
      isSelected: false,
      selectedColor: new Color(0xFFFF6A89),
      textColor: new Color(0xFFFFF1F3),
    ),
    ChoiceChipData(
      label: 'Active',
      isSelected: false,
      selectedColor: new Color(0xFFFF6A89),
      textColor: new Color(0xFFFFF1F3),
    ),
  ];
}
