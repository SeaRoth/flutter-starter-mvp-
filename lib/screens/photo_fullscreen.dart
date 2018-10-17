import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {

  final mImage;
  const PostItem({Key key, this.mImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new DecoratedBox(
      decoration: new BoxDecoration(
        image: new DecorationImage(
            image: new AssetImage('images/flaps.jpg'),
            fit: BoxFit.fill
        ),
      ),
    );
  }
}
