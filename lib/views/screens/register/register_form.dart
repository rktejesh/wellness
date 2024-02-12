import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellness/blocs/auth/auth_bloc.dart';
import 'package:wellness/blocs/register/register_bloc.dart';
import 'package:wellness/helper/validator.dart';
import 'package:wellness/utils/dimensions.dart';
import 'package:wellness/views/base/custom_button.dart';
import 'package:wellness/views/base/custom_text_field.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final registerFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RegisterBloc(),
        child: Scaffold(
          body: BlocConsumer<RegisterBloc, RegistrationState>(
              listener: (context, state) {
            if (state is RegistrationSuccess) {
              BlocProvider.of<AuthBloc>(context).add(UserUpdated(state.user));
            } else if (state is RegistrationFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          }, builder: (context, state) {
            if (state is RegistrationLoading) {
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
                          key: registerFormKey,
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
                              // Padding(
                              //   padding: const EdgeInsets.all(
                              //       Dimensions.PADDING_SIZE_DEFAULT),
                              //   child: CustomTextFormField(
                              //       title: 'FULL NAME',
                              //       textEditingController: usernameController,
                              //       textInputType: TextInputType.name,
                              // fn: CustomValidator.validateEmail,
                              //       obscure: false),
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_DEFAULT),
                                child: CustomTextFormField(
                                    title: 'PASSWORD',
                                    textEditingController: passwordController,
                                    textInputType:
                                        TextInputType.visiblePassword,
                                    // fn: CustomValidator.validateEmail,
                                    obscure: true),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_DEFAULT),
                                child: CustomTextFormField(
                                    title: 'CONFIRM PASSWORD',
                                    textEditingController:
                                        confirmPasswordController,
                                    textInputType:
                                        TextInputType.visiblePassword,
                                    // CustomValidator.validatePassword,
                                    fn: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please confirm your password';
                                      } else if (value !=
                                          passwordController.text) {
                                        return 'Passwords do not match';
                                      }
                                      return null;
                                    },
                                    obscure: true),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_DEFAULT),
                                child: customButton('Register', () {
                                  if (registerFormKey.currentState!
                                      .validate()) {
                                    context
                                        .read<RegisterBloc>()
                                        .add(RegisterButtonPressed(formData: {
                                          "email": emailController.text,
                                          "password": passwordController.text,
                                          "username": emailController.text
                                        }));
                                  }
                                }),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_DEFAULT),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Already have an account? ',
                                    style: DefaultTextStyle.of(context).style,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () =>
                                          BlocProvider.of<AuthBloc>(context)
                                              .add(ChangAuthMethod()),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Login',
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
        ));
  }
}
