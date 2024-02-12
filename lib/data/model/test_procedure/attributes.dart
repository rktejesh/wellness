import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'media.dart';

class Attributes extends Equatable {
  final dynamic precautions;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;
  final String? description;
  final dynamic time;
  final Media? media;

  const Attributes({
    this.precautions,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.description,
    this.time,
    this.media,
  });

  factory Attributes.fromMap(Map<String, dynamic> data) => Attributes(
        precautions: data['precautions'] as dynamic,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
        publishedAt: data['publishedAt'] == null
            ? null
            : DateTime.parse(data['publishedAt'] as String),
        description: data['description'] as String?,
        time: data['time'] as dynamic,
        media: data['media'] == null
            ? null
            : Media.fromMap(data['media'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'precautions': precautions,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'publishedAt': publishedAt?.toIso8601String(),
        'description': description,
        'time': time,
        'media': media?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Attributes].
  factory Attributes.fromJson(String data) {
    return Attributes.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Attributes] to a JSON string.
  String toJson() => json.encode(toMap());

  Attributes copyWith({
    dynamic precautions,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? publishedAt,
    String? description,
    dynamic time,
    Media? media,
  }) {
    return Attributes(
      precautions: precautions ?? this.precautions,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      publishedAt: publishedAt ?? this.publishedAt,
      description: description ?? this.description,
      time: time ?? this.time,
      media: media ?? this.media,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      precautions,
      createdAt,
      updatedAt,
      publishedAt,
      description,
      time,
      media,
    ];
  }
}
