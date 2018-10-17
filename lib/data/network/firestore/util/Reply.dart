



class ReplyUtil{
  static Map<String, dynamic> createReply(String postId){
    Map<String, dynamic> aComment = <String, dynamic>{
      "date": new DateTime.now().toUtc().toIso8601String(),
      "edited": false,
      "likes": 33,
      "message": "a random message",
      "userId": "$postId",
    };
    return aComment;
  }
}