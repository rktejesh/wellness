import 'dart:convert';

import 'package:equatable/equatable.dart';

class PreTestRequirement extends Equatable {
  final int? id;
  final bool? isFasted;
  final DateTime? lastFedtime;
  final bool? sugarTest;
  final String? lastIntake;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const PreTestRequirement({
    this.id,
    this.isFasted,
    this.lastFedtime,
    this.sugarTest,
    this.lastIntake,
    this.createdAt,
    this.updatedAt,
  });

  factory PreTestRequirement.fromMap(Map<String, dynamic> data) {
    return PreTestRequirement(
      id: data['id'] as int?,
      isFasted: data['is_fasted'] as bool?,
      lastFedtime: data['last_fedtime'] == null
          ? null
          : DateTime.parse(data['last_fedtime'] as String),
      sugarTest: data['sugar_test'] as bool?,
      lastIntake: data['last_intake'] as String?,
      createdAt: data['createdAt'] == null
          ? null
          : DateTime.parse(data['createdAt'] as String),
      updatedAt: data['updatedAt'] == null
          ? null
          : DateTime.parse(data['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'is_fasted': isFasted,
        'last_fedtime': lastFedtime?.toIso8601String(),
        'sugar_test': sugarTest,
        'last_intake': lastIntake,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PreTestRequirement].
  factory PreTestRequirement.fromJson(String data) {
    return PreTestRequirement.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PreTestRequirement] to a JSON string.
  String toJson() => json.encode(toMap());

  PreTestRequirement copyWith({
    int? id,
    bool? isFasted,
    DateTime? lastFedtime,
    bool? sugarTest,
    String? lastIntake,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PreTestRequirement(
      id: id ?? this.id,
      isFasted: isFasted ?? this.isFasted,
      lastFedtime: lastFedtime ?? this.lastFedtime,
      sugarTest: sugarTest ?? this.sugarTest,
      lastIntake: lastIntake ?? this.lastIntake,
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
      isFasted,
      lastFedtime,
      sugarTest,
      lastIntake,
      createdAt,
      updatedAt,
    ];
  }
}
