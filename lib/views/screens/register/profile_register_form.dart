// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';

import 'package:wellness/data/model/profile.dart';
import 'package:wellness/helper/validator.dart';
import 'package:wellness/utils/dimensions.dart';
import 'package:wellness/views/base/custom_text_field.dart';

// Widget profileRegisterForm(
//     BuildContext context, Profile profile, Function(Profile) widget.onUpdate) {

// }

class ProfileRegisterForm extends StatefulWidget {
  final BuildContext ctx;
  final Profile profile;
  final Function(Profile) onUpdate;
  const ProfileRegisterForm({
    Key? key,
    required this.ctx,
    required this.profile,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<ProfileRegisterForm> createState() => _ProfileRegisterFormState();
}

class _ProfileRegisterFormState extends State<ProfileRegisterForm> {
  static const String kGoogleApiKey = "AIzaSyAPNs4LbF8a3SJSG7O6O9Ue_M61inmaBe0";
  final GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: "AIzaSyAPNs4LbF8a3SJSG7O6O9Ue_M61inmaBe0");
  bool showLocLoader = true;
  final TextEditingController selectedCountryController =
      TextEditingController();
  TextEditingController countryNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();

  //   void _updateSelectedCountry() {
  //   widget.profile.country = selectedCountryController.text;
  //   widget.onUpdate(widget.profile);
  // }

  void _updateCountryName() {
    widget.profile.country = countryNameController.text;
    widget.onUpdate(widget.profile);
  }

  void _updateCity() {
    widget.profile.city = cityController.text;
    widget.onUpdate(widget.profile);
  }

  void _updateState() {
    widget.profile.state = stateController.text;
    widget.onUpdate(widget.profile);
  }

  void _updateAddress1() {
    widget.profile.address1 = address1Controller.text;
    widget.onUpdate(widget.profile);
  }

  void _updateAddress2() {
    widget.profile.address2 = address2Controller.text;
    widget.onUpdate(widget.profile);
  }

  void _updatePostalCode() {
    widget.profile.postalCode = postalCodeController.text;
    widget.onUpdate(widget.profile);
  }

  void _updateFirstName() {
    widget.profile.firstName = firstNameController.text;
    widget.onUpdate(widget.profile);
  }

  void _updateLastName() {
    widget.profile.lastName = lastNameController.text;
    widget.onUpdate(widget.profile);
  }

  void _updatePhoneNumber() {
    widget.profile.phoneNumber = phoneNumberController.text;
    widget.onUpdate(widget.profile);
  }

  void _updateCountryCode() {
    widget.profile.countryCode = countryCodeController.text;
    widget.onUpdate(widget.profile);
  }

  @override
  void initState() {
    super.initState();
    // selectedCountryController.addListener(_updateSelectedCountry);
    countryNameController.addListener(_updateCountryName);
    cityController.addListener(_updateCity);
    stateController.addListener(_updateState);
    address1Controller.addListener(_updateAddress1);
    address2Controller.addListener(_updateAddress2);
    postalCodeController.addListener(_updatePostalCode);
    firstNameController.addListener(_updateFirstName);
    lastNameController.addListener(_updateLastName);
    phoneNumberController.addListener(_updatePhoneNumber);
    countryCodeController.addListener(_updateCountryCode);
  }

  @override
  void dispose() {
    selectedCountryController.dispose();
    countryNameController.dispose();
    cityController.dispose();
    stateController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    postalCodeController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    countryCodeController.dispose();
    super.dispose();
  }

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
          countryNameController.text = placemark.country ?? "";
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    vertical: Dimensions.PADDING_SIZE_SMALL),
                child: CustomTextFormField(
                    title: 'FIRST NAME',
                    textEditingController: firstNameController,
                    textInputType: TextInputType.emailAddress,
                    // fn: CustomValidator.validateEmail,
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
                    textEditingController: lastNameController,
                    textInputType: TextInputType.emailAddress,
                    // fn: CustomValidator.validateEmail,
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
                  title: "+1",
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
            fn: CustomValidator.defaultValidate,
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
      ],
    );
  }
}
