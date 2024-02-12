import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'attributes.dart';

class TestProcedure extends Equatable {
  final int? id;
  final Attributes? attributes;

  const TestProcedure({this.id, this.attributes});

  factory TestProcedure.fromMap(Map<String, dynamic> data) => TestProcedure(
        id: data['id'] as int?,
        attributes: data['attributes'] == null
            ? null
            : Attributes.fromMap(data['attributes'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'attributes': attributes?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TestProcedure].
  factory TestProcedure.fromJson(String data) {
    return TestProcedure.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TestProcedure] to a JSON string.
  String toJson() => json.encode(toMap());

  TestProcedure copyWith({
    int? id,
    Attributes? attributes,
  }) {
    return TestProcedure(
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, attributes];
}
