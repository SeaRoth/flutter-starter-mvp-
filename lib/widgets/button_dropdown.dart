


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonDropdown extends StatelessWidget{

  final String selectedProject;
  final List<String> projects;
  final void Function(String) callback;

  const ButtonDropdown({Key key, this.selectedProject, this.projects, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Container(
        decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white, width: 0.4),
          borderRadius: new BorderRadius.circular(4.0),
        ),
        child: new DropdownButton<String>(
          value: selectedProject,
          iconSize: 40.0,

          style: new TextStyle(

            color: Colors.yellow,
            fontSize: 25.0,
          ),

          elevation: 1,
          isDense: true,
          onChanged: (String newValue) {
            callback(newValue);
          },
          items: projects.map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Container(
                width: 120.0,
                child: new Text(value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}