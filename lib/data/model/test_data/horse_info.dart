import 'dart:convert';

import 'package:equatable/equatable.dart';

class HorseInfo extends Equatable {
  final int? id;
  final String? barnName;
  final dynamic yearOfBorn;
  final dynamic isDiagnosed;
  final String? discipline;
  final String? exercise;
  final int? weight;
  final String? bodyCondition;
  final dynamic isRetired;
  final dynamic isPregnant;
  final String? breedingStock;
  final dynamic isDrylot;
  final dynamic isMetabolicSupplement;
  final dynamic isHoofSupplement;
  final dynamic diet;
  final dynamic pharmaceuticals;
  final dynamic laminitisEpisodes;
  final dynamic isPpidDiagnosed;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const HorseInfo({
    this.id,
    this.barnName,
    this.yearOfBorn,
    this.isDiagnosed,
    this.discipline,
    this.exercise,
    this.weight,
    this.bodyCondition,
    this.isRetired,
    this.isPregnant,
    this.breedingStock,
    this.isDrylot,
    this.isMetabolicSupplement,
    this.isHoofSupplement,
    this.diet,
    this.pharmaceuticals,
    this.laminitisEpisodes,
    this.isPpidDiagnosed,
    this.createdAt,
    this.updatedAt,
  });

  factory HorseInfo.fromMap(Map<String, dynamic> data) => HorseInfo(
        id: data['id'] as int?,
        barnName: data['barn_name'] as String?,
        yearOfBorn: data['year_of_born'] as dynamic,
        isDiagnosed: data['is_diagnosed'] as dynamic,
        discipline: data['discipline'] as String?,
        exercise: data['exercise'] as String?,
        weight: data['weight'] as int?,
        bodyCondition: data['body_condition'] as String?,
        isRetired: data['is_retired'] as dynamic,
        isPregnant: data['is_pregnant'] as dynamic,
        breedingStock: data['breeding_stock'] as String?,
        isDrylot: data['is_drylot'] as dynamic,
        isMetabolicSupplement: data['is_metabolic_supplement'] as dynamic,
        isHoofSupplement: data['is_hoof_supplement'] as dynamic,
        diet: data['diet'] as dynamic,
        pharmaceuticals: data['pharmaceuticals'] as dynamic,
        laminitisEpisodes: data['laminitis_episodes'] as dynamic,
        isPpidDiagnosed: data['is_PPID_diagnosed'] as dynamic,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'barn_name': barnName,
        'year_of_born': yearOfBorn,
        'is_diagnosed': isDiagnosed,
        'discipline': discipline,
        'exercise': exercise,
        'weight': weight,
        'body_condition': bodyCondition,
        'is_retired': isRetired,
        'is_pregnant': isPregnant,
        'breeding_stock': breedingStock,
        'is_drylot': isDrylot,
        'is_metabolic_supplement': isMetabolicSupplement,
        'is_hoof_supplement': isHoofSupplement,
        'diet': diet,
        'pharmaceuticals': pharmaceuticals,
        'laminitis_episodes': laminitisEpisodes,
        'is_PPID_diagnosed': isPpidDiagnosed,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [HorseInfo].
  factory HorseInfo.fromJson(String data) {
    return HorseInfo.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [HorseInfo] to a JSON string.
  String toJson() => json.encode(toMap());

  HorseInfo copyWith({
    int? id,
    String? barnName,
    dynamic yearOfBorn,
    dynamic isDiagnosed,
    String? discipline,
    String? exercise,
    int? weight,
    String? bodyCondition,
    dynamic isRetired,
    dynamic isPregnant,
    String? breedingStock,
    dynamic isDrylot,
    dynamic isMetabolicSupplement,
    dynamic isHoofSupplement,
    dynamic diet,
    dynamic pharmaceuticals,
    dynamic laminitisEpisodes,
    dynamic isPpidDiagnosed,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return HorseInfo(
      id: id ?? this.id,
      barnName: barnName ?? this.barnName,
      yearOfBorn: yearOfBorn ?? this.yearOfBorn,
      isDiagnosed: isDiagnosed ?? this.isDiagnosed,
      discipline: discipline ?? this.discipline,
      exercise: exercise ?? this.exercise,
      weight: weight ?? this.weight,
      bodyCondition: bodyCondition ?? this.bodyCondition,
      isRetired: isRetired ?? this.isRetired,
      isPregnant: isPregnant ?? this.isPregnant,
      breedingStock: breedingStock ?? this.breedingStock,
      isDrylot: isDrylot ?? this.isDrylot,
      isMetabolicSupplement:
          isMetabolicSupplement ?? this.isMetabolicSupplement,
      isHoofSupplement: isHoofSupplement ?? this.isHoofSupplement,
      diet: diet ?? this.diet,
      pharmaceuticals: pharmaceuticals ?? this.pharmaceuticals,
      laminitisEpisodes: laminitisEpisodes ?? this.laminitisEpisodes,
      isPpidDiagnosed: isPpidDiagnosed ?? this.isPpidDiagnosed,
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
      barnName,
      yearOfBorn,
      isDiagnosed,
      discipline,
      exercise,
      weight,
      bodyCondition,
      isRetired,
      isPregnant,
      breedingStock,
      isDrylot,
      isMetabolicSupplement,
      isHoofSupplement,
      diet,
      pharmaceuticals,
      laminitisEpisodes,
      isPpidDiagnosed,
      createdAt,
      updatedAt,
    ];
  }
}
