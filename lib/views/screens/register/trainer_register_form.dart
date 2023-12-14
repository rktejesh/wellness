import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:wellness/blocs/register/register_bloc.dart';
import 'package:wellness/helper/validator.dart';
import 'package:wellness/image.dart';
import 'package:wellness/utils/dimensions.dart';
import 'package:wellness/views/base/custom_button.dart';
import 'package:wellness/views/base/custom_text_field.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:wellness/views/screens/dashboard/dashboard.dart';
import 'package:wellness/views/screens/dashboard/dashboard_view.dart';

class TrainerRegisterForm extends StatefulWidget {
  const TrainerRegisterForm({super.key});

  @override
  State<TrainerRegisterForm> createState() => _TrainerRegisterFormState();
}

const String kGoogleApiKey = "AIzaSyAPNs4LbF8a3SJSG7O6O9Ue_M61inmaBe0";

class _TrainerRegisterFormState extends State<TrainerRegisterForm> {
  final registerFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
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

  static const List<String> list = <String>[
    "Equine",
    "Mixed Animal",
    "Large Animal",
    "Companion Animal"
  ];
  String dropdownValue = list.first;

  showCountryPickerBottomSheet() {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      favorite: ['US'],
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: 600,
        flagSize: 22,
        borderRadius: BorderRadius.circular(20),
      ),
      onSelect: (country) {
        countryNameController.text = country.name;
        selectedCountryController.text = country.countryCode;
        cityController.clear();
        stateController.clear();
        postalCodeController.clear();
        address1Controller.clear();
      },
    );
  }

  showCountryCodePickerBottomSheet() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      favorite: ['US'],
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: 600,
        flagSize: 22,
        borderRadius: BorderRadius.circular(20),
      ),
      onSelect: (country) {
        countryCodeController.text = country.phoneCode;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>.value(
      value: BlocProvider.of<RegisterBloc>(context),
      child: Scaffold(
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
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                                vertical: Dimensions.PADDING_SIZE_SMALL),
                            child: CustomTextFormField(
                                title: 'FIRST NAME',
                                textEditingController: emailController,
                                textInputType: TextInputType.emailAddress,
                                fn: CustomValidator.validateEmail,
                                obscure: false),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                                vertical: Dimensions.PADDING_SIZE_SMALL),
                            child: CustomTextFormField(
                                title: 'LAST NAME',
                                textEditingController: emailController,
                                textInputType: TextInputType.emailAddress,
                                fn: CustomValidator.validateEmail,
                                obscure: false),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                          vertical: Dimensions.PADDING_SIZE_SMALL),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 70,
                            child: CustomTextFormField(
                              onTap: showCountryCodePickerBottomSheet,
                              textEditingController: countryCodeController,
                              prefix: const Text('+'),
                              readOnly: true,
                              title: "+",
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextFormField(
                              textEditingController: phoneNumberController,
                              title: 'Phone Number',
                              textAlign: TextAlign.left,
                              textInputType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                          vertical: Dimensions.PADDING_SIZE_SMALL),
                      child: CustomTextFormField(
                          title: 'FACILITY NAME',
                          textEditingController: emailController,
                          textInputType: TextInputType.emailAddress,
                          fn: CustomValidator.validateEmail,
                          obscure: false),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                          vertical: Dimensions.PADDING_SIZE_SMALL),
                      child: DropdownMenu<String>(
                        menuStyle: const MenuStyle(),
                        initialSelection: list.first,
                        onSelected: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        dropdownMenuEntries:
                            list.map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(
                              value: value, label: value);
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                          vertical: Dimensions.PADDING_SIZE_SMALL),
                      child: CustomTextFormField(
                        title: 'ADDRESS LINE 1',
                        textEditingController: address1Controller,
                        readOnly: true,
                        onTap: () {
                          handlePressButton(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                          vertical: Dimensions.PADDING_SIZE_SMALL),
                      child: CustomTextFormField(
                        title: 'ADDRESS LINE 2',
                        textEditingController: address2Controller,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                          vertical: Dimensions.PADDING_SIZE_SMALL),
                      child: CustomTextFormField(
                        title: "SELECT COUNTRY",
                        onTap: showCountryPickerBottomSheet,
                        textEditingController: countryNameController,
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                          vertical: Dimensions.PADDING_SIZE_SMALL),
                      child: CustomTextFormField(
                        title: "SELECT CITY",
                        textEditingController: cityController,
                        readOnly: true,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                                vertical: Dimensions.PADDING_SIZE_SMALL),
                            child: CustomTextFormField(
                              textEditingController: stateController,
                              readOnly: true,
                              title: 'STATE',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                                vertical: Dimensions.PADDING_SIZE_SMALL),
                            child: CustomTextFormField(
                              title: 'POSTAL CODE',
                              readOnly: true,
                              textEditingController: postalCodeController,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                          vertical: Dimensions.PADDING_SIZE_SMALL),
                      child: customButton('REGISTER >', () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const DashboardView()));
                        // if (registerFormKey.currentState!.validate()) {
                        //   // registerBloc.add(RegisterButtonPressed(formData: {
                        //   //   "email": emailController.text,
                        //   //   "password": passwordController.text,
                        //   // }));
                        // }
                      }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> displayPrediction(Prediction? p) async {
    try {
      if (p != null) {
        GoogleMapsPlaces places = GoogleMapsPlaces(
          apiKey: kGoogleApiKey,
          apiHeaders: await const GoogleApiHeaders().getHeaders(),
        );
        if (p.placeId != null) {
          PlacesDetailsResponse detail =
              await places.getDetailsByPlaceId(p.placeId!);
          final lat = detail.result.geometry!.location.lat;
          final lng = detail.result.geometry!.location.lng;

          List<geo.Placemark> placemarks =
              await geo.placemarkFromCoordinates(lat, lng);

          geo.Placemark placemark = placemarks[0];
          debugPrint("placemark ${placemark.locality}");
          address1Controller.text = p.description ?? "";
          postalCodeController.text = placemark.postalCode ?? "";
          cityController.text = placemark.locality ?? "";
          stateController.text = placemark.administrativeArea ?? "";
        }
      } else {
        // c.showLocLoader = false;
        // c.update();
        debugPrint("display predictions else ");
      }
    } on Exception catch (e) {
      // c.showLocLoader = false;
      // c.update();
      // Get.snackbar("Unable to update location", e.toString());
    }
  }

  Future<void> handlePressButton(context) async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: (PlacesAutocompleteResponse res) {
        debugPrint("Places error ${res.errorMessage}");
      },
      types: [""],
      mode: Mode.overlay,
      strictbounds: false,
      language: "En",
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [
        // Component(Component.country, selectedCountryController.text)
        // Component(Component.locality)
      ],
    );
    if (p != null) {
      displayPrediction(p);
    }
    // else {
    //   c.showLocLoader = false;
    //   c.update();
    // }
  }
}
