class Geofence {
  Geofence({
    required this.id,
    required this.attributes,
    required this.calendarId,
    required this.name,
    this.description,
    required this.area,
  });
  late final int id;
  late final Attributes attributes;
  late final int calendarId;
  late final String name;
  late final Null description;
  late final String area;

  Geofence.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = Attributes.fromJson(json['attributes']);
    calendarId = json['calendarId'];
    name = json['name'];
    description = null;
    area = json['area'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['attributes'] = attributes.toJson();
    _data['calendarId'] = calendarId;
    _data['name'] = name;
    _data['description'] = description;
    _data['area'] = area;
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
