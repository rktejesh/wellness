import 'dart:convert';

import 'package:equatable/equatable.dart';

class Breed extends Equatable {
  final int? id;
  final String? name;

  const Breed({this.id, this.name});

  factory Breed.fromMap(Map<String, dynamic> data) => Breed(
        id: data['id'] as int?,
        name: data['name'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Breed].
  factory Breed.fromJson(String data) {
    return Breed.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Breed] to a JSON string.
  String toJson() => json.encode(toMap());

  Breed copyWith({
    int? id,
    String? name,
  }) {
    return Breed(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name];
}
