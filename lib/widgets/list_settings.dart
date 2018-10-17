import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

Widget buildSettings({@required BuildContext context,}){

  return new Container(
    child: new Padding(padding: const EdgeInsets.all(8.0),
    child: new Column(
      children: <Widget>[
        new Text("sdfsdf"),
        new Text("sdfsdf"),

        _buildSwitchItem("BIG BOOBS?", true, null, true),


      ],
    ),),
  );
}

Widget _buildSwitchItem(var name, var value, var onChanged, bool isDark) =>
    new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new Text("$name",
            style: const TextStyle(
              fontSize: 11.0,
              color: Colors.orangeAccent,
              fontStyle: FontStyle.normal,
            )),
        new Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF39CEFD),
          activeTrackColor: isDark ? Colors.white30 : Colors.black26,
        ),
      ],
    );



