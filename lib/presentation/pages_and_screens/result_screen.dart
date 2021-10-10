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
  String comment = " ";
  Status status = Status.Normal;
  final DateTime dateTime = DateTime.now();
  late final int BPM;

  Color lightPink = new Color(0xFFFFF1F3);
  Color pink = new Color(0xFFFF6A89);

  _ResultScreenState({
    required this.BPM,
  });

  bool _isRestDisable = false;
  bool _isNormalDisable = false;
  bool _isActiveDisable = false;

  final _controller = TextEditingController();

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
                  Navigator.of(context).pop();
                },
                //TODO: make a showDialog how to use
                icon: Icon(
                  CustomIcons.cross_icon,
                  color: Colors.black,
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
                    child:
                        SvgPicture.asset('assets/svg/measurement_second.svg'),
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
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Stack(
                      children: [
                        CustomPaint(
                          size: Size(width, 122),
                          painter: ChipPainter(),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 0, 24),
                          child: Text(
                            'What is your current status?',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 60),
                          //padding: const EdgeInsets.fromLTRB(16, 60, 0, 0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                                child: ElevatedButton(
                                  onPressed: _isRestDisable
                                      ? null
                                      : () => setState(() {
                                            _isRestDisable = true;
                                            _isNormalDisable = false;
                                            _isActiveDisable = false;
                                            status = Status.Rest;
                                          }),
                                  child: Text('Rest'),
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.disabled))
                                            return Color.fromRGBO(
                                                255, 106, 137, 1);
                                          return Color.fromRGBO(
                                              255, 241, 243, 1);
                                        },
                                      ),
                                      fixedSize: MaterialStateProperty
                                          .resolveWith<Size>(
                                        (states) => Size(85, 46),
                                      ),
                                      foregroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.disabled))
                                          return Color.fromRGBO(
                                              255, 255, 255, 1);
                                        return Color.fromRGBO(255, 106, 137, 1);
                                      }),
                                      shape: MaterialStateProperty.resolveWith<
                                              RoundedRectangleBorder>(
                                          (Set<MaterialState> states) {
                                        return RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                          side: BorderSide(color: pink),
                                        );
                                      })),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                child: ElevatedButton(
                                  onPressed: _isNormalDisable
                                      ? null
                                      : () => setState(() {
                                            _isRestDisable = false;
                                            _isNormalDisable = true;
                                            _isActiveDisable = false;
                                            status = Status.Normal;
                                          }),
                                  child: Text('Normal'),
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.disabled))
                                            return Color.fromRGBO(
                                                255, 106, 137, 1);
                                          return Color.fromRGBO(
                                              255, 241, 243, 1);
                                        },
                                      ),
                                      fixedSize: MaterialStateProperty
                                          .resolveWith<Size>(
                                        (states) => Size(108, 46),
                                      ),
                                      foregroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.disabled))
                                          return Color.fromRGBO(
                                              255, 255, 255, 1);
                                        return Color.fromRGBO(255, 106, 137, 1);
                                      }),
                                      shape: MaterialStateProperty.resolveWith<
                                              RoundedRectangleBorder>(
                                          (Set<MaterialState> states) {
                                        return RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                          side: BorderSide(color: pink),
                                        );
                                      })),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                child: ElevatedButton(
                                  onPressed: _isActiveDisable
                                      ? null
                                      : () => setState(() {
                                            _isRestDisable = false;
                                            _isNormalDisable = false;
                                            _isActiveDisable = true;
                                            status = Status.Active;
                                          }),
                                  child: Text('Active'),
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.disabled))
                                            return Color.fromRGBO(
                                                255, 106, 137, 1);
                                          return Color.fromRGBO(
                                              255, 241, 243, 1);
                                        },
                                      ),
                                      fixedSize: MaterialStateProperty
                                          .resolveWith<Size>(
                                        (states) => Size(100, 46),
                                      ),
                                      foregroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.disabled))
                                          return Color.fromRGBO(
                                              255, 255, 255, 1);
                                        return Color.fromRGBO(255, 106, 137, 1);
                                      }),
                                      shape: MaterialStateProperty.resolveWith<
                                              RoundedRectangleBorder>(
                                          (Set<MaterialState> states) {
                                        return RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                          side: BorderSide(color: pink),
                                        );
                                      })),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(width, 122),
                        painter: ChipPainter(),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 0, 24),
                        child: Text(
                          'Comment',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 42, 16, 16),
                        child: TextField(
                          onChanged: (_) => setState(() {

                          }),
                          maxLength: 140,
                          controller: _controller,
                          decoration: InputDecoration(
                            suffixText: (140 - _controller.text.length).toString(),
                            counterStyle: TextStyle(
                              height: double.minPositive,
                            ),
                            counterText: "",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: lightPink),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: lightPink),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: 'Any additional information',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Center(
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
                      setState(() {
                        comment = _controller.text;
                      });
                      await MeasurementDataBase.instance.create(new Measurement(
                          BPM: BPM,
                          status: status,
                          comment: comment,
                          dateTime: dateTime));
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => HomePage()),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
