import 'package:flutter/material.dart';
import 'package:wellness/helper/validator.dart';
import 'package:wellness/utils/dimensions.dart';

Widget customButton(String title, void Function()? onPressed,
    {bool disabled = false}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
    child: Container(
        decoration: BoxDecoration(
          gradient: disabled == false
              ? const LinearGradient(colors: [
                  Color(0xFF884ad1),
                  Color.fromARGB(255, 123, 64, 189)
                ])
              : LinearGradient(colors: [
                  const Color(0xFF003d7b).withOpacity(0.5),
                  const Color(0xFF0070bc).withOpacity(0.5)
                ]),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE,
              vertical: Dimensions.PADDING_SIZE_DEFAULT),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        )),
  );
}
