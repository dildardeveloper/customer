class Driver {
  Driver({
    required this.id,
    required this.name,
    required this.uniqueId,
    required this.attributes,
  });
  late final int id;
  late final String name;
  late final String uniqueId;
  late final Attributes attributes;

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    uniqueId = json['uniqueId'];
    attributes = Attributes.fromJson(json['attributes']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['uniqueId'] = uniqueId;
    _data['attributes'] = attributes.toJson();
    return _data;
  }
}

class Attributes {
  Attributes();

  Attributes.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}
