import '../../services/vehicle_services.dart';
import '../my_summary/my_summary.dart';
import '../position/position.dart';

class MyDevice {
  MyDevice({
    required this.id,
    required this.attributes,
    required this.groupId,
    required this.name,
    required this.uniqueId,
    required this.status,
    required this.lastUpdate,
    required this.positionId,
    required this.phone,
    required this.model,
    required this.contact,
    required this.category,
    required this.disabled,
  });
  late final int id;

  late final Map<String, dynamic> attributes;
  late final int groupId;
  late final String name;
  late final String uniqueId;
  late final String status;
  late final String lastUpdate;
  late final int positionId;
  late final String phone;
  late final String model;
  late final String contact;
  late final String category;
  late final bool disabled;
  String vehicleState = '';
  Position? position;
  MySummary? summary;
  set VehicleState(String vs) {
    vehicleState = vs;
  }

  MyDevice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'];
    groupId = json['groupId'];
    name = json['name'];
    uniqueId = json['uniqueId'];
    status = json['status'];
    lastUpdate = json['lastUpdate'] ?? '\n_';
    positionId = json['positionId'];

    phone = json['phone'] ?? '';
    model = json['model'] ?? '';
    contact = json['contact'] ?? '';
    disabled = json['disabled'];
    setPosition().whenComplete(() async {
      try {
        summary = await VehicleServices.getSummary(
            deviceId: this.id.toString(),
            from: DateTime.now().toIso8601String().substring(0, 20) + 'z',
            to: DateTime.now().toIso8601String().substring(0, 20) + 'z');
      } catch (e) {
        print(e.toString());
      }

      setVehicleState();
    });
    category = json['category'] ?? 'default';
  }
  setVehicleState() {
    //conditions for stop ..... ignition should be false... motion false...time less than 1 hour...
//idle .... ignition on.... motion false
//running ... ingnition on ...motion true...
//unreachable... time should be greater than 1 hour...ignition false....motion false....

    Duration? time = lastUpdate.isEmpty || lastUpdate == '\n_'
        ? null
        : DateTime.now().difference(DateTime.parse(lastUpdate));

    if (position != null) {
      if (time!.inHours < 1) {
        if (position!.attributes['ignition'] ?? false) {
          if (position!.attributes['motion']) {
            vehicleState = 'running';
          } else {
            vehicleState = 'idle';
          }
        } else if (!(position!.attributes['motion'])) {
          if (time.inHours < 1) {
            vehicleState = 'stop';
          } else {
            vehicleState = 'inactive';
          }
        }
      } else {
        vehicleState = 'inactive';
      }
    } else {
      vehicleState = 'nodata';
    }
    if (disabled) {
      vehicleState = 'block';
    }
  }

  Future setPosition() async {
    if (positionId != 0)
      position = await VehicleServices.getSinglePosition(
          positionId: positionId.toString());
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['attributes'] = attributes;
    _data['groupId'] = groupId;
    _data['name'] = name;
    _data['uniqueId'] = uniqueId.toString();
    _data['status'] = status;
    _data['lastUpdate'] = lastUpdate;
    _data['positionId'] = positionId;

    _data['phone'] = phone;
    _data['model'] = model;
    _data['contact'] = contact;
    _data['category'] = category;
    _data['disabled'] = disabled;

    return _data;
  }
}
