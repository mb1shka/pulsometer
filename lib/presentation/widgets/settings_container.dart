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
        title: Text('Settings',
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
              //TODO: make a showdialog how to use
              icon: Icon(
                CustomIcons.info,
              )
          ),
        ],
      ),
        body: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
                children:[
                  ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(Icons.support_agent_outlined),
                        Text("Support"),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      shadowColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(Icons.privacy_tip_outlined),
                        Text("Privacy Policy"),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      shadowColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ]
            ),
          ),
        ]),
    );
  }
}