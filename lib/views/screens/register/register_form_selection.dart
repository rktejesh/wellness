// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:wellness/blocs/auth/auth_bloc.dart';
// import 'package:wellness/blocs/login/login_bloc.dart';
// import 'package:wellness/blocs/register/register_bloc.dart';
// import 'package:wellness/utils/dimensions.dart';
// import 'package:wellness/views/base/custom_button.dart';
// import 'package:wellness/views/screens/register/veterinarian_register_form.dart';

// class RegisterFormSelection extends StatefulWidget {
//   const RegisterFormSelection({super.key});

//   @override
//   State<RegisterFormSelection> createState() => _RegisterFormSelectionState();
// }

// class _RegisterFormSelectionState extends State<RegisterFormSelection> {
//   @override
//   Widget build(BuildContext context) {
//     final registerBloc = BlocProvider.of<RegisterBloc>(context);
//     return BlocListener<RegisterBloc, RegistrationState>(
//         bloc: registerBloc,
//         listener: (context, state) {
//           if (state is RegistrationSuccess) {
//             BlocProvider.of<AuthBloc>(context).add(UserUpdated(state.user));
//           } else if (state is RegistrationFailure) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.error),
//               ),
//             );
//           }
//         },
//         child: BlocBuilder(
//           builder: (context, state) {
//             if (state is RegistrationLoading) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else {
//               return Stack(
//                 alignment: AlignmentDirectional.bottomCenter,
//                 children: [
//                   Align(
//                     alignment: AlignmentDirectional.bottomCenter,
//                     child: SizedBox(
//                       child: Padding(
//                         padding: const EdgeInsets.all(
//                             Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE),
//                         child: SvgPicture.asset(
//                           'assets/svg/logo-blue.svg',
//                           width: MediaQuery.of(context).size.width * 0.2,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: AlignmentDirectional.center,
//                     child: SingleChildScrollView(
//                       child: Padding(
//                         padding:
//                             const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(
//                                   Dimensions.PADDING_SIZE_DEFAULT),
//                               child: customButton('Veterinarian', () {
//                                 // Navigator.pushNamed(context, '/vet-register');
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) =>
//                                         const VeterinarianRegisterForm()));
//                               }),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(
//                                   Dimensions.PADDING_SIZE_DEFAULT),
//                               child: customButton('Horse Owner', () {
//                                 Navigator.pushNamed(context, '/owner-register');
//                               }),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(
//                                   Dimensions.PADDING_SIZE_DEFAULT),
//                               child: customButton('Horse Trainer', () {
//                                 Navigator.pushNamed(
//                                     context, '/trainer-register');
//                               }),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(
//                                   Dimensions.PADDING_SIZE_DEFAULT),
//                               child: customButton('Horse Breeder', () {
//                                 Navigator.pushNamed(
//                                     context, '/breeder-register');
//                               }),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             }
//           },
//         ));
//   }
// }

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellness/blocs/auth/auth_bloc.dart';
import 'package:wellness/blocs/register/register_bloc.dart';
import 'package:wellness/utils/dimensions.dart';
import 'package:wellness/views/base/custom_button.dart';
import 'package:wellness/views/screens/register/veterinarian_register_form.dart';

class RegistrationFormSelection extends StatefulWidget {
  const RegistrationFormSelection({super.key});

  @override
  State<RegistrationFormSelection> createState() =>
      _RegistrationFormSelectionState();
}

class _RegistrationFormSelectionState extends State<RegistrationFormSelection> {
  final RegisterBloc _registerBloc = RegisterBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RegisterBloc>(
        create: (context) => _registerBloc,
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
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: customButton('Veterinarian', () {
                          // Navigator.pushNamed(context, '/vet-register');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (contextLoginScreen) {
                              return BlocProvider.value(
                                  value: _registerBloc,
                                  child: const VeterinarianRegisterForm());
                            }),
                          );
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: customButton('Horse Owner', () {
                          Navigator.pushNamed(context, '/owner-register');
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: customButton('Horse Trainer', () {
                          Navigator.pushNamed(context, '/trainer-register');
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: customButton('Horse Breeder', () {
                          Navigator.pushNamed(context, '/breeder-register');
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
