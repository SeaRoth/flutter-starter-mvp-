import 'package:flutterstarter/data/models/Like.dart';

class User {
  final String coverPhoto;
  final DateTime dateCreated;
  final List<String> friends;
  final String headline;
  final String imageUrl;
  final Object likes;
  final String location;
  final name;
  final List<String> photos;

  User(this.coverPhoto, this.dateCreated, this.friends, this.headline, this.imageUrl, this.likes, this.location, this.name, this.photos);

//  User.fromJson(Map<String, dynamic> json)
//      : id = json['id'],
//        userId = json['userId'],
//        name = json['name'],
//        friends = json['friends'],
//        likes = json['likes'];

//  Map<String, dynamic> toJson() => {
//    'id': id,
//    'userId': userId,
//    'name': name,
//    'friends': friends,
//    'likes': likes,};




}