import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
import 'package:wellness/blocs/auth/auth_bloc.dart';
import 'package:wellness/blocs/login/login_bloc.dart';
import 'package:wellness/data/api/api_service.dart';
import 'package:wellness/helper/validator.dart';
import 'package:wellness/utils/dimensions.dart';
import 'package:wellness/views/base/custom_button.dart';
import 'package:wellness/views/base/custom_text_field.dart';
import 'package:wellness/views/base/loading_screen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool otpsent = false;
  bool isLoading = false;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(
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
              child: isLoading
                  ? const LoadingScreen()
                  : SingleChildScrollView(
                      child: Padding(
                        padding:
                            const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                        child: otpsent
                            ? Form(
                                key: resetPasswordFormKey,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(
                                          Dimensions.PADDING_SIZE_DEFAULT),
                                      child: Text(
                                        "Code has been sent successfully\n to your email",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize:
                                              Dimensions.fontSizeExtraLarge,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(
                                          Dimensions.PADDING_SIZE_DEFAULT),
                                      child: Pinput(
                                        length: 6,
                                        autofocus: true,
                                        onCompleted: (pin) {},
                                        controller: otpController,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(
                                          Dimensions.PADDING_SIZE_DEFAULT),
                                      child: CustomTextFormField(
                                        title: 'PASSWORD',
                                        textEditingController:
                                            passwordController,
                                        textInputType:
                                            TextInputType.visiblePassword,
                                        // fn: CustomValidator.validateEmail,
                                        obscure: true,
                                      ),
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
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please confirm your password';
                                            } else if (value !=
                                                passwordController.text) {
                                              return 'Passwords do not match';
                                            }
                                            return null;
                                          },
                                          obscure: true),
                                    ),
                                    customButton("Submit", () {
                                      if (resetPasswordFormKey.currentState!
                                          .validate()) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        Map<String, dynamic> data = {
                                          "code": otpController.text,
                                          "password": passwordController.text,
                                          "passwordConfirmation":
                                              confirmPasswordController.text
                                        };
                                        ApiService()
                                            .resetPassword(data)
                                            .then((value) {
                                          if (value != null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Password reset was successful'),
                                            ));
                                            BlocProvider.of<AuthBloc>(context)
                                                .add(UserUpdated(value));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text('Error'),
                                              ),
                                            );
                                          }
                                          setState(() {
                                            isLoading = false;
                                          });
                                        });
                                      }
                                    })
                                  ],
                                ),
                              )
                            : Form(
                                key: forgotPasswordFormKey,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(
                                          Dimensions.PADDING_SIZE_DEFAULT),
                                      child: CustomTextFormField(
                                          title: 'EMAIL',
                                          textEditingController:
                                              emailController,
                                          textInputType:
                                              TextInputType.emailAddress,
                                          fn: CustomValidator.validateEmail,
                                          obscure: false),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(
                                          Dimensions.PADDING_SIZE_DEFAULT),
                                      child: customButton('Reset Password', () {
                                        if (forgotPasswordFormKey.currentState!
                                            .validate()) {
                                          setState(() {
                                            isLoading = true;
                                          });

                                          Map<String, dynamic> data = {
                                            "email": emailController.text
                                          };
                                          ApiService()
                                              .forgotPassword(data)
                                              .then(
                                            (value) {
                                              if (value) {
                                                setState(() {
                                                  otpsent = true;
                                                  isLoading = false;
                                                });
                                              } else {
                                                setState(() {
                                                  isLoading = false;
                                                });
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Email not registered'),
                                                  ),
                                                );
                                              }
                                            },
                                          );
                                        }
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
            ),
          ],
        ));
  }
}
