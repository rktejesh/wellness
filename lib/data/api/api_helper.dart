import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellness/data/model/auth.dart';

class DioClient {
  final Dio _dio = Dio();
  // final _baseUrl = 'https://wellness.netgains.org/api';
  final CookieJar cookieJar = CookieJar();
  final Auth auth = Auth.instance;

  static final instance = DioClient();

  DioClient() {
    _dio.interceptors
      ..add(TokenInterceptor())
      ..add(DioCacheInterceptor(options: options))
      ..add(CookieManager(cookieJar));
    cookieJar.loadForRequest(Uri.parse("http://wellness.netgains.org/api"));
  }

  Dio get dio => _dio;
}

class TokenInterceptor extends Interceptor {
  // String? authToken = GetStorage().read('token');

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("token")) {
      String? authToken = prefs.getString('token');
      options.headers["authorization"] = "Bearer $authToken";
    }
    print(options.headers);
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}'
        'DATA => ${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    print(err.response?.data);
    return super.onError(err, handler);
  }
}

// Global options
final options = CacheOptions(
  store: MemCacheStore(),
  policy: CachePolicy.request,
  hitCacheOnErrorExcept: [401, 403],
  maxStale: const Duration(hours: 1),
  priority: CachePriority.high,
);
