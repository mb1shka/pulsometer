import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../custom_icons.dart';

class SettingsContainer extends StatefulWidget {
  @override
  _SettingsContainerState createState() => _SettingsContainerState();
}

class _SettingsContainerState extends State<SettingsContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
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
        /*actions: [
          IconButton(
              onPressed: () {},
              //TODO: make a showdialog how to use
              icon: Icon(
                CustomIcons.info,
              )
          ),
        ],*/
      ),
      body: Column(children: <Widget>[
        ElevatedButton(
          onPressed: () {},
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  CustomIcons.group,
                  color: new Color.fromRGBO(255, 106, 137, 1),
                ),
              ),
              Text(
                "Support",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
            ],
            //mainAxisAlignment: MainAxisAlignment.center,
          ),
          style: ButtonStyle(
            //foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            backgroundColor: MaterialStateProperty.all<Color>(
                new Color.fromRGBO(255, 241, 243, 1)),
            //shadowColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                //side: BorderSide(color: Colors.black),
              ),
            ),/*
            fixedSize: MaterialStateProperty.resolveWith<Size>(
              (states) => Size(343, 52),
            ),*/
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(
                  CustomIcons.privacy,
                  color: new Color.fromRGBO(255, 106, 137, 1),
                ),
              ),
              Text(
                "Privacy Policy",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
            ],
            //mainAxisAlignment: MainAxisAlignment.center,
          ),
          style: ButtonStyle(
            //foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            backgroundColor: MaterialStateProperty.all<Color>(
                new Color.fromRGBO(255, 241, 243, 1)),
            //shadowColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                //side: BorderSide(color: Colors.black),
              ),
            ),/*
            fixedSize: MaterialStateProperty.resolveWith<Size>(
              (states) => Size(343, 52),
            ),*/
          ),
        ),
      ]),
    );
  }
}
