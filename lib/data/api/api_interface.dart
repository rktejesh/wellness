import 'package:wellness/data/repository/prefs_utils.dart';

abstract class ApiInterface {
  //static const oldbaseUrl = "https://wahine.netgains.org/api/";
  //static const oldimgPath = "https://wahine.netgains.org/";
  static const baseUrl = "http://wellness.netgains.org/api/";
  static const modelUrl = "http://wellness.netgains.org/ml/";
  static String? auth = PreferenceUtils.getString('token') ?? "";

  Future getApi({
    String? url,
    Map<String, String>? headers,
  });

  Future postApi({
    String? url,
    Map<String, String>? headers,
    Map? data,
  });

  Future putApi({
    String? url,
    Map<String, String>? headers,
    Map? data,
  });

  Future deleteApi({
    String? url,
    Map<String, String>? headers,
    Map? data,
  });
}
