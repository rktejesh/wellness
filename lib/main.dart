import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:wellness/data/repository/prefs_utils.dart';
import 'package:wellness/splash_screen.dart';

import 'app.dart';
import 'blocs/bloc_observer.dart';
import 'data/api/api_helper.dart';
import 'data/model/auth.dart';
import 'data/repository/user_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  Auth auth = Auth.instance;
  DioClient dioClient = DioClient.instance;
  await PreferenceUtils.init();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  UserRepository userRepository =
      UserRepository(auth: auth, dioClient: dioClient);
  // runApp(const MyApp());
  runApp(MyApp(
    userRepository: userRepository,
    auth: auth,
    dioClient: dioClient,
  ));
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }
