import 'package:flutter/material.dart';

class StatItem extends StatelessWidget{
  final id;
  final name;
  final desc;
  final value;
  final void Function(dynamic) onShortPress;
  final void Function(dynamic) onLongPress;
  final isEven;

  const StatItem({Key key, this.id, this.name, this.desc, this.value, this.onShortPress, this.isEven, this.onLongPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(4.0),
      child: new Container(
        color: isEven == true ? Colors.white : Colors.blue,
        height: 50.0,
        child: new ListTile(
          onLongPress: () => onLongPress(id),
          onTap: () => onShortPress(id),
          title: new Text(name != null ? name : "",
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(color: isEven == true ? Colors.black : Colors.white,),
          ),
            dense: false,
            subtitle: new Text(desc != null ? desc : "",
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(color: isEven == true ? Colors.black : Colors.white,),),
            trailing: new Text(value != null ? value : "",
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(color: isEven == true ? Colors.black : Colors.white,),),
        ),
      ),
    );
  }
}