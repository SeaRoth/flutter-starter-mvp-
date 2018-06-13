import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreHelper {
  bool isFlightSubscriptionEnabled = false;
  DocumentReference docRefUsers;

  Map<String, dynamic> returnDataTemplate(FirebaseUser user){
    Map<String, dynamic> dataTemplate = <String, dynamic>{
      "assigned_instrument": "not set",
      "displayName": "${user.displayName}",
      "email": "${user.email}",
      "flight_training": {
        "attempts": 0,
        "completed": false,
        "hours": 0,
        "started": false,
      },
      "ground_training": {
        "attempts": 0,
        "completed": false,
        "hours": 0,
        "started": false,
      },
    };
    return dataTemplate;
  }

  StreamSubscription<DocumentSnapshot> firestoreSubscription;
  static final FirestoreHelper firebaseHelper = new FirestoreHelper._helper();

  Map<String, dynamic> mFirestoreData;

  factory FirestoreHelper(){
    return firebaseHelper;
  }

  FirestoreHelper._helper(){
    print("opening firebase helper");
  }

  Future<Map<String, dynamic>> getFlightTrainingSnapshot(){
    docRefUsers.get().then((dataSnapshot) {
      if(dataSnapshot.exists){
          return dataSnapshot.data;
      }else return null;
    });
    return null;
  }

  void addFlightTrainingHour(FirebaseUser user){
    if(user != null) {
      mFirestoreData['flight_training']['hours']++;
      _setData();
    }
  }

  void subOneFlight(FirebaseUser user){
    if(user != null){
      mFirestoreData['flight_training']['hours']--;
      _setData();
    }
  }

  void subOneGround(FirebaseUser user){
    if(user != null){
      mFirestoreData['ground_training']['hours']--;
      _setData();
    }
  }

  bool setFlightTrainingHour(FirebaseUser user, int hour){
    if(user != null) {
      mFirestoreData['flight_training']['hours'] = hour;
      return _setData();
    }return false;
  }

  bool addGroundTrainingHour(FirebaseUser user){
    if(user != null) {
      mFirestoreData['ground_training']['hours']++;
      return _setData();
    }return false;
  }

  bool setGroundTrainingHour(FirebaseUser user, int hour){
    if(user != null) {
      mFirestoreData['ground_training']['hours'] = hour;
      return _setData();
    }return false;
  }

  bool _setData(){
    mFirestoreData['flight_training']['started'] = true;
    docRefUsers.setData(mFirestoreData).whenComplete(() {
      return true;
    }).catchError((e) {
      print(e);
      return false;
    });
    return false;
  }

  void setDefault(FirebaseUser user){
    docRefUsers = Firestore.instance.document("users/${user.email}");
    if(user != null){
      var data = returnDataTemplate(user);
      mFirestoreData = data;
      _setData();
    }
  }

//  void addGroundTrainingHour(FirebaseUser user){
//    if(user != null) {
//      dataGroundHours['id'] = user.uid;
//      dataGroundHours['hours']++;
//      docRefTrainingGroundHours.setData(dataGroundHours).whenComplete(() {
//      }).catchError((e) => print(e));
//    }
//  }


}