import 'dart:convert';

import 'package:equatable/equatable.dart';

class Owner extends Equatable {
  final int? id;
  final int? horseCount;
  final dynamic vetCount;
  final String? country;
  final String? state;
  final dynamic postalCode;
  final String? firstName;
  final dynamic lastName;
  final String? address1;
  final dynamic address2;
  final String? city;
  final dynamic facilityName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Owner({
    this.id,
    this.horseCount,
    this.vetCount,
    this.country,
    this.state,
    this.postalCode,
    this.firstName,
    this.lastName,
    this.address1,
    this.address2,
    this.city,
    this.facilityName,
    this.createdAt,
    this.updatedAt,
  });

  factory Owner.fromMap(Map<String, dynamic> data) => Owner(
        id: data['id'] as int?,
        horseCount: data['horse_count'] as int?,
        vetCount: data['vet_count'] as dynamic,
        country: data['country'] as String?,
        state: data['state'] as String?,
        postalCode: data['postal_code'] as dynamic,
        firstName: data['first_name'] as String?,
        lastName: data['last_name'] as dynamic,
        address1: data['address1'] as String?,
        address2: data['address2'] as dynamic,
        city: data['city'] as String?,
        facilityName: data['facility_name'] as dynamic,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'horse_count': horseCount,
        'vet_count': vetCount,
        'country': country,
        'state': state,
        'postal_code': postalCode,
        'first_name': firstName,
        'last_name': lastName,
        'address1': address1,
        'address2': address2,
        'city': city,
        'facility_name': facilityName,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Owner].
  factory Owner.fromJson(String data) {
    return Owner.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Owner] to a JSON string.
  String toJson() => json.encode(toMap());

  Owner copyWith({
    int? id,
    int? horseCount,
    dynamic vetCount,
    String? country,
    String? state,
    dynamic postalCode,
    String? firstName,
    dynamic lastName,
    String? address1,
    dynamic address2,
    String? city,
    dynamic facilityName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Owner(
      id: id ?? this.id,
      horseCount: horseCount ?? this.horseCount,
      vetCount: vetCount ?? this.vetCount,
      country: country ?? this.country,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      city: city ?? this.city,
      facilityName: facilityName ?? this.facilityName,
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
      horseCount,
      vetCount,
      country,
      state,
      postalCode,
      firstName,
      lastName,
      address1,
      address2,
      city,
      facilityName,
      createdAt,
      updatedAt,
    ];
  }
}
