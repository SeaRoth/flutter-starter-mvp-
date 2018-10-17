
class Comment {
  final DateTime date;
  final bool edited;
  final num likes;
  final String message;
  final String userId;

  Comment(this.date, this.edited, this.likes, this.message, this.userId);

  Comment.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        edited = json['edited'],
        likes = json['likes'],
        userId = json['userId'],
        message = json['message'];

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'message': message,
    'date': date};
}