import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:wellness/data/model/horse/veterinarian.dart';

import 'breed.dart';
import 'breeder.dart';
import 'image.dart';
import 'owner.dart';
import 'ownership_log.dart';
import 'trainer.dart';

class Horse extends Equatable {
  final int? id;
  final String? barnName;
  final String? yearOfBorn;
  final bool? isDiagnosed;
  final String? discipline;
  final String? exercise;
  final int? weight;
  final String? bodyCondition;
  final bool? isRetired;
  final bool? isPregnant;
  final String? breedingStock;
  final bool? isDrylot;
  final bool? isMetabolicSupplement;
  final bool? isHoofSupplement;
  final List<String>? diet;
  final List<String>? pharmaceuticals;
  final int? laminitisEpisodes;
  final bool? isPpidDiagnosed;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Owner? owner;
  final Breeder? breeder;
  final Trainer? trainer;
  final Veterinarian? veterinarian;
  final Breed? breed;
  final Image? image;
  final List<OwnershipLog>? ownershipLogs;

  const Horse({
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
    this.owner,
    this.breeder,
    this.trainer,
    this.veterinarian,
    this.breed,
    this.image,
    this.ownershipLogs,
  });

  factory Horse.fromMap(Map<String, dynamic> data) {
    // List<String> diet = data['diet'] == null
    //     ? []
    //     : data['diet'].map((dynamic item) => item.toString()).toList();

    // List<String> pharmaceuticals = data['pharmaceuticals'] == null
    //     ? []
    //     : data['pharmaceuticals']
    //         .map((dynamic item) => item.toString())
    //         .toList();
    return Horse(
      id: data['id'] as int?,
      barnName: data['barn_name'] as String?,
      yearOfBorn: data['year_of_born'] as String?,
      isDiagnosed: data['is_diagnosed'] as bool?,
      discipline: data['discipline'] as String?,
      exercise: data['exercise'] as String?,
      weight: data['weight'] as int?,
      bodyCondition: data['body_condition'] as String?,
      isRetired: data['is_retired'] as bool?,
      isPregnant: data['is_pregnant'] as bool?,
      breedingStock: data['breeding_stock'] as String?,
      isDrylot: data['is_drylot'] as bool?,
      isMetabolicSupplement: data['is_metabolic_supplement'] as bool?,
      isHoofSupplement: data['is_hoof_supplement'] as bool?,
      // diet: diet,
      // pharmaceuticals: pharmaceuticals,
      laminitisEpisodes: data['laminitis_episodes'] as int?,
      isPpidDiagnosed: data['is_PPID_diagnosed'] as bool?,
      createdAt: data['createdAt'] == null
          ? null
          : DateTime.parse(data['createdAt'] as String),
      updatedAt: data['updatedAt'] == null
          ? null
          : DateTime.parse(data['updatedAt'] as String),
      owner: data['owner'] == null
          ? null
          : Owner.fromMap(data['owner'] as Map<String, dynamic>),
      breeder: data['breeder'] == null
          ? null
          : Breeder.fromMap(data['breeder'] as Map<String, dynamic>),
      trainer: data['trainer'] == null
          ? null
          : Trainer.fromMap(data['trainer'] as Map<String, dynamic>),
      veterinarian: data['veterinarian'] == null
          ? null
          : Veterinarian.fromMap(data['veterinarian'] as Map<String, dynamic>),
      breed: data['breed'] == null
          ? null
          : Breed.fromMap(data['breed'] as Map<String, dynamic>),
      image: data['image'] == null
          ? null
          : Image.fromMap(data['image'] as Map<String, dynamic>),
      ownershipLogs: (data['ownership_logs'] as List<dynamic>?)
          ?.map((e) => OwnershipLog.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

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
        'owner': owner?.toMap(),
        'breeder': breeder?.toMap(),
        'trainer': trainer?.toMap(),
        'breed': breed?.toMap(),
        'veterinarian': veterinarian?.toMap(),
        'image': image?.toMap(),
        'ownership_logs': ownershipLogs?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Horse].
  factory Horse.fromJson(String data) {
    return Horse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Horse] to a JSON string.
  String toJson() => json.encode(toMap());

  Horse copyWith({
    int? id,
    String? barnName,
    String? yearOfBorn,
    bool? isDiagnosed,
    String? discipline,
    String? exercise,
    int? weight,
    String? bodyCondition,
    bool? isRetired,
    bool? isPregnant,
    String? breedingStock,
    bool? isDrylot,
    bool? isMetabolicSupplement,
    bool? isHoofSupplement,
    List<String>? diet,
    List<String>? pharmaceuticals,
    int? laminitisEpisodes,
    bool? isPpidDiagnosed,
    DateTime? createdAt,
    DateTime? updatedAt,
    Owner? owner,
    Breeder? breeder,
    Trainer? trainer,
    Veterinarian? veterinarian,
    Breed? breed,
    Image? image,
    List<OwnershipLog>? ownershipLogs,
  }) {
    return Horse(
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
      owner: owner ?? this.owner,
      breeder: breeder ?? this.breeder,
      trainer: trainer ?? this.trainer,
      veterinarian: veterinarian ?? this.veterinarian,
      breed: breed ?? this.breed,
      image: image ?? this.image,
      ownershipLogs: ownershipLogs ?? this.ownershipLogs,
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
      owner,
      breeder,
      trainer,
      veterinarian,
      breed,
      image,
      ownershipLogs,
    ];
  }
}
