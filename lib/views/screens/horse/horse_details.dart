import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wellness/data/model/horse/horse.dart';

class ViewHorseDetails extends StatelessWidget {
  final Horse horse;

  const ViewHorseDetails(this.horse, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> details = [
      {'Discipline': horse.discipline ?? ""},
      {'Year of Born': horse.yearOfBorn ?? ""},
      {'Weight': '${horse.weight ?? ""} kg'},
      {'Body Condition': horse.bodyCondition ?? ""},
      {'Owner': horse.owner?.firstName ?? "No Owner"},
      {'Breeder': horse.breeder?.firstName ?? "No Breeder"},
      {'Trainer': horse.trainer?.firstName ?? "No Trainer"},
      {'Veterinarian': horse.veterinarian?.firstName ?? "No Veterinarian"},
      {'Breed': horse.breed?.name ?? ""},
      {'Exercise': horse.exercise ?? ""},
      {'Is Diagnosed': horse.isDiagnosed?.toString() ?? ""},
      {'Is Drylot': horse.isDrylot?.toString() ?? ""},
      {
        'Is Metabolic Supplement': horse.isMetabolicSupplement?.toString() ?? ""
      },
      {'Is Hoof Supplement': horse.isHoofSupplement?.toString() ?? ""},
      {'Diet': horse.diet?.join(", ") ?? ""},
      {'Pharmaceuticals': horse.pharmaceuticals?.join(", ") ?? ""},
      {'Breeding Stock': horse.breedingStock ?? ""},
      {'Laminitis Episodes': horse.laminitisEpisodes?.toString() ?? ""},
      {'Is PPID Diagnosed': horse.isPpidDiagnosed?.toString() ?? ""},
      {'Is Retired': horse.isRetired?.toString() ?? ""},
      {'Is Pregnant': horse.isPregnant?.toString() ?? ""},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Horse Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (horse.image != null && horse.image!.url != null)
              CachedNetworkImage(
                imageUrl: horse.image!.url ?? "",
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 16),
            Text(
              horse.barnName ?? "",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              itemCount: details.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final entry = details[index];
                final key = entry.keys.first;
                final value = entry.values.first;
                return ListTile(
                  title: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          key,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(value),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
