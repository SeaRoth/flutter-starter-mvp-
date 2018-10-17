import 'dart:math';
import 'package:flutterstarter/data/network/firestore/util/User.dart';
class PostUtil{

  static final  dates = <dynamic>[
    new DateTime.now().subtract(Duration(days: 1)),
    new DateTime.now().subtract(Duration(days: 3,hours: 5,minutes: 15)),
    new DateTime.now().subtract(Duration(days: 4,hours: 5,minutes: 10)),
    new DateTime.now().subtract(Duration(days: 4,hours: 5,minutes: 10)),
    new DateTime.now().subtract(Duration(days: 4,hours: 5,minutes: 11)),
    new DateTime.now().subtract(Duration(days: 4,hours: 5,minutes: 12)),
  ];

  static final  messages = <String>[
    "going to beach",
    "selling 10x tickets",
    "app developer",
    "carpenter",
    "musician, trumpet",
    "real estate",
  ];

  static final titles = <String>[
    "10x tickets",
    "Book for sale",
    "Gardening services",
    "1000+ likes on any photo",
    "make money online",
    "Selling a tv",
    "anyone live in la",
    "who here is actual 10x",
    "buy this watch",
    "check out my youtube",
  ];

  static final photos = <String>[
    "https://i.imgur.com/ewErHlS.png",
    "https://i.imgur.com/yYN6uLu.png",
    "https://i.imgur.com/txwTJU9.jpg",
    "https://i.imgur.com/NDLynL6.png",
    "https://i.imgur.com/vDyH62D.png",
    "https://i.imgur.com/nI3bC4B.png",
    "https://i.imgur.com/2nmUxF4.png",
    "https://i.imgur.com/ewErHlS.png",
    "https://i.imgur.com/ewErHlS.png",
    "https://i.imgur.com/FUZ8L91.png",
    "https://i.imgur.com/JcvZw1O.jpg",
    "https://i.imgur.com/vOasty8.png",
    "https://i.imgur.com/RYgHGfk.jpg",
    "https://i.imgur.com/B5DL5e6.jpg",
    "https://i.imgur.com/OSmzXLh.jpg",
  ];

  static final  userIds = <String>[
    "Lvjdhs84jfjsja73ukdkf9fnhdhjs73",
    "Lvjdhs84jfjsja73ukdkf9fnhdhjs74",
    "Lvjdhs84jfjsja73ukdkf9fnhdhjs75",
    "Lvjdhs84jfjsja73ukdkf9fnhdhjs76",
    "Lvjdhs84jfjsja73ukdkf9fnhdhjs77",
    "Lvjdhs84jfjsja73ukdkf9fnhdhjs78",
    "Lvjdhs84jfjsja73ukdkf9fnhdhjs79",
  ];

  static final  avatars = <String>[
    "https://i.imgur.com/vjq95yT.jpg",
    "https://i.imgur.com/S7yORke.jpg",
    "https://i.imgur.com/jwASmyc.jpg",
    "https://i.imgur.com/OkQ8dxA.jpg",
    "https://i.imgur.com/JLUBEkb.jpg",
    "https://i.imgur.com/FM4u1MN.jpg",
    "https://i.imgur.com/RYgHGfk.jpg",
    "https://i.imgur.com/qgtOgZh.jpg"
  ];

  static List<Map<String,dynamic>> createPosts(){
    List<Map<String, dynamic>> posts = new List();

    for(String uid in userIds){
      var date = dates[Random().nextInt(dates.length-1)];
      var message = messages[Random().nextInt(messages.length-1)];
      var title = titles[Random().nextInt(titles.length-1)];
      var likes = [];
      var userId = uid;
      var imgUrlList = [
        photos[Random().nextInt(photos.length-1)],
        photos[Random().nextInt(photos.length-1)],
        photos[Random().nextInt(photos.length-1)],
      ];

      posts.add(
          createPost(
              date,
              false,
              imgUrlList,
              likes,
              message,
              title,
              userId)
      );
    }
    return posts;
  }

  static Map<String, dynamic> createPost(var date, var edited, var imgUrlList, var likes, var message, var title, var userId){
    Map<String, dynamic> aUser = <String, dynamic>{
      "date": date,
      "edited": edited,
      "imgUrlList": imgUrlList,
      "likes": likes,
      "message": message,
      "title": title,
      "userId": userId,
    };
    return aUser;
  }

}