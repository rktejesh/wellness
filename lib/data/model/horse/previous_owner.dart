import 'dart:convert';

import 'package:equatable/equatable.dart';

class PreviousOwner extends Equatable {
  final int? id;
  final String? firstName;

  const PreviousOwner({this.id, this.firstName});

  factory PreviousOwner.fromMap(Map<String, dynamic> data) => PreviousOwner(
        id: data['id'] as int?,
        firstName: data['first_name'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'first_name': firstName,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PreviousOwner].
  factory PreviousOwner.fromJson(String data) {
    return PreviousOwner.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PreviousOwner] to a JSON string.
  String toJson() => json.encode(toMap());

  PreviousOwner copyWith({
    int? id,
    String? firstName,
  }) {
    return PreviousOwner(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, firstName];
}
