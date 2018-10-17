import 'dart:collection';
import 'dart:math';

class UserUtil{

  static final  coverPhotos = <String>["https://i.imgur.com/nZG1db9.png",
  "https://i.imgur.com/BOfvR72.png",
    "https://i.imgur.com/IvE301W.jpg",
    "https://i.imgur.com/0q8W9k5.jpg",
    "https://i.imgur.com/SAfhuCa.jpg"
  ];

  static final  dates = <dynamic>[
    new DateTime.now().subtract(Duration(days: 1,minutes: 43)),
    new DateTime.now().subtract(Duration(days: 1,minutes: 23)),
    new DateTime.now().subtract(Duration(days: 1,minutes: 13)),
    new DateTime.now().subtract(Duration(days: 1,minutes: 53)),
    new DateTime.now().subtract(Duration(days: 1,minutes: 22)),
    new DateTime.now().subtract(Duration(days: 1,minutes: 4)),
    new DateTime.now().subtract(Duration(days: 3,hours: 5,minutes: 15)),
    new DateTime.now().subtract(Duration(days: 4,hours: 5,minutes: 10)),
    new DateTime.now().subtract(Duration(days: 4,hours: 5,minutes: 10)),
    new DateTime.now().subtract(Duration(days: 4,hours: 5,minutes: 11)),
    new DateTime.now().subtract(Duration(days: 4,hours: 5,minutes: 12)),
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

  static final  headlines = <String>[
    "going to beach",
    "selling 10x tickets",
    "app developer",
    "carpenter",
    "musician, trumpet",
    "real estate",
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

  static final  posts = <String>[
    "sdfsdf34sdfs22",
    "sdfsdf34sdfs23",
    "sdfsdf34sdfs24",
    "sdfsdf34sdfs25",
    "sdfsdf34sdfs26",
    "sdfsdf34sdfs27",
    "sdfsdf34sdfs28",
    "sdfsdf34sdfs29",
    "sdfsdf34sdfs30",
  ];

  static final  replies = <String>[
    "r123",
    "r124",
    "r125",
    "r126",
    "r127",
    "r128",
    "r129",
  ];

  static final  locations = <String>[
    "Narnia, North Dakota",
    "Somewhere you know",
    "i can type anything?",
    "Narnia, rekt",
    "home plate",
    "anywhere you're buying 10x merch",
  ];

  static final  names = <String>["chuck","barry","angelo","markel","tmoney"];

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



  static List<Map<String,dynamic>> createUsers(){
    List<Map<String, dynamic>> users = new List();

    for(String uId in userIds){
      var coverPhoto = coverPhotos[Random().nextInt(coverPhotos.length-1)];
      var dateCreated = dates[Random().nextInt(dates.length-1)];
      var firebaseId = uId;
      var friendsHash = HashSet<String>();
        friendsHash.add(userIds[Random().nextInt(userIds.length-1)]);
        friendsHash.add(userIds[Random().nextInt(userIds.length-1)]);
        friendsHash.add(userIds[Random().nextInt(userIds.length-1)]);
        var friends = friendsHash.toList();

      var headline = headlines[Random().nextInt(headlines.length-1)];
      var imageUrl = photos[Random().nextInt(photos.length-1)];
      var likes = {
        "posts": [],
        "replies": [],
      };
      var location = locations[Random().nextInt(locations.length-1)];
      var username = names[Random().nextInt(names.length-1)];
      var mPhotos = [
        photos[Random().nextInt(photos.length-1)],
        photos[Random().nextInt(photos.length-1)],
        photos[Random().nextInt(photos.length-1)],
        photos[Random().nextInt(photos.length-1)],
        photos[Random().nextInt(photos.length-1)],
        photos[Random().nextInt(photos.length-1)],
      ];

      users.add(
        createUser(coverPhoto, dateCreated, firebaseId, friends, headline, imageUrl, likes, location, username, mPhotos)
      );
    }
    return users;
  }

  static Map<String, dynamic> createUser(var coverPhoto, var dateCreated, var firebaseId, var friends, var headlines, var imageUrl, var likes, var location, var username, var mPhotos){
    Map<String, dynamic> aUser = <String, dynamic>{
      "coverPhoto": coverPhoto,
      "dateCreated": dateCreated,
      "firebaseId":firebaseId,
      "friends": friends,
      "headline": headlines,
      "imageUrl": imageUrl,
      "likes": likes,
      "location": location,
      "name": username,
      "photos": mPhotos
    };
    return aUser;
  }

}