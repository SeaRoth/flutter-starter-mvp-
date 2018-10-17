import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterstarter/data/db/db_helper.dart';
import 'package:flutterstarter/data/models/Statistic.dart';
import 'package:flutterstarter/data/network/firestore/firestore_helper.dart';
import 'package:flutterstarter/data/network/network_data.dart';
import 'package:flutterstarter/data/network/user_helper.dart';
import 'package:flutterstarter/tabs/dashboard/dashboard_presenter.dart';
import 'package:flutterstarter/widgets/button_dropdown.dart';
import 'package:flutterstarter/widgets/form_new_stat.dart';
import 'package:flutterstarter/widgets/stat_item.dart';

class DashboardScreen extends StatefulWidget{
  @override
  State createState() => new DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> implements DashboardScreenView{

  void updateDropdown(String s){
    setState(() {
      _selectedProject = s;
    });
  }
  String _selectedProject = "stats";
  final List<String> projects = <String>["stats", "users", "friends", "comments", "likes"];

  DbHelper _dbHelper;
  NetworkData _networkData;
  List<Statistic> _stats = new List<Statistic>();

  @override
  Widget build(BuildContext context) =>

      new CustomScrollView(
        slivers: <Widget>[

          new SliverToBoxAdapter(child: new Column(
            children: <Widget>[
              new Text("total users: x"),
              new Text("total comments: x"),
              new Text("total likes: x"),
              new Text("total friends: x"),
              _stats != null ? new Text("total stats: ${_stats.length}") : new Text("empty"),

              new ButtonDropdown(
                selectedProject: _selectedProject,
                projects: projects,
                callback: (String that){
                  updateDropdown(that);
                },
              ),

              new MyForm(
                onSubmit:(dynamic name, dynamic desc, dynamic value){
                  Statistic stat = new Statistic(0, name, desc, value);
                  _stats.add(stat);
                  _dbHelper.saveStats(_stats);
                  setState((){});
                },
              ),
            ],
          ),),

          _retCorrectList(_selectedProject),

        ],
      );

  Widget _retCorrectList(String s){
    switch(s){
      case "stats":

        return new SliverFixedExtentList(
          itemExtent: 50.0,
          delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return new StatItem(
                    isEven: index%2 == 0 ? true : false,
                    id: _stats[index].id,
                    name: _stats[index].name,
                    desc: _stats[index].desc,
                    value: _stats[index].value,
                    onShortPress: (dynamic that){
                      _onStatPressed(that);
                    },
                    onLongPress: (dynamic that){
                      _onStatLongPressed(that);
                    },
                  );
            },
            childCount: _stats != null ? _stats.length : 0,
          ),
        );

        break;
      default:
        break;
    }
    return new Text("EMPTY");
  }

  void _onStatPressed(dynamic id){
    print("clicked $id");
  }

  void _onStatLongPressed(dynamic id){
    print("clicked $id");
  }

  DashboardScreenPresenter _presenter;
  @override
  void initState() {
    super.initState();
    _presenter = new DashboardScreenPresenter(this);
    _presenter.loadDbNetworkData();
  }

  void loadStats() {
    _presenter.getStats();
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

  @override
  void onStatsLoaded(List<Statistic> stats) {
    setState(() {
      _stats = stats;
    });
  }
}