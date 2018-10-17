import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterstarter/data/db/db_helper.dart';
import 'package:flutterstarter/data/models/Comment.dart';
import 'package:flutterstarter/data/models/Post.dart';
import 'package:flutterstarter/data/models/Reply.dart';
import 'package:flutterstarter/data/models/Statistic.dart';
import 'package:flutterstarter/data/network/firestore/firestore_helper.dart';
import 'package:flutterstarter/data/network/network_data.dart';
import 'package:flutterstarter/data/network/user_helper.dart';
import 'package:flutterstarter/tabs/home/home_presenter.dart';
import 'package:flutterstarter/widgets/post_item.dart';

class HomeScreen extends StatefulWidget{
  @override
  State createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> implements HomeScreenView {

  FirebaseUser _user;
  var userAvatar;
  var posts = new List<Post>();
  CollectionReference _postsReference;
  CollectionReference _usersReference;
  DocumentReference _aPostsDocumentRef;

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

    if(_userHelper.isLoggedIn())
      setState(() {
        _user = _userHelper.getUser();
      });
    else
      setState(() {
        _presenter.signInSilently();
      });
  }

  @override
  Widget build(BuildContext context) {

    if(_firestoreHelper.firestore == null)
      return Center(child: new Text("loading"));

    _postsReference = _firestoreHelper.firestore.collection('posts');
    _usersReference = _firestoreHelper.firestore.collection('users');

    return new StreamBuilder<QuerySnapshot>(
      stream: _firestoreHelper.firestore.collection('posts').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(child: const Text('Loading...'));
        final int messageCount = snapshot.data.documents.length;
        return new ListView.builder(
          itemCount: messageCount,
          itemBuilder: (_, int index) {
            final DocumentSnapshot thePost = snapshot.data.documents[index];
            _aPostsDocumentRef = _postsReference.document(thePost.documentID);

             return new PostItem(
               firestore: _firestoreHelper.firestore,
               post: thePost,
               onTapLike: (){
                   List<dynamic> notes = thePost['likes'] != null ? new List<dynamic>.from(thePost['likes']) : new List<dynamic>();
                   if(notes.contains(_user.uid)){
                     print("unLiking post");
                     notes.remove(_user.uid);
                   }else{
                     print("Liking post");
                     notes.add(_user.uid);
                   }
                 print(_user.uid + " pressed like on post " + thePost.documentID);
                 print("${_user.displayName} pressed like on post ${thePost.data['title']} and there are ${notes.length} long");
                   _aPostsDocumentRef.updateData({"likes":notes});
               },
               onTapComment: (){
                 print("pressed comment");
               },
               onTapShare: (){
                 print("pressed share");
               },
               onTapPost: (){
                 print("pressed post");
               },
             );


//            return new ListTile(
//              //
//              title: new Text(document['name'] ?? '<No message retrieved>'),
//              subtitle: new Text('Message ${index + 1} of $messageCount'),
//            );

          },
        );
      },
    );
  }

  HomeScreenPresenter _presenter;
  @override
  void initState() {
    super.initState();
    isDisposed = false;
    _presenter = new HomeScreenPresenter(this);
    _presenter.loadDbNetworkData();
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

  bool isDisposed = false;
  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }

  @override
  void onUserLoaded(FirebaseUser user) {
    if(!isDisposed && user != null)
      setState(() {
        _user = user;
      });
  }

  @override
  void onStatsLoaded(List<Statistic> stats) {
    // TODO: implement onStatsLoaded
  }
}