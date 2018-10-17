import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterstarter/data/db/db_helper.dart';
import 'package:flutterstarter/data/models/Statistic.dart';
import 'package:flutterstarter/data/network/firestore/firestore_helper.dart';
import 'package:flutterstarter/data/network/network_data.dart';
import 'package:flutterstarter/data/network/user_helper.dart';

abstract class ScreenView{
  void onUserLoaded(FirebaseUser user);
  void onStatsLoaded(List<Statistic> stats);
  void onError(var msg);
  void onLoggedOut();
  void onFirebaseDocumentLoaded(Map<String, dynamic> document);
  void onDbNetworkDataLoaded(DbHelper dbHelper, NetworkData networkData, UserHelper userHelper, FirestoreHelper firestoreHelper);
}