class Like {
  final id;
  final name;
  final imageUrl;
  final numLikes;

  Like(this.id, this.name, this.imageUrl, this.numLikes);

  Like.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        imageUrl = json['imgUrl'],
        numLikes = json['numLikes'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imageUrl': imageUrl,
    'numLikes': numLikes,
  };
}