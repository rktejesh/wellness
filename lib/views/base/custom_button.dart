import 'package:flutter/material.dart';
import 'package:wellness/helper/validator.dart';
import 'package:wellness/utils/dimensions.dart';

Widget customButton(String title, void Function()? onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
    child: Container(
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFF003d7b), Color(0xFF0070bc)])),
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
