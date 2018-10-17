import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterstarter/data/models/Comment.dart';
import 'package:flutterstarter/data/models/Post.dart';
import 'package:flutterstarter/data/network/firestore/util/Comment.dart';
import 'package:flutterstarter/data/network/firestore/util/Post.dart';
import 'package:flutterstarter/data/network/firestore/util/Reply.dart';
import 'package:flutterstarter/data/network/firestore/util/User.dart';

class FirestoreHelper {
  bool isFlightSubscriptionEnabled = false;
  DocumentReference docRefUsers;

  Map<String, dynamic> createPost(FirebaseUser _user, Post post){
    Map<String, dynamic> aPost = <String, dynamic>{
      "date": new DateTime.now().toUtc().toIso8601String(),
      "edited": false,
      "imgUrlList": post.imgUrlList,
      "likes": post.likes,
      "message": "${post.message}",
      "title": "${post.title}",
      "userId": "${_user.uid}",
      "userImgUrl": "${post.imgUrlList[0]}",
    };
    return aPost;
  }

  Future createNewUser(FirebaseUser _user)async {
    Map<String, dynamic> user = UserUtil.createUser(
        "https://i.imgur.com/c5LeAMI.jpg",
        DateTime.now(),
        "${_user.uid}",
        [],
        "Empty Headline", //headline
        _user.photoUrl,
        {
          "comments": [],
          "posts":[],
        },
        "",//location
        _user.displayName,
        []
    );

    WriteBatch batch = firestore.batch();
    DocumentReference _userDocRef;
    _userDocRef = firestore.collection("users").document(_user.uid);
    batch.setData(_userDocRef, user);

    await batch.commit().then((done){
      print("new user has been created");
    }).catchError((e){
      print("new user error");
    });
  }

  Future removeUser(FirebaseUser _user) async{
    WriteBatch batch = firestore.batch();
    DocumentReference _userDocRef;
    _userDocRef = firestore.collection("users").document(_user.uid);
    batch.delete(_userDocRef);
    await batch.commit();
  }

  Future populateUsers() async{
    List<Map<String,dynamic>> users = UserUtil.createUsers();

    WriteBatch batch = firestore.batch();
    DocumentReference _userDocRef;

    for(Map<String,dynamic> user in users) {
      _userDocRef = firestore.collection("users").document(user['firebaseId']);
      batch.setData(_userDocRef, user);
    }

    await batch.commit().then((done){
      print("worked");
    }).catchError((e){
      print("error");
    });
  }

  Future populatePosts() async{
    List<Map<String,dynamic>> posts = PostUtil.createPosts();
    WriteBatch batch = firestore.batch();
    DocumentReference _postDocRef;
    DocumentReference _commentDocReference;
    DocumentReference _replyDocReference;

    for(var post in posts){
      _postDocRef = firestore.collection("posts").document(post['userId']);
      _commentDocReference = _postDocRef.collection("comments").document();
      _replyDocReference = _commentDocReference.collection("replies").document();

      batch.setData(_postDocRef, post);
      batch.setData(_commentDocReference, CommentUtil.createComment("1334"));
      batch.setData(_replyDocReference, ReplyUtil.createReply(_postDocRef.documentID));
    }

    await batch.commit().then((_){
      print("done");
    });
  }

  StreamSubscription<DocumentSnapshot> firestoreSubscription;
  static final FirestoreHelper firebaseHelper = new FirestoreHelper._helper();

  Map<String, dynamic> mFirestoreData;

  factory FirestoreHelper(){
    return firebaseHelper;
  }

  FirestoreHelper._helper(){
    print("opening firebase helper");
    _init();
  }

  Firestore firestore;
  Future _init() async{
    await FirebaseApp.configure(
      name: 'test',
      options: const FirebaseOptions(
        googleAppID: '1:375379904694:android:37a81e2c079af708',
        apiKey: 'AIzaSyAyllG1K6PgZoKwnFtIPMiyebCAcsBkFJs',
        projectID: 'flutter-starter',
      ),
    ).catchError((onError){
      print("error");
      print(onError.toString());
    }).then((done){
      firestore = new Firestore(app: done,);

    });
  }

}