import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellness/blocs/register/register_bloc.dart';
import 'package:wellness/views/screens/register/register_form.dart';
import 'package:wellness/views/screens/register/register_form_selection.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: BlocProvider<RegisterBloc>(
      //   create: (context) => RegisterBloc(),
      //   child: const RegisterForm(),
      // ),
      body: RegisterForm(),
    );
  }
}
