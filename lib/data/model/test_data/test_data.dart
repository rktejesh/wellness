import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'conducted_by.dart';
import 'horse_info.dart';
import 'pre_test_requirement.dart';

class TestData extends Equatable {
  final int? id;
  final String? imageUrl;
  final double? predictedValue;
  final dynamic correctValue;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;
  final PreTestRequirement? preTestRequirement;
  final HorseInfo? horseInfo;
  final ConductedBy? conductedBy;
  final dynamic createdBy;
  final dynamic updatedBy;
  final DateTime? start_time;
  final DateTime? end_time;

  const TestData({
    this.id,
    this.imageUrl,
    this.predictedValue,
    this.correctValue,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.preTestRequirement,
    this.horseInfo,
    this.conductedBy,
    this.createdBy,
    this.updatedBy,
    this.start_time,
    this.end_time,
  });

  factory TestData.fromMap(Map<String, dynamic> data) => TestData(
        id: data['id'] as int?,
        imageUrl: data['image_url'] as String?,
        predictedValue: (data['predicted_value'] as num?)?.toDouble(),
        correctValue: data['correct_value'] as dynamic,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
        publishedAt: data['publishedAt'] == null
            ? null
            : DateTime.parse(data['publishedAt'] as String),
        preTestRequirement: data['pre_test_requirement'] == null
            ? null
            : PreTestRequirement.fromMap(
                data['pre_test_requirement'] as Map<String, dynamic>),
        horseInfo: data['horse_info'] == null
            ? null
            : HorseInfo.fromMap(data['horse_info'] as Map<String, dynamic>),
        conductedBy: data['conducted_by'] == null
            ? null
            : ConductedBy.fromMap(data['conducted_by'] as Map<String, dynamic>),
        createdBy: data['createdBy'] as dynamic,
        updatedBy: data['updatedBy'] as dynamic,
        start_time: data['start_time'] != null
            ? DateTime.parse(data['start_time'])
            : null,
        end_time:
            data['end_time'] != null ? DateTime.parse(data['end_time']) : null,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'image_url': imageUrl,
        'predicted_value': predictedValue,
        'correct_value': correctValue,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'publishedAt': publishedAt?.toIso8601String(),
        'pre_test_requirement': preTestRequirement?.toMap(),
        'horse_info': horseInfo?.toMap(),
        'conducted_by': conductedBy?.toMap(),
        'createdBy': createdBy,
        'updatedBy': updatedBy,
        'start_time': start_time?.toIso8601String(),
        'end_time': end_time?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TestData].
  factory TestData.fromJson(String data) {
    return TestData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TestData] to a JSON string.
  String toJson() => json.encode(toMap());

  TestData copyWith({
    int? id,
    String? imageUrl,
    double? predictedValue,
    dynamic correctValue,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? publishedAt,
    PreTestRequirement? preTestRequirement,
    HorseInfo? horseInfo,
    ConductedBy? conductedBy,
    dynamic createdBy,
    dynamic updatedBy,
    DateTime? start_time,
    DateTime? end_time,
  }) {
    return TestData(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      predictedValue: predictedValue ?? this.predictedValue,
      correctValue: correctValue ?? this.correctValue,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      publishedAt: publishedAt ?? this.publishedAt,
      preTestRequirement: preTestRequirement ?? this.preTestRequirement,
      horseInfo: horseInfo ?? this.horseInfo,
      conductedBy: conductedBy ?? this.conductedBy,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      start_time: start_time ?? this.start_time,
      end_time: end_time ?? this.end_time,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      imageUrl,
      predictedValue,
      correctValue,
      createdAt,
      updatedAt,
      publishedAt,
      preTestRequirement,
      horseInfo,
      conductedBy,
      createdBy,
      updatedBy,
      start_time,
      end_time,
    ];
  }
}
