import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Trainer extends Equatable {
  final int? id;
  final int? horseCount;
  final String? country;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? firstName;
  final dynamic lastName;
  final String? address1;
  final String? address2;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Trainer({
    this.id,
    this.horseCount,
    this.country,
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

  factory Trainer.fromMap(Map<String, dynamic> data) => Trainer(
        id: data['id'] as int?,
        horseCount: data['horse_count'] as int?,
        country: data['country'] as String?,
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
        'horse_count': horseCount,
        'country': country,
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

  Map<String, dynamic> toDisplayMap() => {
        "Id": id,
        "Horse Count": horseCount,
        "Country": country,
        "City": city,
        "State": state,
        "Postal Code": postalCode,
        "First Name": firstName,
        "Last Name": lastName,
        "Address1": address1,
        "Address2": address2,
        "Created At":
            DateFormat("yyyy-MM-dd HH:mm").format(createdAt ?? DateTime.now()),
        "Updated At":
            DateFormat("yyyy-MM-dd HH:mm").format(updatedAt ?? DateTime.now()),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Trainer].
  factory Trainer.fromJson(String data) {
    return Trainer.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Trainer] to a JSON string.
  String toJson() => json.encode(toMap());

  Trainer copyWith({
    int? id,
    int? horseCount,
    String? country,
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
    return Trainer(
      id: id ?? this.id,
      horseCount: horseCount ?? this.horseCount,
      country: country ?? this.country,
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
      horseCount,
      country,
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
