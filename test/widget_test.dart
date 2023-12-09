// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellness/app.dart';
import 'package:wellness/data/api/api_helper.dart';
import 'package:wellness/data/model/auth.dart';
import 'package:wellness/data/repository/user_repository.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Auth auth = Auth.instance;
    DioClient dioClient = DioClient.instance;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await tester.pumpWidget( MyApp(userRepository: UserRepository(auth: auth, dioClient: dioClient), dioClient: DioClient.instance, auth: Auth.instance,));


    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
