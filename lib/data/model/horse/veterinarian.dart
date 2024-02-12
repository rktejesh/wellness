import 'dart:convert';

import 'package:equatable/equatable.dart';

class Veterinarian extends Equatable {
  final int? id;
  final String? facilityName;
  final String? country;
  final dynamic veterinariansCount;
  final dynamic typeOfFacility;
  final String? city;
  final String? state;
  final dynamic postalCode;
  final String? firstName;
  final String? lastName;
  final String? address1;
  final dynamic address2;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Veterinarian({
    this.id,
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
    this.createdAt,
    this.updatedAt,
  });

  factory Veterinarian.fromMap(Map<String, dynamic> data) => Veterinarian(
        id: data['id'] as int?,
        facilityName: data['facility_name'] as String?,
        country: data['country'] as String?,
        veterinariansCount: data['veterinarians_count'] as dynamic,
        typeOfFacility: data['type_of_facility'] as dynamic,
        city: data['city'] as String?,
        state: data['state'] as String?,
        postalCode: data['postal_code'] as dynamic,
        firstName: data['first_name'] as String?,
        lastName: data['last_name'] as String?,
        address1: data['address1'] as String?,
        address2: data['address2'] as dynamic,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
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
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
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
    int? id,
    String? facilityName,
    String? country,
    dynamic veterinariansCount,
    dynamic typeOfFacility,
    String? city,
    String? state,
    dynamic postalCode,
    String? firstName,
    String? lastName,
    String? address1,
    dynamic address2,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Veterinarian(
      id: id ?? this.id,
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
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
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
      createdAt,
      updatedAt,
    ];
  }
}
