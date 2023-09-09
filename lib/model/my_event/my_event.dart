class MyEvent {
  MyEvent({
    required this.id,
    required this.attributes,
    required this.deviceId,
    required this.type,
    required this.eventTime,
    required this.positionId,
    required this.geofenceId,
    required this.maintenanceId,
  });
  late final int id;
  late final Map<String, dynamic> attributes;
  late final int deviceId;
  late final String type;
  late final String eventTime;
  late final int? positionId;
  late final int? geofenceId;
  late final int? maintenanceId;

  MyEvent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'];
    deviceId = json['deviceId'] ?? 0;
    type = json['type'] ?? '';
    eventTime = json['eventTime'] ?? '';
    positionId = json['positionId'] ?? 0;
    geofenceId = json['geofenceId'] ?? 0;
    maintenanceId = json['maintenanceId'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['attributes'] = attributes;
    _data['deviceId'] = deviceId;
    _data['type'] = type;
    _data['eventTime'] = eventTime;
    _data['positionId'] = positionId;
    _data['geofenceId'] = geofenceId;
    _data['maintenanceId'] = maintenanceId;
    return _data;
  }
}
