import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:wellness/data/api/api_service.dart';
import 'package:wellness/data/model/horse/horse.dart';
import 'package:wellness/helper/validator.dart';
import 'package:wellness/utils/dimensions.dart';
import 'package:wellness/views/base/custom_button.dart';
import 'package:wellness/views/base/custom_text_field.dart';
import 'package:wellness/views/base/loading_screen.dart';
import 'package:wellness/views/base/radio_group_form_field.dart';
import 'package:wellness/views/screens/instructions/instructions.dart';
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
  int _retiredValue = -1;
  int _pregnantValue = -1;
  int _breedingStockValue = -1;
  int _metabolicSupplementValue = -1;
  int _hoofSupplementValue = -1;
  int index = 1;
  int? selectedValue;
  int? horseBodyConditionScore;
  bool isLoading = false;
  List<String> weightUnits = ['Pounds', 'Kilograms'];
  String selectedUnit = 'Pounds'; // Default unit
  List<String> pharmaceuticalsSelectedOptions = [];
  List<String> dietSelectedOptions = [];
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
    "Weekly x 1",
    "Weekly x 2",
    "Weekly x 3",
    "Daily"
  ];

  static const Map<int, String> intToWord = {
    1: 'one',
    2: 'two',
    3: 'three',
    4: 'four',
    5: 'five',
    6: 'six',
    7: 'seven',
    8: 'eight',
    9: 'nine'
  };

  String breedDropdownValue = breedList.first;
  String disciplineDropdownValue = disciplineList.first;
  String exerciseDropdownValue = exerciseList.first;
  final registerFormKey1 = GlobalKey<FormState>();
  final registerFormKey2 = GlobalKey<FormState>();
  final TextEditingController horseBarnNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController horseBreedRegistrationNumber =
      TextEditingController();
  final TextEditingController weightController = TextEditingController();
  void _handleRadioValueChange(int? value) {
    setState(() {
      if (value != null) {
        _radioValue = value;
      }
    });
  }

  void _onPharmaceuticalsChipSelected(String option) {
    setState(() {
      if (pharmaceuticalsSelectedOptions.contains(option)) {
        pharmaceuticalsSelectedOptions.remove(option);
      } else {
        pharmaceuticalsSelectedOptions.add(option);
      }
    });
  }

  void _onDietChipSelected(String option) {
    setState(() {
      if (dietSelectedOptions.contains(option)) {
        dietSelectedOptions.remove(option);
      } else {
        dietSelectedOptions.add(option);
      }
    });
  }

  List<Horse> _horseData = [];
  Map<String, int> _breeds = {};

  Future<void> _loadData() async {
    try {
      List<Horse> result = await ApiService().getHorses();
      Map<String, int> breeds = await ApiService().getBreeds();
      setState(() {
        _horseData = result;
        _breeds = breeds;
      });
    } catch (e) {
      print('Failed to load data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: isLoading
            ? const LoadingScreen()
            : Padding(
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
                    // customButton("Jump to Test Screen", () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => InstructionScreen(horseId: widget.horseId, preTestId: ,)));
                    // })
                  ],
                ),
              ),
      ),
    );
  }

  Widget _previouslyTested() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: Text("Select a previously tested horse to conduct a new test"),
        ),
        ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: _horseData.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: Text(_horseData[index].barnName ?? ""),
                  subtitle: Text(_horseData[index].breed?.name ?? ""),
                  onTap: () {
                    if (_horseData[index].id != null) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TestingConditions(
                                horseId: _horseData[index].id.toString(),
                              )));
                    }
                  },
                ),
              );
            })
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
          key: registerFormKey1,
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
                padding: const EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_DEFAULT,
                  right: Dimensions.PADDING_SIZE_DEFAULT,
                  top: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                child: Text(
                  "Breed of the horse",
                  style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_DEFAULT,
                  right: Dimensions.PADDING_SIZE_DEFAULT,
                  bottom: Dimensions.PADDING_SIZE_SMALL,
                ),
                child: DropdownButton<String>(
                  value: breedDropdownValue,
                  hint: const Text("Select Breed"),
                  isExpanded: true,
                  onChanged: (String? value) {
                    setState(() {
                      breedDropdownValue = value ?? "";
                    });
                  },
                  // items: _breeds.map<DropdownMenuItem<String>>((String value, int val) {
                  //   return DropdownMenuItem<String>(
                  //       value: value, child: Text(value));
                  // }).toList(),
                  items:
                      _breeds.keys.map<DropdownMenuItem<String>>((String key) {
                    return DropdownMenuItem<String>(
                        value: key, child: Text(key));
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.PADDING_SIZE_DEFAULT,
                    right: Dimensions.PADDING_SIZE_DEFAULT,
                    top: Dimensions.PADDING_SIZE_DEFAULT),
                child: Text(
                  "Year Foaled",
                  style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_DEFAULT,
                  right: Dimensions.PADDING_SIZE_DEFAULT,
                  bottom: Dimensions.PADDING_SIZE_SMALL,
                ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: Text(
                      "Age of the horse: ",
                      style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: Text(
                      ageController.text != ""
                          ? "${ageController.text} years"
                          : "",
                      style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                    ),
                  ),
                ],
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
                    if (registerFormKey1.currentState!.validate()) {
                      setState(() {
                        index = 2;
                      });
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
          key: registerFormKey2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              //   child: CustomTextFormField(
              //       title: 'Horse\'s breed registration number',
              //       textEditingController: horseBreedRegistrationNumber,
              //       textInputType: TextInputType.name,
              //       // fn: CustomValidator.validateEmail,
              //       obscure: false),
              // ),
              Padding(
                padding: const EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_DEFAULT,
                  right: Dimensions.PADDING_SIZE_DEFAULT,
                  top: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                child: Text(
                  "Discipline of the horse",
                  style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_DEFAULT,
                  right: Dimensions.PADDING_SIZE_DEFAULT,
                  bottom: Dimensions.PADDING_SIZE_SMALL,
                ),
                child: DropdownButton<String>(
                  value: disciplineDropdownValue,
                  isExpanded: true,
                  hint: const Text("Select Discipline"),
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
                padding: const EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_DEFAULT,
                  right: Dimensions.PADDING_SIZE_DEFAULT,
                  top: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                child: Text(
                  "How often does the horse exercise?",
                  style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_DEFAULT,
                  right: Dimensions.PADDING_SIZE_DEFAULT,
                  bottom: Dimensions.PADDING_SIZE_SMALL,
                ),
                child: DropdownButton<String>(
                  value: exerciseDropdownValue,
                  isExpanded: true,
                  hint: const Text("Select Exercise"),
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
                padding: const EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_DEFAULT,
                  right: Dimensions.PADDING_SIZE_DEFAULT,
                  top: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                child: Text(
                  'Enter Horse Weight:',
                  style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: Dimensions.PADDING_SIZE_SMALL,
                  left: Dimensions.PADDING_SIZE_DEFAULT,
                  right: Dimensions.PADDING_SIZE_DEFAULT,
                  bottom: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Input field for horse weight
                    Expanded(
                      child: CustomTextFormField(
                        textEditingController: weightController,
                        textInputType: TextInputType.number,
                        fn: CustomValidator.validateNumber,
                        title: "Weight",
                      ),
                    ),
                    const SizedBox(width: 15),
                    // Dropdown for selecting weight unit
                    DropdownButton<String>(
                      value: selectedUnit,
                      // hint: const Text("Select Unit"),
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
              RadioGroupFormField(
                value: _retiredValue,
                onChanged: (int value) {
                  setState(() {
                    _dryLotValue = value;
                  });
                },
                questionText: "Is the horse retired?",
                options: const ["Yes", "No"],
                validator: (int? value) {
                  return value == -1 ? "Required field" : null;
                },
              ),
              RadioGroupFormField(
                value: _pregnantValue,
                onChanged: (int value) {
                  setState(() {
                    _dryLotValue = value;
                  });
                },
                questionText: "Is the horse pregnant?",
                options: const ["Yes", "No"],
                validator: (int? value) {
                  return value == -1 ? "Required field" : null;
                },
              ),
              RadioGroupFormField(
                value: _breedingStockValue,
                onChanged: (int value) {
                  setState(() {
                    _dryLotValue = value;
                  });
                },
                questionText: "What is the sex of the horse?",
                options: const ["Mare", "Stallion", "Gelding"],
                validator: (int? value) {
                  return value == -1 ? "Required field" : null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_DEFAULT,
                  right: Dimensions.PADDING_SIZE_DEFAULT,
                  top: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                child: Text(
                  'Enter Horse Body Condition:',
                  style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_DEFAULT,
                  right: Dimensions.PADDING_SIZE_DEFAULT,
                  bottom: Dimensions.PADDING_SIZE_SMALL,
                ),
                child: DropdownButton<int>(
                  value: horseBodyConditionScore,
                  hint: const Text("Select Score"),
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
                padding: const EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_DEFAULT,
                  right: Dimensions.PADDING_SIZE_DEFAULT,
                  top: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                child: Text(
                  'Diet (check all that apply) ',
                  style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: Dimensions.PADDING_SIZE_SMALL,
                  left: Dimensions.PADDING_SIZE_DEFAULT,
                  right: Dimensions.PADDING_SIZE_DEFAULT,
                  bottom: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    NutritionChip(
                      label: 'Ration Balancer',
                      isSelected:
                          dietSelectedOptions.contains('Ration Balancer'),
                      onSelected: () => _onDietChipSelected('Ration Balancer'),
                    ),
                    NutritionChip(
                      label: 'Hay - Grass or Alfalfa',
                      isSelected: dietSelectedOptions
                          .contains('Hay - Grass or Alfalfa'),
                      onSelected: () =>
                          _onDietChipSelected('Hay - Grass or Alfalfa'),
                    ),
                    NutritionChip(
                      label: 'Complete or "Sweet" Feed',
                      isSelected: dietSelectedOptions
                          .contains('Complete or "Sweet" Feed'),
                      onSelected: () =>
                          _onDietChipSelected('Complete or "Sweet" Feed'),
                    ),
                    NutritionChip(
                      label: 'Grain',
                      isSelected: dietSelectedOptions.contains('Grain'),
                      onSelected: () => _onDietChipSelected('Grain'),
                    ),
                    NutritionChip(
                      label: 'Pasture',
                      isSelected: dietSelectedOptions.contains('Pasture'),
                      onSelected: () => _onDietChipSelected('Pasture'),
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
                padding: const EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_DEFAULT,
                  right: Dimensions.PADDING_SIZE_DEFAULT,
                  top: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                child: Text(
                  'Is the horse currently on any of the following pharmaceuticals (check all that apply)? ',
                  style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: Dimensions.PADDING_SIZE_SMALL,
                  left: Dimensions.PADDING_SIZE_DEFAULT,
                  right: Dimensions.PADDING_SIZE_DEFAULT,
                  bottom: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    NutritionChip(
                      label: 'Pergolide (Prascend)',
                      isSelected: pharmaceuticalsSelectedOptions
                          .contains('Pergolide (Prascend)'),
                      onSelected: () => _onPharmaceuticalsChipSelected(
                          'Pergolide (Prascend)'),
                    ),
                    NutritionChip(
                      label: 'Levothyroxine',
                      isSelected: pharmaceuticalsSelectedOptions
                          .contains('Levothyroxine'),
                      onSelected: () =>
                          _onPharmaceuticalsChipSelected('Levothyroxine'),
                    ),
                    NutritionChip(
                      label: 'Metformin',
                      isSelected:
                          pharmaceuticalsSelectedOptions.contains('Metformin'),
                      onSelected: () =>
                          _onPharmaceuticalsChipSelected('Metformin'),
                    ),
                    NutritionChip(
                      label: 'GLP-1 Analog',
                      isSelected: pharmaceuticalsSelectedOptions
                          .contains('GLP-1 Analog'),
                      onSelected: () =>
                          _onPharmaceuticalsChipSelected('GLP-1 Analog'),
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
                        if (registerFormKey2.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          Horse horse = Horse(
                            barnName: horseBarnNameController.text,
                            yearOfBorn: selectedValue.toString(),
                            isDiagnosed: _diseaseValue == 0 ? true : false,
                            discipline: disciplineDropdownValue,
                            exercise: exerciseDropdownValue,
                            weight: int.tryParse(weightController.text),
                            bodyCondition: intToWord[horseBodyConditionScore],
                            isRetired: _retiredValue == 0 ? true : false,
                            isPregnant: _ppidDiseaseValue == 0 ? true : false,
                            breedingStock:
                                _breedingStockValue == 0 ? "Mare" : "Stallion",
                            isDrylot: _dryLotValue == 0 ? true : false,
                            isMetabolicSupplement:
                                _metabolicSupplementValue == 0 ? true : false,
                            isHoofSupplement:
                                _hoofSupplementValue == 0 ? true : false,
                            diet: dietSelectedOptions,
                            pharmaceuticals: pharmaceuticalsSelectedOptions,
                            laminitisEpisodes: _diseaseEpisodes,
                            isPpidDiagnosed:
                                _ppidDiseaseValue == 0 ? true : false,
                          );
                          Map<String, dynamic> data = horse.toMap();

                          data.addAll({"breed": _breeds[breedDropdownValue]});
                          ApiService().registerHorse(data).then((value) => {
                                if (value != null)
                                  {
                                    setState(() {
                                      isLoading = false;
                                    }),
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TestingConditions(
                                                  horseId: value,
                                                )))
                                  }
                                else
                                  {
                                    setState(() {
                                      isLoading = false;
                                    }),
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("Error saving data")))
                                  }
                              });
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => const TestingConditions()));
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
