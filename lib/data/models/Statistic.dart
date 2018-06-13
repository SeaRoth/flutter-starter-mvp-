class Statistic {
  String id;
  String name;
  String desc;
  String extra;

  Statistic(this.id, this.name, this.desc, this.extra);

  Statistic.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        desc = json['desc'],
        extra = json['extra'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'desc': desc,
    'extra': extra,
  };
}