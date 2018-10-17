class Statistic {
  final id;
  final name;
  final desc;
  final value;

  Statistic(this.id, this.name, this.desc, this.value);

  Statistic.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        desc = json['desc'],
        value = json['value'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'desc': desc,
    'value': value,
  };
}