import 'dart:convert';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traccar_gennissi/traccar_gennissi.dart';
import 'package:web_socket_channel/io.dart';
import '../configs/api_configs.dart';
import '../model/driver/driver.dart';
import '../model/geo_fence/geo_fence.dart';
import '../model/my_device/my_device.dart';
import '../model/my_event/my_event.dart';
import '../model/my_stop/my_stop.dart';
import '../model/my_summary/my_summary.dart';
import '../model/my_trip_track/my_trip.dart';
import '../model/position/position.dart';
import 'package:http_auth/http_auth.dart' as http_auth;
import '../model/trip_route/trip_route.dart';
//import 'package:http_auth/http_auth.dart' as http_auth;
// import 'package:traccar_gennissi/traccar_gennissi.dart';
class VehicleServices {
  static Future<List<MyDevice>> getAllVehicles() async {
    List<MyDevice> list = [];
    final client = await getClient();
    final response = await client.get(
        Uri.parse(APIConfigs.baseUrl + APIConfigs.devices),
        headers: {'Accept': 'application/json'});

    final List rawList = jsonDecode(response.body);

    for (Map<String, dynamic> a in rawList) {
      MyDevice device = MyDevice.fromJson(a);
      list.add(device);
    }
    return list;
  }

  static Future<List<Position>> getPositions() async {
    List<Position> positions = [];
    final client = await getClient();
    final response = await client.get(
        Uri.parse(
          APIConfigs.baseUrl + APIConfigs.positions,
        ),
        headers: {'Accept': 'application/json'});
    List rawList = jsonDecode(response.body);
    for (Map<String, dynamic> a in rawList) {
      positions.add(Position.fromJson(a));
    }
    return positions;
  }

  static Future<MySummary> getSummary(
      {required String deviceId,
        required String from,
        required String to}) async {
    final client = await getClient();
    final response = await client.get(
      Uri.http(
        APIConfigs.serverIp,
        APIConfigs.summary,
        {
          'deviceId': deviceId,
          'from': getFormattedTimeString(from),
          'to': getFormattedTimeString(to)
        },
      ),
      headers: {
        'Accept': 'application/json',
      },
    );

    List rawList = jsonDecode(response.body);
    final MySummary summary = MySummary.fromJson(rawList.first);
    return summary;
  }

  static Future<List<MySummary>> getSummaryReport(
      {required String deviceId,
        required String from,
        required String to}) async {
    final client = await getClient();
    final response = await client.get(
        Uri.http(
          APIConfigs.serverIp,
          APIConfigs.summary,
          {
            'deviceId': deviceId,
            'from': getFormattedTimeString(from),
            'to': getFormattedTimeString(to)
          },
        ),
        headers: {'Accept': 'application/json'});

    List rawList = jsonDecode(response.body);
    List<MySummary> summaries = [];
    rawList.forEach((element) {
      summaries.add(MySummary.fromJson(element));
    });
    return summaries;
  }

  static Future<Position?> getSinglePosition(
      {required String positionId}) async {
    final client = await getClient();
    final response = await client.get(
        Uri.http(APIConfigs.serverIp, APIConfigs.positions, {"id": positionId}),
        headers: {'Accept': 'application/json'});
    Position? position;
    if (response.statusCode == 200) {
      List rawList = jsonDecode(response.body);
      position = Position.fromJson(rawList.first);
    }
    return position;
  }

  static Future<http_auth.BasicAuthClient> getClient() async {
    final prefs = await SharedPreferences.getInstance();

    String email = prefs.getString('email')!;
    String password = prefs.getString('password')!;
    return http_auth.BasicAuthClient(email, password);
  }

  static Future<Position?> getDevicePositionData(String deviceID) async {
    final client = await getClient();
    final response = await client.get(
        Uri.http(
            APIConfigs.serverIp, APIConfigs.positions, {'deviceId': deviceID}),
        headers: {'Accept': 'application/json'});

    final List<dynamic> rawList = jsonDecode(response.body);
    final Position? position =
    rawList.isEmpty ? null : Position.fromJson(rawList.first);
    return position;
  }

  static Future<List<MyTrip>> getTrips(String from, String to,
      {String? deviceId, String? groupId}) async {
    final client = await getClient();
    final response = await client.get(
      deviceId != null
          ? Uri.http(
        APIConfigs.serverIp,
        APIConfigs.trips,
        {
          'deviceId': deviceId,
          'from': getFormattedTimeString(from),
          'to': getFormattedTimeString(to)
        },
      )
          : Uri.http(
        APIConfigs.serverIp,
        APIConfigs.trips,
        {
          'groupId': '1',
          'from': getFormattedTimeString(from),
          'to': getFormattedTimeString(to)
        },
      ),
      headers: {
        "Accept": "application/json",
      },
    );

    List rawList = jsonDecode(response.body);
    List<MyTrip> trips = [];
    for (int i = 0; i < rawList.length; i++) {
      MyTrip trip = MyTrip.fromJson(rawList[i]);

      trips.add(trip);
    }
    return trips;
  }

