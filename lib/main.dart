import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellness/data/repository/prefs_utils.dart';

import 'app.dart';
import 'blocs/bloc_observer.dart';
import 'data/api/api_helper.dart';
import 'data/model/auth.dart';
import 'data/repository/user_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

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
