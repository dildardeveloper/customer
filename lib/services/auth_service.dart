// import 'package:firebase_messaging/firebase_messaging.dart';
//
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:traccar_gennissi/traccar_gennissi.dart';
// import 'package:trafco_track_new/Screens/login_screen.dart';
// import 'package:trafco_track_new/configs/api_configs.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:trafco_track_new/services/vehicle_services.dart';
// import 'package:web_socket_channel/io.dart';
//
// import '../configs/api_configs.dart';
//
// enum LoginReponse { LoginSuccess, LoginFailed, UnkownError }
//
// class AuthService {
//   static Future<LoginReponse> login(String email, String password) async {
//     try {
//       String url = APIConfigs.baseUrl + APIConfigs.login;
//
//       http.Response res = await http.post(
//         Uri.parse(url),
//         body: {
//           "email": email,
//           "password": password,
//         },
//         headers: {
//           "Content-Type": "application/x-www-form-urlencoded",
//         },
//         encoding: Encoding.getByName('utf-8'),
//       );
//
//       Traccar.login('', email, password);
//       if (res.statusCode == 200) {
//         await updateUserData(email, password);
//         return LoginReponse.LoginSuccess;
//       } else {
//         return LoginReponse.LoginFailed;
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Unkown Error. Please Try Again Later.');
//
//       return LoginReponse.UnkownError;
//     }
//   }
//
//   static Future<Stream> getWebSocketStream() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cookie = prefs.getString('Cookie');
//
//     IOWebSocketChannel channel = IOWebSocketChannel.connect(
//         "ws://${APIConfigs.serverIp}/api/socket",
//         headers: {'Cookie': cookie});
//     return channel.stream;
//   }
//
//   static logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     String? _notificationToken = await FirebaseMessaging.instance.getToken();
//     await removeNotificationsToken(_notificationToken!);
//     prefs.remove('email');
//     prefs.remove('password');
//
//     Get.offAll(() => LoginScreen());
//   }
//
//   static Future<bool> isLoggedIn() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString("url", APIConfigs.baseUrl);
//     if (prefs.containsKey('email') && prefs.containsKey('password')) {
//       final email = prefs.getString('email');
//       final password = prefs.getString('password');
//       await Traccar.login("", email, password);
//       return true;
//     }
//     return false;
//   }
//
//   static updateNotificationsToken(String _notificationToken) async {
//     final prefs = await SharedPreferences.getInstance();
//     String email = prefs.getString('email')!;
//     String password = prefs.getString('password')!;
//     final client = await VehicleServices.getClient();
//     final response = await client.post(
//       Uri.parse(APIConfigs.baseUrl + APIConfigs.login),
//       body: {"email": email, "password": password},
//       headers: {
//         "Content-Type": "application/x-www-form-urlencoded",
//       },
//       encoding: Encoding.getByName('utf-8'),
//     );
//     Map<String, dynamic> data = jsonDecode(response.body);
//     List oldToken =
//     data['attributes']['notificationTokens'].toString().split(",");
//     var tokens = data['attributes']["notificationTokens"];
//     if (data['attributes'].containsKey("notificationTokens") &&
//         tokens.isNotEmpty) {
//       if (!oldToken.contains(_notificationToken)) {
//         data['attributes']["notificationTokens"] =
//             _notificationToken + "," + tokens;
//       }
//     } else {
//       data['attributes']["notificationTokens"] = _notificationToken;
//     }
//
//     final newresponse = await client.put(
//         Uri.parse(
//             APIConfigs.baseUrl + APIConfigs.user + '/' + data['id'].toString()),
//         headers: {'content-type': 'application/json; charset=utf-8'},
//         body: jsonEncode(data));
//   }
//
//   static removeNotificationsToken(String _notificationToken) async {
//     final prefs = await SharedPreferences.getInstance();
//     String email = prefs.getString('email')!;
//     String password = prefs.getString('password')!;
//     final client = await VehicleServices.getClient();
//     final response = await client.post(
//       Uri.parse(APIConfigs.baseUrl + APIConfigs.login),
//       body: {"email": email, "password": password},
//       headers: {
//         "Content-Type": "application/x-www-form-urlencoded",
//       },
//       encoding: Encoding.getByName('utf-8'),
//     );
//     Map<String, dynamic> data = jsonDecode(response.body);
//     List oldToken =
//     data['attributes']['notificationTokens'].toString().split(",");
//     String tokens = '';
//     if (data['attributes'].containsKey("notificationTokens")) {
//       if (oldToken.contains(_notificationToken)) {
//         oldToken.remove(_notificationToken);
//         for (int i = 0; i < oldToken.length; i++) {
//           tokens = tokens + oldToken[i];
//           if (i != oldToken.length - 1) {
//             tokens = tokens + ',';
//           }
//         }
//       }
//       data['attributes']['notificationTokens'] = tokens;
//     }
//
//     final updateResponse = await client.put(
//         Uri.parse('${APIConfigs.baseUrl}${APIConfigs.user}/${data['id']}'),
//         headers: {'content-type': 'application/json; charset=utf-8'},
//         body: jsonEncode(data));
//   }
//
//   static updateUserData(String email, String password) async {
//     SharedPreferences.getInstance().then((value) {
//       value.setString('email', email);
//       value.setString('password', password);
//     });
//   }
// }
