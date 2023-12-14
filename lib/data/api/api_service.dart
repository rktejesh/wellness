import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wellness/data/api/endpoints.dart';
import 'package:wellness/data/model/user.dart';
import 'package:wellness/data/repository/prefs_utils.dart';

import 'api_interface.dart';

class ApiService extends ApiInterface {
  @override
  Future deleteApi(
      {String? url, Map<String, String>? headers, Map? data}) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.delete(Uri.parse(url!),
        headers: <String, String>{
          'accept': 'application/json',
          'content-type': 'application/json',
          'authorization': ApiInterface.auth!
        },
        body: jsonEncode(data));
    responseJson = jsonDecode(response.body);
    return responseJson;
  }

  @override
  Future getApi({
    String? url,
    Map<String, String>? headers,
    bool? require = true,
  }) async {
    var client = http.Client();
    final response = await client.get(Uri.parse(url!),
        headers: headers ??
            <String, String>{
              'accept': 'application/json',
              'content-type': 'application/json',
              'Authorization': "Bearer ${ApiInterface.auth!}"
            });
    return response;
  }

  @override
  Future postApi({
    String? url,
    Map<String, String>? headers,
    Map? data,
    bool? require = false,
  }) async {
    var client = http.Client();
    print(data);
    if (PreferenceUtils.getToken() != null) {
      data = data ?? {};
      if (require == true) {
        data['token'] = PreferenceUtils.getToken();
      }
    }
    http.Response res = await client.post(Uri.parse(url!),
        headers: headers ??
            <String, String>{
              'accept': 'application/json',
              'content-type': 'application/json',
              'Authorization': (require != null && require)
                  ? "Bearer ${ApiInterface.auth!}"
                  : ""
            },
        body: jsonEncode(data));
    return res;
  }

  @override
  Future putApi({String? url, Map<String, String>? headers, Map? data}) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.put(Uri.parse(url!),
        headers: headers ??
            <String, String>{
              'accept': 'application/json',
              'content-type': 'application/json',
              'authorization': ApiInterface.auth!
            },
        body: jsonEncode(data));
    responseJson = jsonDecode(response.body);
    return responseJson;
  }

  Map<String, dynamic>? _parseBaseResponse(http.Response res) {
    debugPrint(jsonEncode(res.body));
    Map<String, dynamic> response = jsonDecode(res.body);
    if (response.containsKey("error")) {
      try {
        List entryList = response['error'].entries.toList();
        List<dynamic> errorList = [];
        for (var element in entryList) {
          errorList.add(element.value.first);
        }
        // DialogHelper.showErrorDialog("Error", errorList.join("\n"));
      } catch (e) {
        // DialogHelper.showErrorDialog("Error", response['error']);
      }
      return null;
    } else {
      return response;
    }
  }

  Future<User?> loginUser(Map<String, dynamic> data) async {
    http.Response res =
        await postApi(url: ApiInterface.baseUrl + EndPoints.login, data: data);
    Map<String, dynamic> response = _parseBaseResponse(res) ?? {};
    if (response.containsKey('user')) {
      await PreferenceUtils.setToken(response['jwt']);
      return User.fromMap(response['user']);
    } else {
      return null;
    }
  }

  Future<User?> registerUser(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + EndPoints.register, data: data);
    Map<String, dynamic> response = _parseBaseResponse(res) ?? {};
    if (response.containsKey('user')) {
      await PreferenceUtils.setToken(response['jwt']);
      return User.fromMap(response['user']);
    } else {
      return null;
    }
  }

  Future<String?> getProfile() async {
    http.Response res = await getApi(
        url: ApiInterface.baseUrl + EndPoints.getProfile, require: true);
    Map<String, dynamic> response = _parseBaseResponse(res) ?? {};
    if (response.containsKey('role')) {
      return response['role'].toString();
    } else {
      return null;
    }
  }

  Future<String?> setProfile(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + EndPoints.getProfile,
        data: data,
        require: true);
    Map<String, dynamic> response = _parseBaseResponse(res) ?? {};
    if (response["entry"].containsKey('role')) {
      return response['role'].toString();
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> predict(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.modelUrl + EndPoints.predict, data: data);
    Map<String, dynamic> response = _parseBaseResponse(res) ?? {};
    return response;
  }
}
