import 'package:flutter/material.dart';
import 'package:wellness/helper/validator.dart';
import 'package:wellness/utils/dimensions.dart';
import 'package:wellness/views/base/custom_button.dart';
import 'package:wellness/views/base/custom_text_field.dart';
import 'package:wellness/views/base/radio_group_form_field.dart';
import 'package:wellness/views/screens/test/testing_conditions.dart';

class TestDashboard extends StatefulWidget {
  const TestDashboard({super.key});

  @override
  State<TestDashboard> createState() => _TestDashboardState();
}

class _TestDashboardState extends State<TestDashboard> {
  int _radioValue = 0;
  int _diseaseValue = -1;
  int _diseaseEpisodes = -1;
  int _ppidDiseaseValue = -1;
  int _dryLotValue = -1;
  int _metabolicSupplementValue = -1;
  int _hoofSupplementValue = -1;
  int index = 1;
  int? selectedValue;
  int? horseBodyConditionScore;
  List<String> weightUnits = ['Pounds', 'Kilograms'];
  String selectedUnit = 'Pounds'; // Default unit
  List<String> selectedOptions = [];
  static const List<String> breedList = <String>[
    "Appaloosa",
    "Arabian",
    "Bashkir Curly",
    "Clydesdale",
    "Donkey",
    "Friesian",
    "Gypsy Vanner",
    "Haflinger",
    "Lipizzan",
    "Lusitano",
    "Miniature",
    "Missouri Fox Trotter",
    "Morab",
    "Morgan",
    "Mule",
    "Mustang",
    "Norwegian Fjord",
    "Paint",
    "Paso Fino",
    "Percheron",
    "Pinto",
    "Pony",
    "Quarter Horse",
    "Racking Horse",
    "Saddlebred",
    "Spanish - Norman",
    "Spanish Barb",
    "Spotted Mountain Horse",
    "Spotted Saddle Horse",
    "Standardbred",
    "Tennessee Walking Horse",
    "Thoroughbred",
    "Warmblood",
    "Other"
  ];

  static const List<String> disciplineList = <String>[
    "Barrel Racing",
    "Cow Horse",
    "Cutting",
    "Dressage",
    "Endurance",
    "Eventing",
    "Hunter",
    "Jumper",
    "Pleasure",
    "Racing",
    "Reining",
    "Trail Riding",
    "Other"
  ];

  static const List<String> exerciseList = <String>[
    "none",
    "1x weekly",
    "2x weekly",
    "3x weekly",
    "Daily"
  ];
  String breedDropdownValue = breedList.first;
  String disciplineDropdownValue = disciplineList.first;
  String exerciseDropdownValue = exerciseList.first;
  final registerFormKey = GlobalKey<FormState>();
  final TextEditingController horseBarnNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  void _handleRadioValueChange(int? value) {
    setState(() {
      if (value != null) {
        _radioValue = value;
      }
    });
  }

