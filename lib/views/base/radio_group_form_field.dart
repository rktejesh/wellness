import 'package:flutter/material.dart';
import 'package:wellness/utils/dimensions.dart';

class RadioGroupFormField extends FormField<int> {
  RadioGroupFormField({
    Key? key,
    required int value,
    required ValueChanged<int> onChanged,
    required String questionText,
    List<String> options = const [],
    FormFieldSetter<int>? onSaved,
    FormFieldValidator<int>? validator,
  }) : super(
          key: key,
          initialValue: value,
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          builder: (FormFieldState<int> field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: Dimensions.PADDING_SIZE_DEFAULT,
                    left: Dimensions.PADDING_SIZE_DEFAULT,
                    right: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  child: Text(
                    questionText,
                    style: TextStyle(
                      fontSize: Dimensions
                          .fontSizeLarge, // Adjust the font size as needed
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: options.asMap().entries.map((entry) {
                    int index = entry.key;
                    String optionText = entry.value;
                    return Row(
                      children: <Widget>[
                        Text(
                          optionText,
                          style: TextStyle(
                            fontSize: Dimensions
                                .fontSizeLarge, // Adjust the font size as needed
                          ),
                        ),
                        Radio(
                          value: index,
                          groupValue: field.value,
                          onChanged: (int? value) {
                            field.didChange(value);
                            onChanged(value!);
                          },
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            );
          },
        );
}
