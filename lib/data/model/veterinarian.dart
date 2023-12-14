import 'dart:convert';

import 'package:equatable/equatable.dart';

class Veterinarian extends Equatable {
  final String? facilityName;
  final String? country;
  final int? veterinariansCount;
  final String? typeOfFacility;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? firstName;
  final String? lastName;
  final String? address1;
  final String? address2;

  const Veterinarian({
    this.facilityName,
    this.country,
    this.veterinariansCount,
    this.typeOfFacility,
    this.city,
    this.state,
    this.postalCode,
    this.firstName,
    this.lastName,
    this.address1,
    this.address2,
  });

  factory Veterinarian.fromMap(Map<String, dynamic> data) => Veterinarian(
        facilityName: data['facility_name'] as String?,
        country: data['country'] as String?,
        veterinariansCount: data['veterinarians_count'] as int?,
        typeOfFacility: data['type_of_facility'] as String?,
        city: data['city'] as String?,
        state: data['state'] as String?,
        postalCode: data['postal_code'] as String?,
        firstName: data['first_name'] as String?,
        lastName: data['last_name'] as String?,
        address1: data['address1'] as String?,
        address2: data['address2'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'facility_name': facilityName,
        'country': country,
        'veterinarians_count': veterinariansCount,
        'type_of_facility': typeOfFacility,
        'city': city,
        'state': state,
        'postal_code': postalCode,
        'first_name': firstName,
        'last_name': lastName,
        'address1': address1,
        'address2': address2,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Veterinarian].
  factory Veterinarian.fromJson(String data) {
    return Veterinarian.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Veterinarian] to a JSON string.
  String toJson() => json.encode(toMap());

  Veterinarian copyWith({
    String? facilityName,
    String? country,
    int? veterinariansCount,
    String? typeOfFacility,
    String? city,
    String? state,
    String? postalCode,
    String? firstName,
    String? lastName,
    String? address1,
    String? address2,
  }) {
    return Veterinarian(
      facilityName: facilityName ?? this.facilityName,
      country: country ?? this.country,
      veterinariansCount: veterinariansCount ?? this.veterinariansCount,
      typeOfFacility: typeOfFacility ?? this.typeOfFacility,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
    );
  }

  @override
  List<Object?> get props {
    return [
      facilityName,
      country,
      veterinariansCount,
      typeOfFacility,
      city,
      state,
      postalCode,
      firstName,
      lastName,
      address1,
      address2,
    ];
  }
}
