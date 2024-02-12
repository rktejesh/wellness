import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'thumbnail.dart';

class Formats extends Equatable {
  final Thumbnail? thumbnail;

  const Formats({this.thumbnail});

  factory Formats.fromMap(Map<String, dynamic> data) => Formats(
        thumbnail: data['thumbnail'] == null
            ? null
            : Thumbnail.fromMap(data['thumbnail'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'thumbnail': thumbnail?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Formats].
  factory Formats.fromJson(String data) {
    return Formats.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Formats] to a JSON string.
  String toJson() => json.encode(toMap());

  Formats copyWith({
    Thumbnail? thumbnail,
  }) {
    return Formats(
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [thumbnail];
}
