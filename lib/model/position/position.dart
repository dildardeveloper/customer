class Position {
  Position({
    required this.id,
    required this.attributes,
    required this.deviceId,
    this.type,
    required this.protocol,
    required this.serverTime,
    required this.deviceTime,
    required this.fixTime,
    required this.outdated,
    required this.valid,
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.speed,
    required this.course,
    required this.address,
    required this.accuracy,
    required this.network,
  });
  late final int id;

  late final Map<String, dynamic> attributes;
  late final int deviceId;
  late final Null type;
  late final String protocol;
  late final String serverTime;
  late final String deviceTime;
  late final String fixTime;
  late final bool outdated;
  late final bool valid;
  late final double latitude;
  late final double longitude;
  late final double altitude;
  late final double speed;
  late final double course;
  late final String address;
  late final double accuracy;
  late final Map<String, dynamic> network;

  Position.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] ?? {};
    deviceId = json['deviceId'];
    type = null;
    protocol = json['protocol'] ?? '';
    serverTime = json['serverTime'] ?? '';
    deviceTime = json['deviceTime'] ?? '';
    fixTime = json['fixTime'] ?? '';
    outdated = json['outdated'];
    valid = json['valid'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    altitude = json['altitude'];
    speed = json['speed'];
    course = json['course'];
    address = json['address'] ?? '';
    accuracy = json['accuracy'];
    network = json['network'] ?? {};
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['attributes'] = attributes;
    _data['deviceId'] = deviceId;
    _data['type'] = type;
    _data['protocol'] = protocol;
    _data['serverTime'] = serverTime;
    _data['deviceTime'] = deviceTime;
    _data['fixTime'] = fixTime;
    _data['outdated'] = outdated;
    _data['valid'] = valid;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['altitude'] = altitude;
    _data['speed'] = speed;
    _data['course'] = course;
    _data['address'] = address;
    _data['accuracy'] = accuracy;
    _data['network'] = network;
    return _data;
  }
}
