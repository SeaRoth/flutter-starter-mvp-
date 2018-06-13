

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonNormal extends StatelessWidget{

  final text;
  final fn;
  final colorBg;
  final colorText;

  ButtonNormal({
    @required this.text,
    @required this.fn,
    @required this.colorBg,
    @required this.colorText,
  });

  @override
  Widget build(BuildContext context) {
    return new Padding(padding: new EdgeInsets.all(2.0),
      child: new Container(
          decoration: new BoxDecoration(
            border: new Border.all(
                width: 1.0,
                color: Colors.grey),
            borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
          ),
          child: new MaterialButton(
            onPressed:  () {
              fn();
            },
            color: colorBg,

            child: new Text(text,
              style: new TextStyle(color: colorText, fontSize: 10.0),),
          )
      ),
    );
  }


}