  static Future<List<MySummary>> getSummaryWithId(String from, String to,
      {String? deviceId, String? groupId}) async {
    final client = await getClient();

    final response = await client
        .get(
      deviceId != null
          ? Uri.http(
        APIConfigs.serverIp,
        APIConfigs.summary,
        {
          'deviceId': deviceId,
          'from': getFormattedTimeString(from),
          'to': getFormattedTimeString(to)
        },
      )
          : Uri.http(
        APIConfigs.serverIp,
        APIConfigs.summary,
        {
          'groupId': '1',
          'from': getFormattedTimeString(from),
          'to': getFormattedTimeString(to)
        },
      ),
    )
        .timeout(
      Duration(
        seconds: 60,
      ),
    );

    List rawList = jsonDecode(response.body);
    List<MySummary> summary = [];
    rawList.forEach((element) {
      summary.add(MySummary.fromJson(element));
    });
    return summary;
  }

  static Future<MyDevice> getDevice(String deviceId) async {
    final client = await getClient();
    final response = await client.get(
        Uri.http(
          APIConfigs.serverIp,
          APIConfigs.devices,
          {'deviceId': deviceId},
        ),
        headers: {'Accept': 'application/json'});
    List rawList = jsonDecode(response.body);
    MyDevice device = MyDevice.fromJson(rawList.first);
    return device;
  }

  static Future<List<Position>> getPositionWithTime(
      {required String deviceId,
        required String from,
        required String to}) async {
    final client = await getClient();
    final response = await client.get(
      Uri.http(
        APIConfigs.serverIp,
        APIConfigs.positions,
        {
          'deviceId': deviceId,
          'from': getFormattedTimeString(from),
          'to': getFormattedTimeString(to)
        },
      ),
      headers: {'Accept': 'application/json'},
    );

    List rawList = jsonDecode(response.body);
    List<Position> positions = [];
    rawList.forEach((element) {
      positions.add(Position.fromJson(element));
    });
    return positions;
  }

  static Future<List<TripRoute>> getRouteWithTime(
      {required String deviceId,
        required String from,
        required String to}) async {
    final client = await getClient();
    final response = await client.get(
        Uri.http(APIConfigs.serverIp, APIConfigs.route, {
          'deviceId': deviceId,
          'from': getFormattedTimeString(from),
          'to': getFormattedTimeString(to)
        }),
        headers: {'Accept': 'application/json'});

    List rawList = jsonDecode(response.body);
    List<TripRoute> positions = [];
    rawList.forEach((element) {
      positions.add(TripRoute.fromJson(element));
    });
    return positions;
  }

  static Future<List<MyStop>> getStops(
      {required String deviceId,
        required String from,
        required String to}) async {
    final client = await getClient();
    final response = await client.get(
        Uri.http(APIConfigs.serverIp, APIConfigs.stops, {
          'deviceId': deviceId,
          'from': getFormattedTimeString(from),
          'to': getFormattedTimeString(to)
        }),
        headers: {'Accept': 'application/json'});

    List rawList = jsonDecode(response.body);
    List<MyStop> positions = [];
    rawList.forEach((element) {
      positions.add(MyStop.fromJson(element));
    });
    return positions;
  }

  static String getFormattedTimeString(String unformatted) {
    return unformatted.substring(0, 19) + 'z';
  }

  static Future<MyEvent> getEvent(
      {required String deviceId,
        required String from,
        required String to}) async {
    final client = await getClient();
    final response = await client.get(
        Uri.http(APIConfigs.serverIp, APIConfigs.event, {
          'deviceId': deviceId,
          'from': getFormattedTimeString(from),
          'to': getFormattedTimeString(to)
        }),
        headers: {'Accept': 'application/json'});
    List rawList = jsonDecode(response.body);
    MyEvent event = MyEvent.fromJson(rawList.first);
    return event;
  }

  static Stream getSocket() {
    final stream =
        IOWebSocketChannel.connect(Uri.parse(APIConfigs.socket)).stream;
    stream.listen((event) {
      print(event);
    });
    return stream;
  }

  static Future<List<MyEvent>> getEvents(
      {required String deviceId,
        required String from,
        required String to}) async {
    final client = await getClient();
    final response = await client.get(
      Uri.http(APIConfigs.serverIp, APIConfigs.event, {
        'deviceId': deviceId,
        'from': getFormattedTimeString(from),
        'to': getFormattedTimeString(to)
      }),
      headers: {'Accept': 'application/json'},
    );
    List rawList = jsonDecode(response.body);
    List<MyEvent> events = [];
    rawList.forEach((element) {
      events.add(MyEvent.fromJson(element));
    });
    events.sort((a, b) =>
        DateTime.parse(b.eventTime).compareTo(DateTime.parse(a.eventTime)));
    log(events
        .map((e) => [e.type])
        .reduce((value, element) => value + element)
        .toString());
    return events;
  }

