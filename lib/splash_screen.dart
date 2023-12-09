import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wellness/utils/dimensions.dart';
import 'package:wellness/views/base/custom_button.dart';
import 'blocs/auth/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  final AuthBloc authBloc;

  const SplashScreen({Key? key, required this.authBloc}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }

  route() {
    Navigator.pushReplacementNamed(context, '/index');
  }

  initScreen(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage("assets/images/bg-1.png"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.darken),
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE),
                child: Image.asset('assets/images/logo.png'),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: customButton('LETS GO >', () {
                  Navigator.pushReplacementNamed(context, '/index');
                }),
              )
            ],
          ),
        )
      ],
    ));
  }
}
