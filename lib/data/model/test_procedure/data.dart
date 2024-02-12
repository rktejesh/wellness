import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'media_attributes.dart';

class Data extends Equatable {
  final int? id;
  final MediaAttributes? mediaattributes;

  const Data({this.id, this.mediaattributes});

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        id: data['id'] as int?,
        mediaattributes: data['attributes'] == null
            ? null
            : MediaAttributes.fromMap(
                data['attributes'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'attributes': mediaattributes?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  Data copyWith({
    int? id,
    MediaAttributes? mediaattributes,
  }) {
    return Data(
      id: id ?? this.id,
      mediaattributes: mediaattributes ?? this.mediaattributes,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, mediaattributes];
}
