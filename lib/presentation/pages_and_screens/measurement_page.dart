import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_bpm/chart.dart';
import 'package:heart_bpm/heart_bpm.dart';
import 'package:heart_rate/custom_icons.dart';
import 'package:heart_rate/data/listeners/heart_rate_listener.dart';
import 'package:heart_rate/domain/heart_rate_calculator.dart';
import 'package:heart_rate/domain/shared_preferences/my_shared_preferences.dart';
import 'package:heart_rate/presentation/pages_and_screens/home_page.dart';
import 'package:heart_rate/presentation/pages_and_screens/result_screen.dart';
import 'package:heart_rate/presentation/widgets/measurement_start_position.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';

class MeasurementPage extends StatefulWidget {
  const MeasurementPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MeasurementPageState();
}

class _MeasurementPageState extends State<MeasurementPage> {
  HeartRateCalculator _heartRateCalculator = new HeartRateCalculator();
  List<SensorValue> data = [];
  //Widget chart = BPMChart(data);

  String btnText = "Start";
  bool isBPMEnabled = false;
  var btnTextColor = Color.fromRGBO(255, 255, 255, 1);
  late Widget dialog;
  int currentValue = 0;
  int middleValue = 0;

  bool _isDisable = false;

  bool _toMeasure = true;
  bool _toRestart = false;

  late Timer _timer;
  int _start = 10;

  @override
  void dispose() {
    // _timer.cancel(); // проверить задан ли таймер
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: new Color(0xFFFFFFFF),
        appBar: AppBar(
          title: Text(
            'Measurement',
            style: TextStyle(
              color: new Color(0xFF121212),
              fontStyle: FontStyle.normal,
              fontSize: 17,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: new Color(0xFFFFFFFF),
          actionsIconTheme: IconThemeData(
            color: new Color(0xFFFF6A89),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                //TODO: make a showDialog how to use
                icon: Icon(
                  CustomIcons.info,
                )),
          ],
        ),
        body: Column(
          children: [
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
              child: Center(
                child: SvgPicture.asset('assets/svg/measurement_hearts.svg'),
              ),
            )),
            SafeArea(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                    child: Center(
                      child:
                          SvgPicture.asset('assets/svg/measurement_second.svg'),
                    ),
                  ),
                  _isDisable ? Text(
                    '$currentValue BPM',
                    style: TextStyle(
                      color: new Color(0xFFFF6A89),
                      fontSize: 48,
                    ),
                  ) : Text(
                    '$middleValue BPM',
                    style: TextStyle(
                      color: new Color(0xFFFF6A89),
                      fontSize: 48,
                    ),
                  ),
                ],
              ),
            ),
            isBPMEnabled
                ? dialog = Column(
                    children: [
                      HeartBPMDialog(
                        context: context,
                        onRawData: (value) {
                          setState(() {
                            if (data.length == 100) data.removeAt(0);
                            data.add(value);
                          });
                          // chart = BPMChart(data);
                        },
                        onBPM: (value) {
                          setState(() {
                            //print("new bpm value: $value");
                            currentValue = value;
                            //_heartRateCalculator.addValue(value);
                            //TODO: точно ли этот метод должен быть здесь?
                            // HeartRateListener(currentValue: value);
                          });
                        },
                        // sampleDelay: 1000 ~/ 20,
                        // child: Container(
                        //   height: 50,
                        //   width: 100,
                        //   child: BPMChart(data),
                        // ),
                      ),
                    ],
                  )
                : SizedBox(),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 49.0),
                child: ElevatedButton(
                  /*style: ElevatedButton.styleFrom(
                       primary: _isDisable? Color.fromRGBO(255, 241, 243, 1) : Color.fromRGBO(255, 106, 137, 1),
                       fixedSize: Size(224, 46),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(24.0),
                       )),*/
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled))
                            return Color.fromRGBO(255, 241, 243, 1);
                          return Color.fromRGBO(255, 106, 137, 1);
                        },
                      ),
                      fixedSize: MaterialStateProperty.resolveWith<Size>(
                        (states) => Size(224, 46),
                      ),
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        // if (states.contains(MaterialState.disabled))
                        //   return Color.fromRGBO(255, 255, 255, 1);
                        return Color.fromRGBO(255, 106, 137, 1);
                      }),
                      shape: MaterialStateProperty.resolveWith<
                          RoundedRectangleBorder>((Set<MaterialState> states) {
                        return RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        );
                      })),
                  child: Text(
                    btnText,
                    style: TextStyle(
                      fontSize: 17,
                      fontStyle: FontStyle.normal,
                      color: btnTextColor,
                    ),
                  ),
                  onPressed: _isDisable
                      ? null
                      : _toMeasure
                          ? () => setState(() {
                                //_measurement();
                                _isDisable = true;

                                //timer = 60 sec
                                if (isBPMEnabled) {
                                  isBPMEnabled = false;
                                  // dialog.
                                } else
                                  isBPMEnabled = true;

                                const oneSec = const Duration(seconds: 1);
                                _timer = new Timer.periodic(
                                  oneSec,
                                  (Timer timer) {
                                    if (_start == 0) {
                                      setState(() {
                                        middleValue =
                                            _heartRateCalculator.calculate();
                                        _heartRateCalculator.cleanList();
                                        timer.cancel();
                                        isBPMEnabled = false;
                                        _toMeasure = false;
                                        _isDisable = false;
                                        _toRestart = true;
                                        btnText = "Save measurement";
                                        btnTextColor =
                                            Color.fromRGBO(255, 255, 255, 1);
                                        ResultScreen(middleValue);
                                        //_measurementCancel();
                                      });
                                    } else {
                                      btnTextColor =
                                          Color.fromRGBO(255, 106, 137, 1);
                                      setState(() {
                                        _heartRateCalculator
                                            .addValue(currentValue);
                                        _start--;
                                        btnText = "$_start sec left";
                                      });
                                    }
                                  },
                                );
                              })
                          : () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => ResultScreen(middleValue)),
                              ),
                ),
              ),
            ),
            _toRestart ? Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => HomePage()),
                ),
                child: Text('Restart',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 106, 137, 1),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(255, 255, 255, 1),
                  /*fixedSize: Size(224, 46),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),*/
                ),
              ),
            ) : SizedBox(),
            /*Center(
              child: Text('Time left: $_start'),
            ),
            Center(
              //child: Text("${context.watch<HeartRateListener>().getAVGRate}"),
              child: Text("Middle value is: $middleValue"),
            )*/
          ],
        ),
      ),
    );
    /*return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: MeasurementStart(),
                ),
                ElevatedButton(
                  onPressed: () {},
                      child: Text("Press here to start"),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    shadowColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  ),
              ],
            ),
          ),
        ),
    );*/
  }
}
