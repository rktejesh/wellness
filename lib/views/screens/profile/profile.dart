import 'package:flutter/material.dart';
import 'package:wellness/data/api/api_service.dart';
import 'package:wellness/data/model/user_profile/user_profile.dart';
import 'package:wellness/utils/dimensions.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: FutureBuilder(
          future: ApiService().getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasData) {
                UserProfile userProfile = snapshot.data as UserProfile;
                String name = "";
                if (userProfile.userDetails != null &&
                    userProfile.userDetails!.owner != null) {
                  name =
                      "${userProfile.userDetails!.owner!.firstName ?? ""} ${userProfile.userDetails!.owner!.lastName ?? ""}";
                } else if (userProfile.userDetails != null &&
                    userProfile.userDetails!.breeder != null) {
                  name =
                      "${userProfile.userDetails!.breeder!.firstName ?? ""} ${userProfile.userDetails!.breeder!.lastName ?? ""}";
                } else if (userProfile.userDetails != null &&
                    userProfile.userDetails!.trainer != null) {
                  name =
                      "${userProfile.userDetails!.trainer!.firstName ?? ""} ${userProfile.userDetails!.trainer!.lastName ?? ""}";
                } else if (userProfile.userDetails != null &&
                    userProfile.userDetails!.veterinarian != null) {
                  name =
                      "${userProfile.userDetails!.veterinarian!.firstName ?? ""} ${userProfile.userDetails!.veterinarian!.lastName ?? ""}";
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/bg.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_LARGE),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(
                                            Dimensions.PADDING_SIZE_DEFAULT),
                                        child: CircleAvatar(
                                          radius: 50,
                                          child: Image.network(
                                            "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png",
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 3,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  Dimensions
                                                      .PADDING_SIZE_EXTRA_SMALL),
                                              child: Text(
                                                name,
                                              ),
                                            ),
                                            userProfile.userDetails
                                                        ?.mobileNumber !=
                                                    null
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                        .all(Dimensions
                                                            .PADDING_SIZE_EXTRA_SMALL),
                                                    child: Text(
                                                      userProfile.userDetails
                                                              ?.mobileNumber ??
                                                          "",
                                                    ),
                                                  )
                                                : const SizedBox(),
                                            userProfile.userDetails?.email !=
                                                    null
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                        .all(Dimensions
                                                            .PADDING_SIZE_EXTRA_SMALL),
                                                    child: Text(
                                                      userProfile.userDetails
                                                              ?.email ??
                                                          "",
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_LARGE),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (userProfile.userDetails != null &&
                          userProfile.userDetails!.owner != null)
                        _buildDetailsCard('Owner Details',
                            userProfile.userDetails!.owner!.toDisplayMap()),
                      if (userProfile.userDetails != null &&
                          userProfile.userDetails!.breeder != null)
                        _buildDetailsCard('Breeder Details',
                            userProfile.userDetails!.breeder!.toDisplayMap()),
                      if (userProfile.userDetails != null &&
                          userProfile.userDetails!.trainer != null)
                        _buildDetailsCard('Trainer Details',
                            userProfile.userDetails!.trainer!.toDisplayMap()),
                      if (userProfile.userDetails != null &&
                          userProfile.userDetails!.veterinarian != null)
                        _buildDetailsCard(
                            'Veterinarian Details',
                            userProfile.userDetails!.veterinarian!
                                .toDisplayMap()),
                    ],
                  ),
                );
              } else {
                return const Center(child: Text("No data found"));
              }
            }
          }),
    );
  }

  Widget _buildDetailsCard(String title, Map<String, dynamic> details) {
    return Card(
      color: Colors.white,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
            title: Text(title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          const Divider(),
          ...details.entries.map((entry) {
            return ListTile(
              dense: true,
              // trailing: const SizedBox(),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(entry.key)),
                  Expanded(
                    child: Text(
                      entry.value != null
                          ? entry.value.toString()
                          : "Not Added",
                      overflow: TextOverflow.clip,
                      softWrap: true,
                      maxLines: 3,
                      textAlign: TextAlign.end,
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
