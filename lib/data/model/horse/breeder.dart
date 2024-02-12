import 'dart:convert';

import 'package:equatable/equatable.dart';

class Breeder extends Equatable {
  final int? id;
  final int? breedingHorses;
  final int? fouls;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? firstName;
  final dynamic lastName;
  final String? address1;
  final String? address2;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Breeder({
    this.id,
    this.breedingHorses,
    this.fouls,
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

  factory Breeder.fromMap(Map<String, dynamic> data) => Breeder(
        id: data['id'] as int?,
        breedingHorses: data['breeding_horses'] as int?,
        fouls: data['fouls'] as int?,
        city: data['city'] as String?,
        state: data['state'] as String?,
        postalCode: data['postal_code'] as String?,
        firstName: data['first_name'] as String?,
        lastName: data['last_name'] as dynamic,
        address1: data['address1'] as String?,
        address2: data['address2'] as String?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'breeding_horses': breedingHorses,
        'fouls': fouls,
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
  /// Parses the string and returns the resulting Json object as [Breeder].
  factory Breeder.fromJson(String data) {
    return Breeder.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Breeder] to a JSON string.
  String toJson() => json.encode(toMap());

  Breeder copyWith({
    int? id,
    int? breedingHorses,
    int? fouls,
    String? city,
    String? state,
    String? postalCode,
    String? firstName,
    dynamic lastName,
    String? address1,
    String? address2,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Breeder(
      id: id ?? this.id,
      breedingHorses: breedingHorses ?? this.breedingHorses,
      fouls: fouls ?? this.fouls,
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
      breedingHorses,
      fouls,
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
