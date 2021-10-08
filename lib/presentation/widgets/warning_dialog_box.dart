import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WarningDialogBox extends StatefulWidget {

  //const CustomDialogBox({required Key key}) : super(key: key);

  @override
  _WarningDialogBoxState createState() => _WarningDialogBoxState();
}

class _WarningDialogBoxState extends State<WarningDialogBox> {

  double radius = 24;

  Color lightPink = new Color(0xFFFFF1F3);
  Color pink = new Color(0xFFFF6A89);


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            width: 343,
            height: 393,
            padding: EdgeInsets.fromLTRB(0, 36, 0, 24),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Column(
                //mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset('assets/svg/picture_info.svg'),
                  SizedBox(height: 35),
                  Text('Make sure you\'re still covering\n'
                      'the camera and the flashlight.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Okay'),
                    style: ElevatedButton.styleFrom(
                      primary: pink,
                      fixedSize: Size(224, 46),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(radius),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
