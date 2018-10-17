import 'package:flutterstarter/data/models/Comment.dart';


class Post {

  final String FIELD_DATE = "date";
  final String FIELD_EDITED = "edited";
  final String FIELD_COMMENTS = "comments";
  final String FIELD_IMGURLLIST = "imgUrlList";
  final String FIELD_LIKES = "likes";
  final String FIELD_MESSAGE = "message";
  final String FIELD_TITLE = "title";
  final String FIELD_USERID = "userId";
  final String FIELD_USERIMAGEURL = "userImageUrl";

  DateTime date;
  bool edited;
  List<Comment> comments;
  List<String> imgUrlList;
  List<String> likes;
  String message;
  String title;
  String userId;
  String userImageUrl;

  //Post(this.date, this.edited, this.comments, this.imgUrlList, this.likes, this.message, this.title, this.userId, this.userImageUrl){}

  Post(this.date, this.edited, this.imgUrlList, this.likes, this.message, this.title, this.userId, this.userImageUrl){}

  Map<String, dynamic> toJson() => {

    'userId': userId,
    'title': title,
    'date': date,
    'desc': message,
    'imgUrl': imgUrlList,
  };
}