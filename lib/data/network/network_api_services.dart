import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../controllers/user_preference/user_prefrence_view_model.dart';
import '../../model/login_model.dart';
import '../app_exceptions.dart';
import 'base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  UserPreference userPreference = UserPreference();
  @override
  Future<dynamic> getApi(String url) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    try {
      LoginModel userModel = await userPreference.getUser();
      final String? getToken = userModel.data?.bearerToken;

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $getToken',
        },
      ).timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);

      if (response.statusCode == 200) {

        responseJson = returnResponse(response);
      } else {
        print("HTTP Error ${response.statusCode}: ${response.body}");
      }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    print(responseJson);
    return responseJson;
  }

  @override
  Future<dynamic> postApi(var data, String url) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson;
    try {
      LoginModel userModel = await userPreference.getUser();
      final String? getToken = userModel.data?.bearerToken;
      debugPrint("=========ApiToken:$getToken=========");
      debugPrint("postUrl:${Uri.parse(url)}");
      var _jsonModel = json.encode(data);
      debugPrint("postModel:$_jsonModel");
      final response = await http
          .post(Uri.parse(url), body: data,headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $getToken',
      })
          .timeout(const Duration(seconds: 20));
      responseJson = returnResponse(response);

      if (response.statusCode == 200) {
        responseJson = returnResponse(response);
      } else {
        print("HTTP Error ${response.statusCode}: ${response.body}");
      }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } catch(e){
      print(e.toString());
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  @override
  Future<dynamic> updateApi(var data, String url) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson;
    try {
      LoginModel userModel = await userPreference.getUser();
      final String? getToken = userModel.data?.bearerToken;
      debugPrint("=========ApiToken:$getToken=========");
      debugPrint("postUrl:${Uri.parse(url)}");
      var _jsonModel = json.encode(data);
      debugPrint("postModel:$_jsonModel");
      final response = await http.post(Uri.parse(url), body: data,
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $getToken',
          }).timeout(const Duration(seconds: 40));
      print("The Bearer Token $getToken");
      print("Raw Response Body: ${response.body}");
      responseJson = returnResponse(response);

      if (response.statusCode == 200) {
        print("Response OK: ${response.body}");
        // responseJson = returnResponse(response);
      } else {
        print("HTTP Error ${response.statusCode}: ${response.body}");
      }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {

    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 401:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 404:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 405:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 500:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      default:
        throw FetchDataException(
            'Error accoured while communicating with server ' +
                response.statusCode.toString());
    }
  }

}
