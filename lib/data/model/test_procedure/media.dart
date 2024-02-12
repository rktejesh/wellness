import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'data.dart';

class Media extends Equatable {
  final Data? data;

  const Media({this.data});

  factory Media.fromMap(Map<String, dynamic> data) => Media(
        data: data['data'] == null
            ? null
            : Data.fromMap(data['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Media].
  factory Media.fromJson(String data) {
    return Media.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Media] to a JSON string.
  String toJson() => json.encode(toMap());

  Media copyWith({
    Data? data,
  }) {
    return Media(
      data: data ?? this.data,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [data];
}
