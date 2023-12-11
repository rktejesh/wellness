import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

//for hosting on another device change this to the ip of the device
const String baseUrl = "https://vision-rktejesh.herokuapp.com";

var dio = Dio();

get(String url) async {
  try {
    return await http.get(Uri.parse(baseUrl + url));
  } on SocketException {
    //if connection failed handle here
    print("Server most likely not online (SocketException)");
    return http.Response(
        "", 404); //for handling parsing data, can check status code
  } on http.ClientException {
    print("Server most likely not online (ClientException)");
    return http.Response("", 404);
  }

  //otherwise handle outside
}

delete(String url) async {
  try {
    return await http.delete(Uri.parse(baseUrl + url));
  } catch (e) {
    print(e);
  }
}

put(String url) async {
  try {
    return await http.put(Uri.parse(baseUrl + url));
  } catch (e) {
    print(e);
  }
}

post(FormData formData) async {
  try {
    Response response = await dio
        .post('http://wellness.netgains.org/api/upload', data: formData,
            onSendProgress: (int sent, int total) {
      print('$sent $total');
    });
    print(response.data);
    /*final decodedBytes = base64Decode(response.data);
    var file = File("image.png");
    file.writeAsBytesSync(decodedBytes);*/
    // return response;
    Map<String, dynamic> res = response.data[0] ?? {};
    print(res);
    return res;
  } on http.ClientException {
    print("Server most likely not online, failed post (ClientException)");
  } catch (e) {
    print(e);
  }
}
