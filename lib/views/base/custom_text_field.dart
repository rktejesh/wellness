import 'package:flutter/material.dart';
import 'package:wellness/utils/dimensions.dart';

Widget customTextField(
    String title,
    TextEditingController textEditingController,
    TextInputType? textInputType,
    String? Function(String?)? fn) {
  return Padding(
    padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
    child: TextFormField(
      decoration: InputDecoration(
        focusColor: Colors.black,
        floatingLabelStyle: const TextStyle(color: Colors.black),
        labelText: title,
        border: InputBorder.none,
      ),
      keyboardType: textInputType ?? TextInputType.text,
      controller: textEditingController,
      validator: fn ?? defaultValidator,
    ),
  );
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.title,
      this.textEditingController,
      this.textInputType,
      this.fn,
      this.onTap,
      this.obscure,
      this.prefix,
      this.readOnly,
      this.textAlign,
      this.suffix,
      this.autocorrect});

  final String? title;
  final TextEditingController? textEditingController;
  final TextInputType? textInputType;
  final String? Function(String?)? fn;
  final void Function()? onTap;
  final bool? obscure;
  final Widget? prefix;
  final Widget? suffix;
  final bool? readOnly;
  final TextAlign? textAlign;
  final bool? autocorrect;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly ?? false,
      autocorrect: autocorrect ?? false,
      decoration: InputDecoration(
          filled: true,
          focusColor: Colors.black,
          floatingLabelStyle: const TextStyle(
            color: Colors.black,
          ),
          label: Center(
            child: Text(title ?? ""),
          ),
          prefix: prefix,
          suffix: suffix,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: const OutlineInputBorder(borderSide: BorderSide.none)),
      textAlign: textAlign ?? TextAlign.center,
      validator: fn ?? defaultValidator,
      obscureText: obscure ?? false,
      keyboardType: textInputType ?? TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: textEditingController,
    );
  }
}

// Widget customTextFormField(
//     String title,
//     TextEditingController textEditingController,
//     TextInputType? textInputType,
//     String? Function(String?)? fn,
//     void Function()? onTap,
//     bool obscure) {
//   final void Function()? onTap;

//   return TextFormField(
//     onTap: onTap,
//     decoration: InputDecoration(
//         filled: true,
//         focusColor: Colors.black,
//         floatingLabelStyle: const TextStyle(
//           color: Colors.black,
//         ),
//         label: Center(
//           child: Text(title),
//         ),
//         floatingLabelBehavior: FloatingLabelBehavior.never,
//         border: const OutlineInputBorder(borderSide: BorderSide.none)),
//     textAlign: TextAlign.center,
//     validator: fn ?? defaultValidator,
//     obscureText: obscure,
//     keyboardType: textInputType ?? TextInputType.text,
//     autovalidateMode: AutovalidateMode.onUserInteraction,
//     controller: textEditingController,
//   );
// }

String? defaultValidator(String? value) {
  if (value != null) {
    if (value.trim().isEmpty) {
      return 'Field cannot be blank';
    }
  }
  return null;
}
