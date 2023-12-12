import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellness/blocs/auth/auth_bloc.dart';
import 'package:wellness/blocs/login/login_bloc.dart';
import 'package:wellness/helper/validator.dart';
import 'package:wellness/utils/dimensions.dart';
import 'package:wellness/views/base/custom_button.dart';
import 'package:wellness/views/base/custom_text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _LoginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    return BlocListener<LoginBloc, LoginState>(
      bloc: loginBloc,
      listener: (context, state) {
        if (state is LoginSuccess) {
          BlocProvider.of<AuthBloc>(context).add(UserUpdated(state.user));
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
          bloc: loginBloc,
          builder: (context, state) {
            if (state is LoginLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Stack(
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
                        padding:
                            const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                        child: Form(
                          key: _LoginFormKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_DEFAULT),
                                child: CustomTextFormField(
                                    title: 'EMAIL',
                                    textEditingController: emailController,
                                    textInputType: TextInputType.emailAddress,
                                    fn: CustomValidator.validateEmail,
                                    obscure: false),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_DEFAULT),
                                child: CustomTextFormField(
                                    title: 'PASSWORD',
                                    textEditingController: passwordController,
                                    textInputType:
                                        TextInputType.visiblePassword,
                                    // fn: CustomValidator.validatePassword,
                                    // fn: null,
                                    obscure: true),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(
                              //       Dimensions.PADDING_SIZE_DEFAULT),
                              //   child: TextButton(
                              //     onPressed: () {
                              //       // setState(() {
                              //       //   loading = true;
                              //       // });
                              //       // print(loading);
                              //       // if (_LoginFormKey.currentState!
                              //       //     .validate()) {
                              //       //   print(phoneNumberController.text);
                              //       //   widget.authBloc.userRepository
                              //       //       .sendOtp(phoneNumberController.text)
                              //       //       .then((value) {
                              //       //     if (value) {
                              //       //       Navigator.of(context).push(
                              //       //           MaterialPageRoute(
                              //       //               builder: (context) =>
                              //       //                   const DashboardScreen()));
                              //       //       setState(() {
                              //       //         loading = false;
                              //       //       });
                              //       //     } else {
                              //       //       setState(() {
                              //       //         loading = false;
                              //       //       });
                              //       //       const snackBar = SnackBar(
                              //       //         content: Text('Error sending OTP!'),
                              //       //         backgroundColor: (Colors.black12),
                              //       //       );
                              //       //       ScaffoldMessenger.of(context)
                              //       //           .showSnackBar(snackBar);
                              //       //     }
                              //       //   });
                              //       // } else {
                              //       //   setState(() {
                              //       //     loading = false;
                              //       //   });
                              //       // }
                              //
                              //     },
                              //     child: const Text("Get OTP"),
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_DEFAULT),
                                child: customButton('LOGIN', () {
                                  if (_LoginFormKey.currentState!.validate()) {
                                    loginBloc.add(LoginButtonPressed(
                                        email: emailController.text,
                                        password: passwordController.text));
                                  }
                                }),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_DEFAULT),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Don\'t have an account? ',
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Register',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () =>
                                              BlocProvider.of<AuthBloc>(context)
                                                  .add(ChangAuthMethod()),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}
