import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'breeder.dart';
import 'owner.dart';
import 'trainer.dart';
import 'veterinarian.dart';

class UserDetails extends Equatable {
  final int? id;
  final String? email;
  final dynamic mobileNumber;
  final bool? notifications;
  final bool? isSocial;
  final Owner? owner;
  final Breeder? breeder;
  final Trainer? trainer;
  final Veterinarian? veterinarian;

  const UserDetails({
    this.id,
    this.email,
    this.mobileNumber,
    this.notifications,
    this.isSocial,
    this.owner,
    this.breeder,
    this.trainer,
    this.veterinarian,
  });

  factory UserDetails.fromMap(Map<String, dynamic> data) => UserDetails(
        id: data['id'] as int?,
        email: data['email'] as String?,
        mobileNumber: data['mobile_number'] as dynamic,
        notifications: data['notifications'] as bool?,
        isSocial: data['is_social'] as bool?,
        owner: data['owner'] == null
            ? null
            : Owner.fromMap(data['owner'] as Map<String, dynamic>),
        breeder: data['breeder'] == null
            ? null
            : Breeder.fromMap(data['breeder'] as Map<String, dynamic>),
        trainer: data['trainer'] == null
            ? null
            : Trainer.fromMap(data['trainer'] as Map<String, dynamic>),
        veterinarian: data['veterinarian'] == null
            ? null
            : Veterinarian.fromMap(
                data['veterinarian'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'email': email,
        'mobile_number': mobileNumber,
        'notifications': notifications,
        'is_social': isSocial,
        'owner': owner?.toMap(),
        'breeder': breeder?.toMap(),
        'trainer': trainer?.toMap(),
        'veterinarian': veterinarian?.toMap(),
      };

  Map<String, dynamic> toDisplayMap() => {
        "Id": id,
        "Email": email,
        "Mobile Number": mobileNumber,
        "Notifications": notifications,
        "Is Social": isSocial,
        "Owner": owner?.toDisplayMap(),
        "Breeder": breeder?.toDisplayMap(),
        "Trainer": trainer?.toDisplayMap(),
        "Veterinarian": veterinarian?.toDisplayMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserDetails].
  factory UserDetails.fromJson(String data) {
    return UserDetails.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UserDetails] to a JSON string.
  String toJson() => json.encode(toMap());

  UserDetails copyWith({
    int? id,
    String? email,
    dynamic mobileNumber,
    bool? notifications,
    bool? isSocial,
    Owner? owner,
    Breeder? breeder,
    Trainer? trainer,
    Veterinarian? veterinarian,
  }) {
    return UserDetails(
      id: id ?? this.id,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      notifications: notifications ?? this.notifications,
      isSocial: isSocial ?? this.isSocial,
      owner: owner ?? this.owner,
      breeder: breeder ?? this.breeder,
      trainer: trainer ?? this.trainer,
      veterinarian: veterinarian ?? this.veterinarian,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      email,
      mobileNumber,
      notifications,
      isSocial,
      owner,
      breeder,
      trainer,
      veterinarian,
    ];
  }
}
