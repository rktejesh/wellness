import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:wellness/blocs/dashboard/dashboard_bloc.dart';
import 'package:wellness/blocs/register/register_bloc.dart';
import 'package:wellness/blocs/register_form/register_form_bloc.dart';
import 'package:wellness/data/model/profile.dart';
import 'package:wellness/helper/validator.dart';
import 'package:wellness/image.dart';
import 'package:wellness/utils/dimensions.dart';
import 'package:wellness/views/base/custom_button.dart';
import 'package:wellness/views/base/custom_text_field.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:wellness/views/screens/dashboard/dashboard.dart';
import 'package:wellness/views/screens/dashboard/dashboard_view.dart';
import 'package:wellness/views/screens/register/profile_register_form.dart';

class VeterinarianRegisterForm extends StatefulWidget {
  const VeterinarianRegisterForm({super.key});

  @override
  State<VeterinarianRegisterForm> createState() =>
      _VeterinarianRegisterFormState();
}

const String kGoogleApiKey = "AIzaSyAPNs4LbF8a3SJSG7O6O9Ue_M61inmaBe0";

class _VeterinarianRegisterFormState extends State<VeterinarianRegisterForm> {
  final registerFormKey = GlobalKey<FormState>();
  final TextEditingController facilityNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController countryNameController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController selectedCountryController =
      TextEditingController();
  final String kGoogleApiKey = "AIzaSyAPNs4LbF8a3SJSG7O6O9Ue_M61inmaBe0";
  final GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: "AIzaSyAPNs4LbF8a3SJSG7O6O9Ue_M61inmaBe0");
  bool showLocLoader = true;
  int selectedValue = 1;
  Profile profile = Profile();

  void updateProfile(Profile profile) {
    setState(() {
      this.profile = profile;
    });
  }

  static const List<String> list = <String>[
    "Equine",
    "Mixed Animal",
    "Large Animal",
    "Companion Animal"
  ];
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterFormBloc>.value(
      value: BlocProvider.of<RegisterFormBloc>(context),
      child: BlocConsumer<RegisterFormBloc, RegistrationFormState>(
        listener: (context, state) {
          if (state is RegistrationFormSuccess) {
            BlocProvider.of<DashboardBloc>(context).add(DashboardFetchData());
          } else if (state is RegistrationFormFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_LARGE),
                  child: Form(
                    key: registerFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                              vertical: Dimensions.PADDING_SIZE_SMALL),
                          child: CustomTextFormField(
                              title: 'FACILITY NAME',
                              textEditingController: facilityNameController,
                              textInputType: TextInputType.emailAddress,
                              // fn: CustomValidator.validateEmail,
                              obscure: false),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                              vertical: Dimensions.PADDING_SIZE_SMALL),
                          child: Text(
                              "How many veterinarians are employed at this facility?"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_DEFAULT),
                          child: DropdownButton<int>(
                            value: selectedValue,
                            isExpanded: true,
                            items: List.generate(100, (index) => index + 1)
                                .map((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text('$value'),
                              );
                            }).toList(),
                            onChanged: (int? newValue) {
                              setState(() {
                                selectedValue = newValue ?? 1;
                              });
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                              vertical: Dimensions.PADDING_SIZE_SMALL),
                          child: Text("Type of veterinary facility?"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                              vertical: Dimensions.PADDING_SIZE_SMALL),
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            isExpanded: true,
                            onChanged: (String? value) {
                              setState(() {
                                dropdownValue = value ?? "";
                              });
                            },
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value, child: Text(value));
                            }).toList(),
                          ),
                        ),
                        ProfileRegisterForm(
                          onUpdate: updateProfile,
                          profile: profile,
                          ctx: context,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                                vertical: Dimensions.PADDING_SIZE_SMALL),
                            child: customButton('REGISTER >', () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => const DashboardView()));
                              if (registerFormKey.currentState!.validate()) {
                                // Veterinarian vet = Veterinarian(
                                //     facilityName: facilityNameController.text,
                                //     country: countryNameController.text,
                                //     city: cityController.text,
                                //     state: stateController.text,
                                //     address1: address1Controller.text,
                                //     address2: address2Controller.text,
                                //     postalCode: postalCodeController.text,
                                //     firstName: firstNameController.text,
                                //     lastName: lastNameController.text,
                                //     veterinariansCount: selectedValue,
                                //     typeOfFacility: dropdownValue);
                                Map<String, dynamic> mp = profile.toMap();
                                mp.addAll({
                                  "facility_name": facilityNameController.text,
                                  "veterinarians_count": selectedValue,
                                  "type_of_facility": dropdownValue
                                });
                                context.read<RegisterFormBloc>().add(
                                    RegisterFormButtonPressed(formData: mp));
                              }
                            }),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