  static Future<Geofence> getGeofence({
    required int id,
  }) async {
    final client = await getClient();
    final response = await client.get(
        Uri.http(APIConfigs.serverIp, APIConfigs.geofences),
        headers: {'Accept': 'application/json'});

    List rawList = jsonDecode(response.body);
    return Geofence.fromJson(rawList.where((element) {
      return element['id'] == id;
    }).first);
  }

  static Future<int> updateADevice(
      {required int deviceId, required Map<String, dynamic> body}) async {
    final Response response =
    await Traccar.updateDevices(jsonEncode(body), deviceId.toString());

    return response.statusCode;
  }

  static Future<int> addANewDevice({
    required String name,
    required String imei,
    required String category,
    String? contact,
    String? model,
  }) async {
    try {
      final client = await getClient();
      String body = jsonEncode({
        'name': name,
        'uniqueId': imei,
        'category': category,
        'contact': contact ?? '',
        'model': model ?? ''
      });
      final response = await client.post(
          Uri.http(APIConfigs.serverIp, APIConfigs.devices),
          encoding: Encoding.getByName('utf-8'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: body);
      return response.statusCode;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<int> enableParkingMode(MyDevice device, LatLng position) async {
    try {
      DateFormat _parkTimeFormat = DateFormat("dd-MM-yy hh:mm:ss");
      final Response response = await Traccar.addGeofence(jsonEncode({
        'name': 'High Alert ' + device.name,
        'area': 'CIRCLE (${position.latitude} ${position.longitude}, 50)'
      }));
      Map<String, dynamic> body = jsonDecode(response.body);
      int geofenceId = body['id'];
      await Traccar.addPermission(
          jsonEncode({'deviceId': device.id, 'geofenceId': geofenceId}));
      Map<String, dynamic> toBeUpdatedDevice = device.toJson();
      if (toBeUpdatedDevice['lastUpdate'] == '\n_') {
        toBeUpdatedDevice['lastUpdate'] = '';
      }
      toBeUpdatedDevice['attributes']['is_parked'] = true;
      toBeUpdatedDevice['attributes']["parked_time"] =
          _parkTimeFormat.format(DateTime.now());
      toBeUpdatedDevice['attributes']['fence_id'] = geofenceId;
      List list = toBeUpdatedDevice['geofenceIds'];
      list.add(geofenceId);
      print(list);
      toBeUpdatedDevice['geofenceIds'] = list;
      final Response updateResponse = await Traccar.updateDevices(
          jsonEncode(toBeUpdatedDevice), device.id.toString());
      return updateResponse.statusCode;
    } catch (e) {
      throw e;
    }
  }

  static Future<int> disableParkingMode(MyDevice device) async {
    try {
      await Traccar.deletePermission(device.id, device.attributes['fence_id']);
      await Traccar.deleteGeofence(device.attributes['fence_id'].toString());

      Map<String, dynamic> toBeUpdatedDevice = device.toJson();
      if (toBeUpdatedDevice['lastUpdate'] == '\n_') {
        toBeUpdatedDevice['lastUpdate'] = '';
      }

      // toBeUpdatedDevice['geofenceIds'].remove(device.attributes['fence_id']);
      toBeUpdatedDevice['attributes'] = {"is_parked": false};
      final Response updateResponse = await Traccar.updateDevices(
          jsonEncode(toBeUpdatedDevice), device.id.toString());

      return updateResponse.statusCode;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<Driver>> getAllDrivers() async {
    final client = await getClient();
    final response = await client.get(
        Uri.http(APIConfigs.serverIp, APIConfigs.drivers, {'all': 'true'}),
        headers: {'Accept': 'application/json'});
    List rawList = jsonDecode(response.body);
    List<Driver> drivers = [];
    rawList.forEach((element) {
      drivers.add(Driver.fromJson(element));
    });
    return drivers;
  }

  static Future<int> addNewDriver(String name, String phoneNumber) async {
    try {
      final client = await getClient();
      final response = await client.post(
          Uri.http(
            APIConfigs.serverIp,
            APIConfigs.drivers,
          ),
          encoding: Encoding.getByName('utf-8'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'name': name, 'uniqueId': phoneNumber.toString()}));

      return response.statusCode;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  static Future<int> sendCommand(String deviceId, String type) async {
    final response = await Traccar.sendCommands(
        jsonEncode({'deviceId': deviceId, 'type': type}));

    return response.statusCode;
  }
}
