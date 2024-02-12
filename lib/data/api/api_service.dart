import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wellness/data/api/endpoints.dart';
import 'package:wellness/data/model/horse/horse.dart';
import 'package:wellness/data/model/test_data/test_data.dart';
import 'package:wellness/data/model/test_procedure/test_procedure.dart';
import 'package:wellness/data/model/user.dart';
import 'package:wellness/data/model/user_profile/user_profile.dart';
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
    bool? require,
  }) async {
    var client = http.Client();
    final response = await client.get(Uri.parse(url!),
        headers: headers ??
            <String, String>{
              'accept': 'application/json',
              'content-type': 'application/json',
              // 'authorization': "Bearer ${PreferenceUtils.getToken()}"
              'authorization': (require != null && require)
                  ? "Bearer ${PreferenceUtils.getToken()}"
                  : " "
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
    // if (PreferenceUtils.getToken() != null) {
    //   data = data ?? {};
    //   if (require == true) {
    //     data['token'] = PreferenceUtils.getToken();
    //   }
    // }
    http.Response res = await client.post(Uri.parse(url!),
        headers: headers ??
            <String, String>{
              'accept': 'application/json',
              'content-type': 'application/json',
              // 'authorization': "Bearer ${PreferenceUtils.getToken()}"
              'authorization': (require != null && require)
                  ? "Bearer ${PreferenceUtils.getToken()}"
                  : " "
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
              // 'authorization': ApiInterface.auth!
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
      return response;
    } else {
      return response;
    }
  }

  Future<User?> loginUser(Map<String, dynamic> data) async {
    http.Response res =
        await postApi(url: ApiInterface.baseUrl + EndPoints.login, data: data);
    Map<String, dynamic> response = _parseBaseResponse(res) ?? {};
    if (response.containsKey('user')) {
      return await PreferenceUtils.setToken(response['jwt']).then((value) {
        return User.fromMap(response['user']);
      });
    } else {
      // return null;
      throw (response['error']["message"]);
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
      throw (response["error"]["message"]);
    }
  }

  Future<bool> forgotPassword(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + EndPoints.forgotPassword,
        data: data,
        require: false);
    Map<String, dynamic> response = _parseBaseResponse(res) ?? {};
    if (response.containsKey('ok')) {
      return true;
    } else {
      return false;
    }
  }

  Future<User?> resetPassword(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + EndPoints.resetPassword,
        data: data,
        require: false);
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

  Future<String?> setProfile(Map<String, dynamic> data, String profile) async {
    Map<String, dynamic> newData = {"profile": profile, "data": data};
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + EndPoints.setProfile,
        data: newData,
        require: true);
    Map<String, dynamic> response = _parseBaseResponse(res) ?? {};
    if (response.containsKey('userId')) {
      return response['userId'].toString();
    } else {
      return null;
    }
  }

  Future<String?> setPretestRequirements(Map<String, dynamic> data) async {
    Map<String, dynamic> newData = {"data": data};
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + EndPoints.preTestRequirements,
        data: newData,
        require: false);
    Map<String, dynamic> response = _parseBaseResponse(res) ?? {};
    if (response.containsKey('data') && response['data'].containsKey('id')) {
      return response['data']['id'].toString();
    } else {
      return null;
    }
  }

  Future<UserProfile> getUserData() async {
    http.Response res = await getApi(
        url: ApiInterface.baseUrl + EndPoints.getProfile, require: true);
    Map<String, dynamic> response = _parseBaseResponse(res) ?? {};
    // if (response.containsKey('user_details') &&
    //     response['user_details'].containsKey('id')) {
    //   return response;
    // } else {
    //   return null;
    // }
    UserProfile userDetails = UserProfile.fromMap(response);
    return userDetails;
  }

  Future<String?> registerHorse(Map<String, dynamic> data) async {
    UserProfile user = await getUserData();
    // if (res.containsKey('role') &&
    //     res['role'] != "NA" &&
    //     res.containsKey('user_details') &&
    //     res['user_details'].containsKey(res['role']) &&
    //     res['user_details'][res['role']].containsKey('id')) {
    //   data.addAll({res['role']: res['user_details'][res['role']]['id']});
    // }
    if (user.role != null && user.role != "NA" && user.userDetails != null) {
      if (user.role == "trainer") {
        data.addAll({"trainer": user.userDetails!.trainer!.id});
      } else if (user.role == "owner") {
        data.addAll({"owner": user.userDetails!.owner!.id});
      } else if (user.role == "vet") {
        data.addAll({"veterinarian": user.userDetails!.veterinarian!.id});
      } else if (user.role == "breeder") {
        data.addAll({"breeder": user.userDetails!.breeder!.id});
      }
    }
    data.removeWhere((key, value) => value == null);
    Map<String, dynamic> newData = {"data": data};
    http.Response res2 = await postApi(
        url: ApiInterface.baseUrl + EndPoints.registerHorse,
        data: newData,
        require: false);
    Map<String, dynamic> response = _parseBaseResponse(res2) ?? {};
    if (response.containsKey('data') && response['data'].containsKey('id')) {
      return response['data']['id'].toString();
    } else {
      return null;
    }
  }

  Future<List<Horse>> getHorses() async {
    http.Response res = await getApi(
        url: ApiInterface.baseUrl + EndPoints.getHorses, require: true);
    Map<String, dynamic> response = _parseBaseResponse(res) ?? {};
    if (response.containsKey('data')) {
      List<Horse> horses = [];
      for (var element in response['data']) {
        horses.add(Horse.fromMap(element));
      }
      return horses;
    } else {
      return [];
    }
  }

  Future<Map<String, int>> getBreeds() async {
    http.Response res = await getApi(
        url: ApiInterface.baseUrl + EndPoints.getBreeds, require: false);
    Map<String, dynamic> response = _parseBaseResponse(res) ?? {};
    print(response);
    if (response.containsKey('data')) {
      Map<String, int> breeds = {};
      for (var element in response['data']) {
        breeds[element['attributes']['name']] = element['id'];
      }
      return breeds;
    } else {
      return {};
    }
  }

  Future<String?> sendImage(
    Map<String, dynamic> data,
    String id,
  ) async {
    // http.Response res = await postApi(
    //     url: "https://temp-server-sf6e.onrender.com/create",
    //     data: data,
    //     require: true);
    var response = await putApi(
      url: "${ApiInterface.baseUrl}${EndPoints.testData}/$id",
      data: data,
    );
    // Map<String, dynamic> response = _parseBaseResponse(res2) ?? {};
    if (response.containsKey('data') && response['data'].containsKey('id')) {
      return response['data']['id'].toString();
    } else {
      return null;
    }
  }

  Future<String?> getUserProfile() async {
    http.Response res = await getApi(
        url: ApiInterface.baseUrl + EndPoints.getProfile, require: true);
    Map<String, dynamic> response = _parseBaseResponse(res) ?? {};
    if (response.containsKey('user_details') &&
        response['user_details'].containsKey('id')) {
      return response['user_details']['id'].toString();
    } else {
      return null;
    }
  }

  Future<String?> setTestData(Map<String, dynamic> data) async {
    String? id = await getUserProfile();
    if (id != null) {
      // data['conducted_by'] = id;
      data.addAll({"conducted_by": id});
    }
    Map<String, dynamic> newData = {"data": data};
    http.Response res = await postApi(
      url: ApiInterface.baseUrl + EndPoints.testData,
      data: newData,
      require: false,
    );

    Map<String, dynamic> response = _parseBaseResponse(res) ?? {};
    if (response.containsKey('data') && response['data'].containsKey('id')) {
      return response['data']['id'].toString();
    } else {
      return null;
    }
  }

  Future<List<TestData>> getTestData() async {
    http.Response res = await getApi(
        url: "${ApiInterface.baseUrl}${EndPoints.getTestData}", require: true);
    Map<String, dynamic> response = _parseBaseResponse(res) ?? {};

    if (response.containsKey('data')) {
      List<TestData> tests = [];
      for (var element in response['data']) {
        tests.add(TestData.fromMap(element));
      }
      tests.sort((a, b) => b.id!.compareTo(a.id!));
      return tests;
    } else {
      return [];
    }
  }

  Future<List<TestProcedure>> getTestProcedureData() async {
    http.Response res = await getApi(
        url: "${ApiInterface.baseUrl}${EndPoints.getTestInstructionData}",
        require: false);
    Map<String, dynamic> response = _parseBaseResponse(res) ?? {};
    if (response.containsKey('data')) {
      List<TestProcedure> tests = [];
      for (var element in response['data']) {
        tests.add(TestProcedure.fromMap(element));
      }
      return tests;
    } else {
      return [];
    }
  }

  Future<Map<String, dynamic>> getConfig() async {
    http.Response res = await getApi(
        url: "${ApiInterface.baseUrl}${EndPoints.getConfig}", require: false);
    Map<String, dynamic> response = _parseBaseResponse(res) ?? {};
    // return response;
    Map<String, dynamic> config = {};
    response['data']['attributes'].forEach((key, value) {
      config[key] = value;
    });
    return config;
  }

  Future<Map<String, dynamic>> predict(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.modelUrl + EndPoints.predict, data: data);
    Map<String, dynamic> response = _parseBaseResponse(res) ?? {};
    return response;
  }
}
