import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:flutterstarter/data/db/db_helper.dart';
import 'package:flutterstarter/data/models/Statistic.dart';
import 'package:flutterstarter/data/network/firestore/firestore_helper.dart';
import 'package:flutterstarter/data/network/network_data.dart';
import 'package:flutterstarter/data/network/user_helper.dart';
import 'package:flutterstarter/screens/login_presenter.dart';
import 'package:flutterstarter/widgets/button_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  State createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> implements LoginScreenView {

  bool _isLoggedIn = false;
  bool _isLoading = false;
  bool _isError = false;
  var errorMessage;
  LoginScreenPresenter _presenter;
  FirebaseUser _user;
  var userAvatar;

  @override
  void initState() {
    super.initState();
    _presenter = new LoginScreenPresenter(this);
    _presenter.loadUser();
    userAvatar = _isLoggedIn ? new Image(image: new NetworkImageWithRetry(_user.photoUrl),).image : new Image.asset('images/flaps.jpg');
  }

  void _loginFunction(){
    setState((){
      _isLoading = true;
    });
    _presenter.loginGoogle();
  }

  void _signOut() {
    setState((){
      _presenter.logout();
      _isLoggedIn = false;
    });
    print("User Signed out");
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    final logo = new Hero(
      tag: 'hero',
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: _isLoggedIn ? new Image(image: userAvatar,) : new Image.asset('images/flaps.jpg'),
      ),
    );

  if(_isLoggedIn){
      widget = new Scaffold(
        backgroundColor: Colors.green[200],
        body: new Center(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new CircleAvatar(
                backgroundImage: new Image(image: userAvatar,).image,
                radius: 50.0,
              ),
              new Text(_user.displayName, style: new TextStyle(fontSize: 12.0),),
              new SizedBox(height: 48.0),
              new RaisedButton(
                onPressed: _signOut,
                child: new Text("Sign out"),
                color: Colors.red,
              ),
            ],
          ),
        ),
      );
    }else {
      if (_isLoading) {
        widget = new Center(
            child: new CircularProgressIndicator()
        );
      } else {

        widget = new Container(
          child: new Center(
            child: new ListView(
              shrinkWrap: true,
              padding: new EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                logo,
                _isError ? new Text(errorMessage) : new Text(""),
                new SizedBox(height: 48.0),
                //email,
                //new SizedBox(height: 8.0),
                //password,
                //new SizedBox(height: 24.0),
                //loginButton,
                //loginButtonGoogle,


                new ButtonNormal(
                  text: "Creative Login Button",
                  fn: _loginFunction,
                  colorBg: Colors.green,
                  colorText: Colors.white,
                ),

                //loginButtonFacebook,
                //forgotLabel
              ],
            ),
          ),
        );
      }
    }

    return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            'Login',
            style: new TextStyle(
              fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
            ),
          ),
          elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        ),
        //Content of tabs
        body: widget
    );

    //return widget;
  }

  @override
  void onUserLoaded(FirebaseUser user) {
    _isError = false;
    setState((){
      _user = user;
      _isLoading = false;
      _isLoggedIn = true;
      userAvatar = new Image(image: new NetworkImageWithRetry(_user.photoUrl),).image;
    });
  }

  @override
  void onError(var msg) {
    print("There was a login error");
    errorMessage = msg.toString();
    _isError = true;
    setState((){
      _isLoading = false;
      _isLoggedIn = false;
    });
  }

  @override
  void onLoggedOut() {
    _isError = false;
    setState((){
      _isLoggedIn = false;
      _user = null;
    });
  }

  @override
  void onFirebaseDocumentLoaded(Map<String, dynamic> document) {
    // TODO: implement onFirebaseDocumentLoaded
  }

  @override
  void onDbNetworkDataLoaded(DbHelper dbHelper, NetworkData networkData, UserHelper userHelper, FirestoreHelper firestoreHelper) {
    // TODO: implement onDbNetworkDataLoaded
  }

  @override
  void onStatsLoaded(List<Statistic> stats) {
    // TODO: implement onStatsLoaded
  }

}

