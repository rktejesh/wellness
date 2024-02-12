import 'dart:convert';

import 'package:equatable/equatable.dart';

class PreTestRequirement extends Equatable {
  final bool? isFasted;
  final DateTime? lastFedtime;
  final bool? sugarTest;
  final String? lastIntake;

  const PreTestRequirement({
    this.isFasted,
    this.lastFedtime,
    this.sugarTest,
    this.lastIntake,
  });

  factory PreTestRequirement.fromMap(Map<String, dynamic> data) {
    return PreTestRequirement(
      isFasted: data['is_fasted'] as bool?,
      lastFedtime: data['last_fedtime'] == null
          ? null
          : DateTime.parse(data['last_fedtime'] as String),
      sugarTest: data['sugar_test'] as bool?,
      lastIntake: data['last_intake'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'is_fasted': isFasted,
        'last_fedtime': lastFedtime?.toIso8601String(),
        'sugar_test': sugarTest,
        'last_intake': lastIntake,
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
    bool? isFasted,
    DateTime? lastFedtime,
    bool? sugarTest,
    String? lastIntake,
  }) {
    return PreTestRequirement(
      isFasted: isFasted ?? this.isFasted,
      lastFedtime: lastFedtime ?? this.lastFedtime,
      sugarTest: sugarTest ?? this.sugarTest,
      lastIntake: lastIntake ?? this.lastIntake,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      isFasted,
      lastFedtime,
      sugarTest,
      lastIntake,
    ];
  }
}
