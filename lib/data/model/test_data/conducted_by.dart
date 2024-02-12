import 'dart:convert';

import 'package:equatable/equatable.dart';

class ConductedBy extends Equatable {
  final int? id;
  final String? username;
  final String? email;
  final String? provider;
  final String? password;
  final dynamic resetPasswordToken;
  final dynamic confirmationToken;
  final bool? confirmed;
  final bool? blocked;
  final bool? isSocial;
  final bool? notifications;
  final dynamic mobileNumber;
  final String? profile;
  final dynamic fcmToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ConductedBy({
    this.id,
    this.username,
    this.email,
    this.provider,
    this.password,
    this.resetPasswordToken,
    this.confirmationToken,
    this.confirmed,
    this.blocked,
    this.isSocial,
    this.notifications,
    this.mobileNumber,
    this.profile,
    this.fcmToken,
    this.createdAt,
    this.updatedAt,
  });

  factory ConductedBy.fromMap(Map<String, dynamic> data) => ConductedBy(
        id: data['id'] as int?,
        username: data['username'] as String?,
        email: data['email'] as String?,
        provider: data['provider'] as String?,
        password: data['password'] as String?,
        resetPasswordToken: data['resetPasswordToken'] as dynamic,
        confirmationToken: data['confirmationToken'] as dynamic,
        confirmed: data['confirmed'] as bool?,
        blocked: data['blocked'] as bool?,
        isSocial: data['is_social'] as bool?,
        notifications: data['notifications'] as bool?,
        mobileNumber: data['mobile_number'] as dynamic,
        profile: data['profile'] as String?,
        fcmToken: data['fcm_token'] as dynamic,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'email': email,
        'provider': provider,
        'password': password,
        'resetPasswordToken': resetPasswordToken,
        'confirmationToken': confirmationToken,
        'confirmed': confirmed,
        'blocked': blocked,
        'is_social': isSocial,
        'notifications': notifications,
        'mobile_number': mobileNumber,
        'profile': profile,
        'fcm_token': fcmToken,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ConductedBy].
  factory ConductedBy.fromJson(String data) {
    return ConductedBy.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ConductedBy] to a JSON string.
  String toJson() => json.encode(toMap());

  ConductedBy copyWith({
    int? id,
    String? username,
    String? email,
    String? provider,
    String? password,
    dynamic resetPasswordToken,
    dynamic confirmationToken,
    bool? confirmed,
    bool? blocked,
    bool? isSocial,
    bool? notifications,
    dynamic mobileNumber,
    String? profile,
    dynamic fcmToken,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ConductedBy(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      provider: provider ?? this.provider,
      password: password ?? this.password,
      resetPasswordToken: resetPasswordToken ?? this.resetPasswordToken,
      confirmationToken: confirmationToken ?? this.confirmationToken,
      confirmed: confirmed ?? this.confirmed,
      blocked: blocked ?? this.blocked,
      isSocial: isSocial ?? this.isSocial,
      notifications: notifications ?? this.notifications,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      profile: profile ?? this.profile,
      fcmToken: fcmToken ?? this.fcmToken,
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
      username,
      email,
      provider,
      password,
      resetPasswordToken,
      confirmationToken,
      confirmed,
      blocked,
      isSocial,
      notifications,
      mobileNumber,
      profile,
      fcmToken,
      createdAt,
      updatedAt,
    ];
  }
}
