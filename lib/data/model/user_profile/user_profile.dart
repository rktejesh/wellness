import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'user_details.dart';

class UserProfile extends Equatable {
  final UserDetails? userDetails;
  final String? role;

  const UserProfile({this.userDetails, this.role});

  factory UserProfile.fromMap(Map<String, dynamic> data) => UserProfile(
        userDetails: data['user_details'] == null
            ? null
            : UserDetails.fromMap(data['user_details'] as Map<String, dynamic>),
        role: data['role'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'user_details': userDetails?.toMap(),
        'role': role,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserProfile].
  factory UserProfile.fromJson(String data) {
    return UserProfile.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UserProfile] to a JSON string.
  String toJson() => json.encode(toMap());

  UserProfile copyWith({
    UserDetails? userDetails,
    String? role,
  }) {
    return UserProfile(
      userDetails: userDetails ?? this.userDetails,
      role: role ?? this.role,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [userDetails, role];
}
