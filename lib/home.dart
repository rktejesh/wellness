import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellness/views/screens/dashboard/dashboard.dart';
import 'package:wellness/views/screens/login/login_screen.dart';
import 'package:wellness/views/screens/register/register_screen.dart';

import 'blocs/auth/auth_bloc.dart';

class Home extends StatelessWidget {
  final AuthBloc authBloc;
  const Home({Key? key, required this.authBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: authBloc,
      builder: (context, state) {
        if (state is UnauthenticatedLoginState) {
          return const RegisterPage();
        } else if (state is UnauthenticatedRegisterState) {
          return const LoginPage();
        } else if (state is AuthenticatedState) {
          return const DashboardScreen();
        } else if (state is LoadingAuthenticationState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ErrorAuthenticationState) {
          return const Scaffold(
            body: Center(
              child: Text("Something is wrong"),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text("something is wrong"),
            ),
          );
        }
      },
    );
  }
}
