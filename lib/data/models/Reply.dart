class Reply {
  String id;
  String userId;
  String message;
  bool edited;
  String date;

  Reply(this.id, this.userId, this.message, this.date);

  Reply.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        message = json['message'],
        date = json['date'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'message': message,
    'date': date,
  };
}