import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heart_rate/data/database/measurement_database.dart';
import 'package:heart_rate/data/model/measurement.dart';
import 'package:heart_rate/data/model/status.dart';
import 'package:heart_rate/presentation/pages_and_screens/home_page.dart';
import 'package:heart_rate/presentation/pages_and_screens/statistics_page.dart';
import 'package:heart_rate/presentation/widgets/chip_painter.dart';
import 'package:heart_rate/presentation/widgets/choice_chips.dart';
import 'package:heart_rate/presentation/widgets/choice_chips_data.dart';
import 'package:heart_rate/presentation/widgets/scrollable_single_chip.dart';
import 'package:path/path.dart';

import '../../custom_icons.dart';

class ResultScreen extends StatefulWidget {
  // const ResultScreen({Key? key}) : super(key: key);
  final int BPM;

  ResultScreen(this.BPM);

  @override
  State<StatefulWidget> createState() => _ResultScreenState(BPM: BPM);
}

class _ResultScreenState extends State<ResultScreen> {
  //final Measurement _currentMeasurement;
  final String comment = " ";
  final Status status = Status.Normal;
  final DateTime dateTime = DateTime.now();
  late final int BPM;

  int index = 3;
  final double spacing = 8;

  Color lightPink = new Color(0xFFFFF1F3);

  Color pink = new Color(0xFFFF6A89);
  Color textColor = new Color(0xFFFF6A89);

  bool _useChisel = false;

  _ResultScreenState({
    required this.BPM,
  });

  List<ChoiceChipData> choiceChips = ChoiceChips.all;

  Widget buildChoiceChips() => Wrap(
    runSpacing: spacing,
    spacing: spacing,
    children: choiceChips
        .map((choiceChip) => ChoiceChip(
      label: Text(choiceChip.label),
      labelStyle: TextStyle(
          fontWeight: FontWeight.bold, color: textColor),
      onSelected: (isSelected) => setState(() {
        choiceChips = choiceChips.map((otherChip) {
          final newChip = otherChip.copy(isSelected: false);
          return choiceChip == newChip
              ? newChip.copy(isSelected: isSelected)
              : newChip;
        }).toList();
      }),
      selected: choiceChip.isSelected,
      selectedColor: pink,
      backgroundColor: lightPink,
    ))
        .toList(),
  );


  /* Widget choiceChips() {
    return Expanded(
        child: ListView.builder(
          itemCount: _choices.length,
          itemBuilder: (BuildContext context, int index) {
            return ChoiceChip(
              label: Text(_choices[index]),
              selected: _defaultChoiceIndex == index,
              selectedColor: pink,
              onSelected: (bool selected) {
                setState(() {
                  _defaultChoiceIndex = selected ? index : 0;
                });
              },
              backgroundColor: lightPink,
              labelStyle: TextStyle(
                color: lightPink,
              )
            );
          },
        ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 32;


    return SafeArea(
      child: Scaffold(
        backgroundColor: new Color(0xFFFFFFFF),
        appBar: AppBar(
          title: Text(
            'Result',
            style: TextStyle(
              color: new Color(0xFF121212),
              fontStyle: FontStyle.normal,
              fontSize: 17,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: new Color(0xFFFFFFFF),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => HomePage()),
                  );
                },
                //TODO: make a showDialog how to use
                icon: Icon(
                  CustomIcons.cross_icon,
                )),
          ],
        ),
        body: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
                  child: SvgPicture.asset('assets/svg/measurement_second.svg'),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
                  child: Text(
                    '$BPM  BPM',
                    style: TextStyle(
                      color: new Color(0xFFFF6A89),
                      fontSize: 48,
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                //child: Container(
                  /*width: MediaQuery.of(context).size.width - 32,
                  height: 122,*/
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(width, 122),
                        painter: ChipPainter(),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 0, 24),
                        child: Text('What is your current status?',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      /*Chip(
                        label: Text('Rest'),
                        labelPadding: EdgeInsets.fromLTRB(24, 13, 24, 13),
                        backgroundColor: ,
                      ),*/
                      /*ChoiceChip(
                          label: Text('Rest'),
                          selected: _useChisel,
                          selectedColor: pink,
                          onSelected: (bool newValue) {
                            setState(() {
                              _useChisel = newValue;
                            });
                          },
                          backgroundColor: lightPink,
                          labelStyle: TextStyle(
                            color: lightPink,
                          ),
                      ),*/
                      Padding(
                        padding: const EdgeInsets.all(60.0),
                        child: buildChoiceChips(),
                      ),
                    ],
                  ),
                //),
              ),
            ),
            /*Padding(
              padding: const EdgeInsets.only(top: 50),
              *//*child: ScrollableSingleChip(),*//*
              //child: Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _choices.length,
                itemBuilder: (BuildContext context, int index) {
                  return ChoiceChip(
                    label: Text(_choices[index]),
                    selected: _defaultChoiceIndex == index,
                    selectedColor: pink,
                    onSelected: (bool selected) {
                      setState(() {
                        _defaultChoiceIndex = selected ? index : 0;
                      });
                    },
                    backgroundColor: lightPink,
                    labelStyle: TextStyle(
                      color: lightPink,
                    ),
                  );
                },
              ),
              //),
            ),*/
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(255, 106, 137, 1),
                  fixedSize: Size(224, 46),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 17,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                onPressed: () async {
                  await MeasurementDataBase.instance.create(new Measurement(
                      BPM: BPM,
                      status: status,
                      comment: comment,
                      dateTime: dateTime));
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => HomePage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
