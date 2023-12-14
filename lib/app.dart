import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:wellness/splash_screen.dart';
import 'package:wellness/utils/app_constants.dart';
import 'package:wellness/views/screens/dashboard/dashboard.dart';
import 'package:wellness/views/screens/register/breeder_register_form.dart';
import 'package:wellness/views/screens/register/owner_register_form.dart';
import 'package:wellness/views/screens/register/trainer_register_form.dart';
import 'package:wellness/views/screens/register/veterinarian_register_form.dart';

import 'blocs/auth/auth_bloc.dart';
import 'data/api/api_helper.dart';
import 'data/model/auth.dart';
import 'data/repository/user_repository.dart';
import 'home.dart';

class MyApp extends StatefulWidget {
  final UserRepository userRepository;
  final Auth auth;
  final DioClient dioClient;
  const MyApp({
    super.key,
    required this.userRepository,
    required this.auth,
    required this.dioClient,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthBloc authBloc;
  UserRepository get userRepository => widget.userRepository;
  Auth get auth => widget.auth;
  DioClient get dioClient => widget.dioClient;

  @override
  void initState() {
    authBloc = AuthBloc(userRepository: userRepository, dioClient: dioClient);
    authBloc.add(AppLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => authBloc,
        ),
      ],
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp(
          title: AppConstants.APP_NAME,
          builder: (context, child) => ResponsiveWrapper.builder(child,
              maxWidth: 1200,
              minWidth: 480,
              defaultScale: true,
              breakpoints: [
                // const ResponsiveBreakpoint.resize(480, name: MOBILE),
                const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                const ResponsiveBreakpoint.autoScale(2360, name: '4K'),
              ],
              background: Container(color: const Color(0xFFF5F5F5))),
          debugShowCheckedModeBanner: false,
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
          ),
          routes: {
            '/': (context) => SplashScreen(
                  authBloc: authBloc,
                ),
            "/index": (context) => Home(authBloc: authBloc),
            "/dashboard": (context) => const DashboardScreen(),
            "/vet-register": (context) => const VeterinarianRegisterForm(),
            "/owner-register": (context) => const OwnerRegisterForm(),
            "/trainer-register": (context) => const TrainerRegisterForm(),
            "/breeder-register": (context) => const BreederRegisterForm(),
            // "/home": (context) => const HomeScreen(),
            // "/location": (context) => const SelectLocationScreen(),
            // "/cart": (context) => const CartScreen(),
            // "/terms": (context) => const TermsConditionsScreen(),
            // "/about": (context) => const AboutScreen(),
            // "/privacy": (context) => const PrivacyPolicyScreen(),
            // "/address": (context) => const AddressDetailsScreen(),
            // "/addons": (context) => const AddonsScreen(),
            // "/booking-data": (context) => const SelectBookingDateScreen(),
            // "/payment": (context) => const PaymentScreen(),
            // "/payment-success": (context) => const BookingSuccessScreen()
          },
        ),
      ),
    );
  }
}
