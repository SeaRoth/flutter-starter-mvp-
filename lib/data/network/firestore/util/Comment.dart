


import 'package:flutterstarter/data/models/Comment.dart';

class CommentUtil{

  static Comment getRandom(){
    return new Comment(new DateTime.now(), false, 0, "message", "1336");
  }


  var replies = <String>["now that's what i call a hole in one",
    "HOLY SCHNIKIES!",
    "MonkaS",
    "WHAT IN THE HECK!","I LOVE CHICKEN"
      "AYYYYY"
  ];

  static Map<String, dynamic> createComment(String userId){
    Map<String, dynamic> aComment = <String, dynamic>{
      "date": new DateTime.now(),
      "edited": false,
      "likes": 33,
      "message": "a random message",
      "userId": "$userId",
    };
    return aComment;
  }



}