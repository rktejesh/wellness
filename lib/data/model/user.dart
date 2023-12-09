import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? username;
  final String? email;
  final String? provider;
  final bool? confirmed;
  final bool? blocked;
  final bool? isSocial;
  final bool? notifications;
  final dynamic mobileNumber;
  final String? profile;
  final dynamic fcmToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const User({
    this.id,
    this.username,
    this.email,
    this.provider,
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

  factory User.fromMap(Map<String, dynamic> data) => User(
        id: data['id'] as int?,
        username: data['username'] as String?,
        email: data['email'] as String?,
        provider: data['provider'] as String?,
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
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());

  User copyWith({
    int? id,
    String? username,
    String? email,
    String? provider,
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
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      provider: provider ?? this.provider,
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

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: 0);

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;
}