  void _onChipSelected(String option) {
    setState(() {
      if (selectedOptions.contains(option)) {
        selectedOptions.remove(option);
      } else {
        selectedOptions.add(option);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: Column(
            children: [
              Text(
                "Has this horse ever undergone Wellness Ready Insulin Testing?",
                style: TextStyle(
                  fontSize: Dimensions.fontSizeExtraLarge,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Yes',
                    style: TextStyle(
                      fontSize: Dimensions.fontSizeLarge,
                    ),
                  ),
                  Radio(
                    value: 1,
                    groupValue: _radioValue,
                    onChanged: _handleRadioValueChange,
                  ),
                  Text(
                    'No',
                    style: TextStyle(
                      fontSize: Dimensions.fontSizeLarge,
                    ),
                  ),
                  Radio(
                    value: 2,
                    groupValue: _radioValue,
                    onChanged: _handleRadioValueChange,
                  ),
                ],
              ),
              _radioValue == 0
                  ? const SizedBox()
                  : _radioValue == 1
                      ? _previouslyTested()
                      : index == 1
                          ? _newHorse()
                          : _newHorseContinued(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _previouslyTested() {
    return const Column(
      children: [
        Text("Select a previously tested horse to conduct a new test")
      ],
    );
  }

  Widget _newHorse() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: Text(
            "Register a horse that has not been tested",
            style: TextStyle(fontSize: Dimensions.fontSizeLarge),
          ),
        ),
        Form(
          key: registerFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: CustomTextFormField(
                    title: 'Horse\'s Barn Name',
                    textEditingController: horseBarnNameController,
                    textInputType: TextInputType.name,
                    // fn: CustomValidator.validateEmail,
                    obscure: false),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    vertical: Dimensions.PADDING_SIZE_SMALL),
                child: DropdownButton<String>(
                  value: breedDropdownValue,
                  isExpanded: true,
                  onChanged: (String? value) {
                    setState(() {
                      breedDropdownValue = value ?? "";
                    });
                  },
                  items:
                      breedList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Text(
                  "Year Foaled",
                  style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: DropdownButton<int>(
                  value: selectedValue,
                  isExpanded: true,
                  items: List.generate(
                          DateTime.now().year - 1982, (index) => 2023 - index)
                      .map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text('$value'),
                    );
                  }).toList(),
                  hint: const Text("Select Year"),
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedValue = newValue ?? 2023;
                      ageController.text =
                          (DateTime.now().year - (selectedValue ?? 0))
                              .toString();
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Text(
                  "Age of the horse",
                  style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    vertical: Dimensions.PADDING_SIZE_SMALL),
                child: CustomTextFormField(
                  title: "AGE OF THE HORSE",
                  textEditingController: ageController,
                  readOnly: true,
                ),
              ),
              RadioGroupFormField(
                value: _diseaseValue,
                onChanged: (int value) {
                  setState(() {
                    _diseaseValue = value;
                  });
                },
                questionText:
                    "Has the horse ever been diagnosed with laminitis or foundered?",
                options: const ["Yes", "No"],
                validator: (int? value) {
                  return value == -1 ? "Required field" : null;
                },
              ),
              _diseaseValue == 0
                  ? RadioGroupFormField(
                      value: _diseaseEpisodes,
                      onChanged: (int value) {
                        setState(() {
                          _diseaseEpisodes = value;
                        });
                      },
                      questionText:
                          "How many prior episodes of laminitis or founder?",
                      options: const ["Once", "Multiple Times"],
                      validator: (int? value) {
                        return value == null ? "Required field" : null;
                      },
                    )
                  : const SizedBox(),
              RadioGroupFormField(
                value: _ppidDiseaseValue,
                onChanged: (int value) {
                  setState(() {
                    _ppidDiseaseValue = value;
                  });
                },
                questionText:
                    "Has the horse ever been diagnosed with PPID or 'Equine Cushing's Disease'?",
                options: const ["Yes", "No"],
                validator: (int? value) {
                  return (value == null || value == -1)
                      ? "Required field"
                      : null;
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding:
                      const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: customButton('Next', () {
                    setState(() {
                      index = 2;
                    });
                    if (registerFormKey.currentState!.validate()) {
                      // setState(() {
                      //   index = 2;
                      // });
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
      ],
    );
  }

  Widget _newHorseContinued() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: Text(
            "Register a horse that has not been tested",
            style: TextStyle(fontSize: Dimensions.fontSizeLarge),
          ),
        ),
        Form(
          key: registerFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: CustomTextFormField(
                    title: 'Horse\'s breed registration number',
                    textEditingController: horseBarnNameController,
                    textInputType: TextInputType.name,
                    // fn: CustomValidator.validateEmail,
                    obscure: false),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    vertical: Dimensions.PADDING_SIZE_SMALL),
                child: DropdownButton<String>(
                  value: disciplineDropdownValue,
                  isExpanded: true,
                  onChanged: (String? value) {
                    setState(() {
                      disciplineDropdownValue = value ?? "";
                    });
                  },
                  items: disciplineList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Text(
                  "How often does the horse exercise?",
                  style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: DropdownButton<String>(
                  value: exerciseDropdownValue,
                  isExpanded: true,
                  onChanged: (String? value) {
                    setState(() {
                      exerciseDropdownValue = value ?? "";
                    });
                  },
                  items: exerciseList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Text(
                  'Enter Horse Weight:',
                  style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Input field for horse weight
                    const Expanded(
                      child: CustomTextFormField(
                        textInputType: TextInputType.number,
                        fn: CustomValidator.validateNumber,
                        title: "Weight",
                      ),
                    ),
                    const SizedBox(width: 15),
                    // Dropdown for selecting weight unit
                    DropdownButton<String>(
                      value: selectedUnit,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedUnit = newValue!;
                        });
                      },
                      items: weightUnits.map((String unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Text(
                  'Enter Horse Body Condition:',
                  style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: DropdownButton<int>(
                  value: horseBodyConditionScore,
                  isExpanded: true,
                  items:
                      List.generate(9, (index) => index + 1).map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text('$value'),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    setState(() {
                      horseBodyConditionScore = newValue ?? 1;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Text(
                  'Diet (check all that apply) ',
                  style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    NutritionChip(
                      label: 'Ration Balancer',
                      isSelected: selectedOptions.contains('Ration Balancer'),
                      onSelected: () => _onChipSelected('Ration Balancer'),
                    ),
                    NutritionChip(
                      label: 'Hay - Grass or Alfalfa',
                      isSelected:
                          selectedOptions.contains('Hay - Grass or Alfalfa'),
                      onSelected: () =>
                          _onChipSelected('Hay - Grass or Alfalfa'),
                    ),
                    NutritionChip(
                      label: 'Complete or "Sweet" Feed',
                      isSelected:
                          selectedOptions.contains('Complete or "Sweet" Feed'),
                      onSelected: () =>
                          _onChipSelected('Complete or "Sweet" Feed'),
                    ),
                    NutritionChip(
                      label: 'Grain',
                      isSelected: selectedOptions.contains('Grain'),
                      onSelected: () => _onChipSelected('Grain'),
                    ),
                    NutritionChip(
                      label: 'Pasture',
                      isSelected: selectedOptions.contains('Pasture'),
                      onSelected: () => _onChipSelected('Pasture'),
                    ),
                  ],
                ),
              ),
              RadioGroupFormField(
                value: _dryLotValue,
                onChanged: (int value) {
                  setState(() {
                    _dryLotValue = value;
                  });
                },
                questionText: "Is the horse primarily maintained on a dry lot?",
                options: const ["Yes", "No"],
                validator: (int? value) {
                  return value == -1 ? "Required field" : null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Text(
                  'Is the horse currently on any of the following pharmaceuticals (check all that apply)? ',
                  style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    NutritionChip(
                      label: 'Pergolide (Prascend)',
                      isSelected:
                          selectedOptions.contains('Pergolide (Prascend)'),
                      onSelected: () => _onChipSelected('Pergolide (Prascend)'),
                    ),
                    NutritionChip(
                      label: 'Levothyroxine',
                      isSelected: selectedOptions.contains('Levothyroxine'),
                      onSelected: () => _onChipSelected('Levothyroxine'),
                    ),
                    NutritionChip(
                      label: 'Metformin',
                      isSelected: selectedOptions.contains('Metformin'),
                      onSelected: () => _onChipSelected('Metformin'),
                    ),
                    NutritionChip(
                      label: 'GLP-1 Analog',
                      isSelected: selectedOptions.contains('GLP-1 Analog'),
                      onSelected: () => _onChipSelected('GLP-1 Analog'),
                    ),
                  ],
                ),
              ),
              RadioGroupFormField(
                value: _metabolicSupplementValue,
                onChanged: (int value) {
                  setState(() {
                    _metabolicSupplementValue = value;
                  });
                },
                questionText:
                    "Is the horse currently on a metabolic supplement?",
                options: const ["Yes", "No"],
                validator: (int? value) {
                  return value == -1 ? "Required field" : null;
                },
              ),
              RadioGroupFormField(
                value: _hoofSupplementValue,
                onChanged: (int value) {
                  setState(() {
                    _hoofSupplementValue = value;
                  });
                },
                questionText:
                    "Is the horse on a currently on a hoof supplement?",
                options: const ["Yes", "No"],
                validator: (int? value) {
                  return value == -1 ? "Required field" : null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                      child: customButton('Previous', () {
                        setState(() {
                          index = 1;
                        });
                      }),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding:
                          const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                      child: customButton('Submit', () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const TestingConditions()));
                        if (registerFormKey.currentState!.validate()) {
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
            ],
          ),
        )
      ],
    );
  }
}

class NutritionChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function() onSelected;

  const NutritionChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip.elevated(
      label: Text(label),
      // backgroundColor: isSelected ? Colors.blue : Colors.grey,
      // labelStyle: TextStyle(
      //   color: isSelected ? Colors.white : Colors.black,
      // ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      onSelected: (bool selected) {
        onSelected();
      },
      selected: isSelected,
    );
  }
}
