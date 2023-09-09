class MyStop {
  MyStop({
    required this.deviceId,
    required this.deviceName,
    required this.distance,
    required this.averageSpeed,
    required this.maxSpeed,
    required this.spentFuel,
    required this.startOdometer,
    required this.endOdometer,
    required this.startTime,
    required this.endTime,
    required this.positionId,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.duration,
    required this.engineHours,
  });
  late final int deviceId;
  late final String deviceName;
  late final double distance;
  late final double averageSpeed;
  late final double maxSpeed;
  late final double spentFuel;
  late final double startOdometer;
  late final double endOdometer;
  late final String startTime;
  late final String endTime;
  late final int positionId;
  late final double latitude;
  late final double longitude;
  late final String address;
  late final int duration;
  late final int engineHours;

  MyStop.fromJson(Map<String, dynamic> json) {
    deviceId = json['deviceId'];
    deviceName = json['deviceName'];
    distance = json['distance'];
    averageSpeed = json['averageSpeed'];
    maxSpeed = json['maxSpeed'];
    spentFuel = json['spentFuel'];
    startOdometer = json['startOdometer'];
    endOdometer = json['endOdometer'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    positionId = json['positionId'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    duration = json['duration'];
    engineHours = json['engineHours'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['deviceId'] = deviceId;
    _data['deviceName'] = deviceName;
    _data['distance'] = distance;
    _data['averageSpeed'] = averageSpeed;
    _data['maxSpeed'] = maxSpeed;
    _data['spentFuel'] = spentFuel;
    _data['startOdometer'] = startOdometer;
    _data['endOdometer'] = endOdometer;
    _data['startTime'] = startTime;
    _data['endTime'] = endTime;
    _data['positionId'] = positionId;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['address'] = address;
    _data['duration'] = duration;
    _data['engineHours'] = engineHours;
    return _data;
  }
}
