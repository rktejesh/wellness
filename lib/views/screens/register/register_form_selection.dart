import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellness/blocs/auth/auth_bloc.dart';
import 'package:wellness/blocs/register/register_bloc.dart';
import 'package:wellness/blocs/register_form/register_form_bloc.dart';
import 'package:wellness/utils/dimensions.dart';
import 'package:wellness/views/base/custom_button.dart';
import 'package:wellness/views/screens/register/breeder_register_form.dart';
import 'package:wellness/views/screens/register/owner_register_form.dart';
import 'package:wellness/views/screens/register/trainer_register_form.dart';
import 'package:wellness/views/screens/register/veterinarian_register_form.dart';

class RegistrationFormSelection extends StatefulWidget {
  const RegistrationFormSelection({super.key});

  @override
  State<RegistrationFormSelection> createState() =>
      _RegistrationFormSelectionState();
}

class _RegistrationFormSelectionState extends State<RegistrationFormSelection> {
  final RegisterFormBloc _registerFormBloc = RegisterFormBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RegisterFormBloc>.value(
        // create: (context) => RegisterFormBloc(),
        value: _registerFormBloc,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(
                      Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE),
                  child: SvgPicture.asset(
                    'assets/svg/logo-blue.svg',
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                  child: Column(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                        child: Text("Select the box that best describes you: "),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: customButton('Veterinarian', () {
                          // Navigator.pushNamed(context, '/vet-register');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (contextLoginScreen) {
                              return BlocProvider.value(
                                  value: _registerFormBloc,
                                  child: const VeterinarianRegisterForm());
                            }),
                          );
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: customButton('Horse Owner', () {
                          // Navigator.pushNamed(context, '/owner-register');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (contextLoginScreen) {
                              return BlocProvider.value(
                                  value: _registerFormBloc,
                                  child: const OwnerRegisterForm());
                            }),
                          );
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: customButton('Horse Trainer', () {
                          // Navigator.pushNamed(context, '/trainer-register');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (contextLoginScreen) {
                              return BlocProvider.value(
                                  value: _registerFormBloc,
                                  child: const TrainerRegisterForm());
                            }),
                          );
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: customButton('Horse Breeder', () {
                          // Navigator.pushNamed(context, '/breeder-register');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (contextLoginScreen) {
                              return BlocProvider.value(
                                  value: _registerFormBloc,
                                  child: const BreederRegisterForm());
                            }),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
