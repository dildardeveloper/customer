class MyTrip {
  MyTrip({
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
    required this.startPositionId,
    required this.endPositionId,
    required this.startLat,
    required this.startLon,
    required this.endLat,
    required this.endLon,
    required this.startAddress,
    required this.endAddress,
    required this.duration,
    required this.driverUniqueId,
    required this.driverName,
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
  late final int startPositionId;
  late final int endPositionId;
  late final double startLat;
  late final double startLon;
  late final double endLat;
  late final double endLon;
  late String startAddress;
  late String endAddress;
  late final int duration;
  late final int driverUniqueId;
  late final int driverName;
  MyTrip.fromJson(Map<String, dynamic> json) {
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
    startPositionId = json['startPositionId'];
    endPositionId = json['endPositionId'];
    startLat = json['startLat'];
    startLon = json['startLon'];
    endLat = json['endLat'];
    endLon = json['endLon'];
    startAddress = json['startAddress'] ?? '';
    endAddress = json['endAddress'] ?? '';
    duration = json['duration'] ?? 0;
    driverUniqueId = json['driverUniqueId'] ?? 0;
    driverName = json['driverName'] ?? 0;
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
    _data['startPositionId'] = startPositionId;
    _data['endPositionId'] = endPositionId;
    _data['startLat'] = startLat;
    _data['startLon'] = startLon;
    _data['endLat'] = endLat;
    _data['endLon'] = endLon;
    _data['startAddress'] = startAddress;
    _data['endAddress'] = endAddress;
    _data['duration'] = duration;
    _data['driverUniqueId'] = driverUniqueId;
    _data['driverName'] = driverName;
    return _data;
  }
}
