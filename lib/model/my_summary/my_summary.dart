class MySummary {
  MySummary({
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
  late final int engineHours;

  MySummary.fromJson(Map<String, dynamic> json) {
    deviceId = json['deviceId'];
    deviceName = json['deviceName'] ?? '';
    distance = json['distance'];
    averageSpeed = json['averageSpeed'];
    maxSpeed = json['maxSpeed'];
    spentFuel = json['spentFuel'];
    startOdometer = json['startOdometer'];
    endOdometer = json['endOdometer'];
    startTime = json['startTime'] ?? '';
    endTime = json['endTime'] ?? '';
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
    _data['engineHours'] = engineHours;
    return _data;
  }
}
