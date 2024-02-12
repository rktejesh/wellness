import 'dart:convert';

import 'package:equatable/equatable.dart';

class CurrentOwner extends Equatable {
  final int? id;
  final String? firstName;

  const CurrentOwner({this.id, this.firstName});

  factory CurrentOwner.fromMap(Map<String, dynamic> data) => CurrentOwner(
        id: data['id'] as int?,
        firstName: data['first_name'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'first_name': firstName,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CurrentOwner].
  factory CurrentOwner.fromJson(String data) {
    return CurrentOwner.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CurrentOwner] to a JSON string.
  String toJson() => json.encode(toMap());

  CurrentOwner copyWith({
    int? id,
    String? firstName,
  }) {
    return CurrentOwner(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, firstName];
}
