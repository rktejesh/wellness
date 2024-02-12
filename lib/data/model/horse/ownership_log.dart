import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'current_owner.dart';
import 'previous_owner.dart';

class OwnershipLog extends Equatable {
  final int? id;
  final DateTime? timeStamp;
  final PreviousOwner? previousOwner;
  final CurrentOwner? currentOwner;

  const OwnershipLog({
    this.id,
    this.timeStamp,
    this.previousOwner,
    this.currentOwner,
  });

  factory OwnershipLog.fromMap(Map<String, dynamic> data) => OwnershipLog(
        id: data['id'] as int?,
        timeStamp: data['time_stamp'] == null
            ? null
            : DateTime.parse(data['time_stamp'] as String),
        previousOwner: data['previous_owner'] == null
            ? null
            : PreviousOwner.fromMap(
                data['previous_owner'] as Map<String, dynamic>),
        currentOwner: data['current_owner'] == null
            ? null
            : CurrentOwner.fromMap(
                data['current_owner'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'time_stamp': timeStamp?.toIso8601String(),
        'previous_owner': previousOwner?.toMap(),
        'current_owner': currentOwner?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OwnershipLog].
  factory OwnershipLog.fromJson(String data) {
    return OwnershipLog.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OwnershipLog] to a JSON string.
  String toJson() => json.encode(toMap());

  OwnershipLog copyWith({
    int? id,
    DateTime? timeStamp,
    PreviousOwner? previousOwner,
    CurrentOwner? currentOwner,
  }) {
    return OwnershipLog(
      id: id ?? this.id,
      timeStamp: timeStamp ?? this.timeStamp,
      previousOwner: previousOwner ?? this.previousOwner,
      currentOwner: currentOwner ?? this.currentOwner,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, timeStamp, previousOwner, currentOwner];
}
