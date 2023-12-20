import 'package:flutter/material.dart';
import 'package:wellness/utils/dimensions.dart';
import 'package:wellness/views/base/custom_button.dart';
import 'package:wellness/views/base/custom_text_field.dart';
import 'package:wellness/views/base/date_time_picker.dart';
import 'package:wellness/views/base/radio_group_form_field.dart';
import 'package:wellness/views/screens/instructions/instructions.dart';
import 'package:wellness/views/screens/test/test_dashboard.dart';

class TestingConditions extends StatefulWidget {
  const TestingConditions({super.key});

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
  void _onChipSelected(String option) {
    setState(() {
      if (selectedOptions.contains(option)) {
        selectedOptions.remove(option);
      } else {
        selectedOptions.add(option);
      }
    });
  }

  List<String> options = [
    'hay',
    'ration balancer',
    'sweet feed',
    'pasture',
    'sugar bolus (Oral Sugar Test)'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
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
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Text(
                  "When was the last time this horse was fed?",
                  style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: CustomTextFormField(
                  title: "Pick Date and Time",
                  textEditingController: dateTimeController,
                  readOnly: true,
                  onTap: () async {
                    DateTime? dt = await showDateTimePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        lastDate: DateTime.now());
                    setState(() {
                      _dateTime = dt;
                      dateTimeController.text =
                          "${_dateTime!.day}/${_dateTime!.month}/${_dateTime!.year} ${_dateTime!.hour}:${_dateTime!.minute}";
                      _hoursSinceLastFeeding =
                          _dateTime!.difference(DateTime.now()).inHours.abs();
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Text(
                  "Number of hours since last feeding: ${_hoursSinceLastFeeding ?? ""}",
                  style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Text(
                  "What was the horse's last intake",
                  style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: options
                      .map((option) => NutritionChip(
                            label: option,
                            isSelected: selectedOptions.contains(option),
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
                  padding:
                      const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: customButton('Submit', () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const InstructionScreen()));
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
