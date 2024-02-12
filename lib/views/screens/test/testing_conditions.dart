import 'package:flutter/material.dart';
import 'package:wellness/data/api/api_service.dart';
import 'package:wellness/data/model/pre_test_requirement.dart';

import 'package:wellness/utils/dimensions.dart';
import 'package:wellness/views/base/custom_button.dart';
import 'package:wellness/views/base/custom_text_field.dart';
import 'package:wellness/views/base/date_time_picker.dart';
import 'package:wellness/views/base/loading_screen.dart';
import 'package:wellness/views/base/radio_group_form_field.dart';
import 'package:wellness/views/screens/instructions/instructions.dart';
import 'package:wellness/views/screens/test/test_dashboard.dart';

import '../instructions/pre_test_instructions.dart';

class TestingConditions extends StatefulWidget {
  final String horseId;
  const TestingConditions({
    Key? key,
    required this.horseId,
  }) : super(key: key);

  @override
  State<TestingConditions> createState() => _TestingConditionsState();
}

class _TestingConditionsState extends State<TestingConditions> {
  int _fastedOrFedValue = -1;
  int _oralSugarTestValue = -1;
  DateTime? _dateTime;
  List<String> selectedOptions = [];
  int? _hoursSinceLastFeeding;
  TextEditingController dateTimeController = TextEditingController();
  final testingFormKey = GlobalKey<FormState>();
  void _onChipSelected(String option) {
    setState(() {
      if (selectedOptions.contains(option)) {
        selectedOptions.clear();
        // selectedOptions.remove(option);
      } else {
        selectedOptions.clear();
        selectedOptions.add(option);
      }
    });
  }

  List<String> options = [
    'hay',
    'ration balancer',
    'sweet feed',
    'pasture',
    'sugar bolus'
  ];

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const LoadingScreen()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Form(
                  key: testingFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RadioGroupFormField(
                        value: _fastedOrFedValue,
                        onChanged: (int value) {
                          setState(() {
                            _fastedOrFedValue = value;
                          });
                        },
                        questionText:
                            "Is this horse fasted or fed? (Please select one)",
                        options: const ["Fasted", "Fed"],
                        validator: (int? value) {
                          return value == -1 ? "Required field" : null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: Text(
                          "When was the last time this horse was fed?",
                          style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: CustomTextFormField(
                          title: "Pick Date and Time",
                          textEditingController: dateTimeController,
                          readOnly: true,
                          onTap: () async {
                            await showDateTimePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    lastDate: DateTime.now())
                                .then((value) {
                              setState(() {
                                _dateTime = value;
                                dateTimeController.text =
                                    "${_dateTime!.day}/${_dateTime!.month}/${_dateTime!.year} ${_dateTime!.hour}:${_dateTime!.minute}";
                                _hoursSinceLastFeeding = _dateTime!
                                    .difference(DateTime.now())
                                    .inHours
                                    .abs();
                              });
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: Text(
                          "Number of hours since last feeding: ${_hoursSinceLastFeeding ?? ""}",
                          style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: Text(
                          "What was the horse's last intake",
                          style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: options
                              .map((option) => NutritionChip(
                                    label: option,
                                    isSelected:
                                        selectedOptions.contains(option),
                                    onSelected: () => _onChipSelected(option),
                                  ))
                              .toList(),
                        ),
                      ),
                      RadioGroupFormField(
                        value: _oralSugarTestValue,
                        onChanged: (int value) {
                          setState(() {
                            _oralSugarTestValue = value;
                          });
                        },
                        questionText:
                            "Did the horse receive a sugar bolus (Oral Sugar Test)?",
                        options: const ["Yes", "No"],
                        validator: (int? value) {
                          return value == -1 ? "Required field" : null;
                        },
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_DEFAULT),
                          child: customButton('Submit', () {
                            if (testingFormKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              PreTestRequirement preTestRequirement =
                                  PreTestRequirement(
                                isFasted: _fastedOrFedValue == 0 ? true : false,
                                lastFedtime: _dateTime,
                                sugarTest:
                                    _oralSugarTestValue == 0 ? true : false,
                                lastIntake: selectedOptions.join(","),
                              );
                              ApiService()
                                  .setPretestRequirements(
                                      preTestRequirement.toMap())
                                  .then((value) {
                                setState(() {
                                  isLoading = false;
                                });
                                if (value != null) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          PreInstructionScreen(
                                            horseId: widget.horseId,
                                            preTestId: value,
                                          )));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Error setting pretest requirements")));
                                }
                              });
                              setState(() {
                                isLoading = false;
                              });
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => const InstructionScreen()));
                              // context
                              //     .read<RegisterBloc>()
                              //     .add(RegisterButtonPressed(formData: {
                              //       "email": emailController.text,
                              //       "password": passwordController.text,
                              //       "username": usernameController.text
                              //     }));
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
