import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wellness/data/api/api_service.dart';
import 'package:wellness/data/model/horse/horse.dart';
import 'package:wellness/utils/dimensions.dart';
import 'package:wellness/views/screens/horse/horse_details.dart';

class HorseListScreen extends StatelessWidget {
  const HorseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Horses'),
      ),
      body: FutureBuilder<List<Horse>>(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final horsesData = snapshot.data!;
              return ListView.builder(
                itemCount: horsesData.length,
                itemBuilder: (context, index) {
                  final horse = horsesData[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Padding(
                      padding:
                          const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          horse.image != null && horse.image?.url != null
                              ? CachedNetworkImage(
                                  imageUrl: horse.image!.url ?? "",
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : const SizedBox(),
                          const SizedBox(height: 10),
                          Text(
                            horse.barnName ?? "",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text('Breed: ${horse.breed?.name ?? ""}'),
                          Text('Discipline: ${horse.discipline ?? ""}'),
                          Text('Year of Born: ${horse.yearOfBorn ?? ""}'),
                          Text('Weight: ${horse.weight} kg'),
                          Text('Body Condition: ${horse.bodyCondition ?? ""}'),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              // Handle button press for more details if needed
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewHorseDetails(horse),
                                ),
                              );
                            },
                            child: const Text('View Details'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else {
              return const Center(
                child: Text("No data"),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        future: ApiService().getHorses(),
      ),
    );
  }
}
