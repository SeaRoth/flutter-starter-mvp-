import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterstarter/data/db/db_helper.dart';
import 'package:flutterstarter/data/models/Statistic.dart';
import 'package:flutterstarter/data/network/firestore_helper.dart';
import 'package:flutterstarter/data/network/network_data.dart';
import 'package:flutterstarter/data/network/user_helper.dart';
import 'package:flutterstarter/tabs/dashboard/presenter.dart';

class DashboardScreen extends StatefulWidget{
  @override
  State createState() => new DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> implements DashboardScreenView{
  @override
  Widget build(BuildContext context) => new Container(
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new Text("stats length: ${_stats.length}"),
        new Icon(
          Icons.dashboard,
          size: 150.0,
          color: Colors.black12
        ),
        new Text('Dashboard tab content')
      ]
    ),
  );


  DashboardScreenPresenter _presenter;
  @override
  void initState() {
    super.initState();
    _presenter = new DashboardScreenPresenter(this);
    _presenter.loadDbNetworkData();
  }

  List<Statistic> _stats = new List();
  DbHelper _dbHelper;
  NetworkData _networkData;

  void loadStats() {
    _dbHelper.loadStats().then((list){
      if(list != null)
        setState(() {
          _stats = list;
        });
    });
  }

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
    // TODO: implement onUserLoaded
  }

  @override
  void onDbNetworkDataLoaded(DbHelper dbHelper, NetworkData networkData, UserHelper userHelper, FirestoreHelper firestoreHelper) {
    _dbHelper = dbHelper;
    _networkData = networkData;
    loadStats();
  }
}