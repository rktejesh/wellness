import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellness/blocs/auth/auth_bloc.dart';
import 'package:wellness/helper/validator.dart';
import 'package:wellness/utils/dimensions.dart';
import 'package:wellness/views/base/custom_button.dart';
import 'package:wellness/views/base/custom_text_field.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final forgotPasswordFormKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    return Scaffold(
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
              child: Form(
                key: forgotPasswordFormKey,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                      child: CustomTextFormField(
                          title: 'EMAIL',
                          textEditingController: emailController,
                          textInputType: TextInputType.emailAddress,
                          fn: CustomValidator.validateEmail,
                          obscure: false),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                      child: customButton('LOGIN', () {
                        if (forgotPasswordFormKey.currentState!.validate()) {}
                      }),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
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
    ));
  }
}
