// Create a Form Widget
import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  final void Function(dynamic, dynamic, dynamic) onSubmit;
  const MyForm({Key key, this.onSubmit}) : super(key: key);
  @override
  MyFormState createState() {
    return new MyFormState();
  }
}

// Create a corresponding State class. This class will hold the data related to
// the form.
class MyFormState extends State<MyForm> {
  // Create a global key that will uniquely identify the `Form` widget
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  dynamic id, desc, mValue;


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return new Form(
      key: _formKey,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new Container(
              color: Colors.blueAccent,
              child: new TextFormField(
                initialValue: "n",
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Name'
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Name';
                  }else id = value;
                },
              ),
            ),
          ),

          new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new Container(
              color: Colors.yellow,
              child: new TextFormField(
                initialValue: "d",
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Description'
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Description';
                  }else desc = value;
                },
              ),
            ),
          ),

          new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new Container(
              color: Colors.green,
              child: new TextFormField(
                initialValue: "v",
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: 'value'
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'value';
                  }else mValue = value;
                },
              ),
            ),
          ),

          new Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 8.0, bottom: 8.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      widget.onSubmit(id, desc, mValue);
                      Scaffold.of(context).showSnackBar(
                          new SnackBar(content: new Text('Processing Data')));
                    }
                  },
                  child: new Text('Submit'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}