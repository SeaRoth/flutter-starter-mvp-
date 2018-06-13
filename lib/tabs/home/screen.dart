import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterstarter/data/db/db_helper.dart';
import 'package:flutterstarter/data/models/Statistic.dart';
import 'package:flutterstarter/data/network/firestore_helper.dart';
import 'package:flutterstarter/data/network/network_data.dart';
import 'package:flutterstarter/data/network/user_helper.dart';
import 'package:flutterstarter/tabs/home/presenter.dart';

class HomeScreen extends StatefulWidget{
  @override
  State createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> implements HomeScreenView {

  FirebaseUser _user;
  var userAvatar;

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Text(_user != null
                ? "Logged in as ${_user.displayName}"
                : "Not Logged in"),
            _user != null ?
            new MaterialButton(
              onPressed: _login,
              color: Colors.red,
              child: new Text("Log out"),)
                :
            new MaterialButton(
              onPressed: _login,
              color: Colors.teal,
              child: new Text("Log in"),
            ),
            new Icon(
                Icons.home,
                size: 150.0,
                color: Colors.black12
            ),
            new Text('Home tab content')
          ],
        )
    );
  }


  HomeScreenPresenter _presenter;
  @override
  void initState() {
    super.initState();
    _presenter = new HomeScreenPresenter(this);
    _presenter.loadDbNetworkData();
  }

  void _login(){
    Navigator.of(context).pushNamed('/login');
  }

  void logout(){

  }

  List<Statistic> _stats = new List();
  @override
  void onFirebaseDocumentLoaded(Map<String, dynamic> document) {
    // TODO: implement onDocumentLoaded
  }

  @override
  void onError(var msg) {
    // TODO: implement onError
  }

  @override
  void onLoggedOut() {
    // TODO: implement onLoggedOut
  }

  @override
  void onUserLoaded(FirebaseUser user) {
    if(user != null)
      setState(() {
        _user = user;
      });
  }

  DbHelper _dbHelper;
  NetworkData _networkData;
  UserHelper _userHelper;
  FirestoreHelper _firestoreHelper;
  @override
  void onDbNetworkDataLoaded(DbHelper dbHelper, NetworkData networkData, UserHelper userHelper, FirestoreHelper firestoreHelper) {
    _dbHelper = dbHelper;
    _networkData = networkData;
    _userHelper = userHelper;
    _firestoreHelper = firestoreHelper;

    if(_userHelper.isLoggedIn()){
      setState(() {
        _user = _userHelper.getUser();
      });
    }else
      _presenter.signInSilently();
  }
}