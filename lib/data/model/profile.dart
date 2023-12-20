import 'dart:convert';

import 'package:equatable/equatable.dart';

class Profile {
  String? country;
  String? city;
  String? state;
  String? postalCode;
  String? firstName;
  String? lastName;
  String? address1;
  String? address2;
  String phoneNumber = '';
  String countryCode = '';

  Map<String, dynamic> toMap() {
    return {
      'country': country,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'firstName': firstName,
      'lastName': lastName,
      'address1': address1,
      'address2': address2,
      'phoneNumber': phoneNumber,
      'countryCode': countryCode,
    };
  }
}

// class Profile extends Equatable {
//    String? country;
//    String? city;
//    String? state;
//    String? postalCode;
//    String? firstName;
//    String? lastName;
//    String? address1;
//    String? address2;

//   const Profile({
//     this.country,
//     this.city,
//     this.state,
//     this.postalCode,
//     this.firstName,
//     this.lastName,
//     this.address1,
//     this.address2,
//   });

//   factory Profile.fromMap(Map<String, dynamic> data) => Profile(
//         country: data['country'] as String?,
//         city: data['city'] as String?,
//         state: data['state'] as String?,
//         postalCode: data['postal_code'] as String?,
//         firstName: data['first_name'] as String?,
//         lastName: data['last_name'] as String?,
//         address1: data['address1'] as String?,
//         address2: data['address2'] as String?,
//       );

//   Map<String, dynamic> toMap() => {
//         'country': country,
//         'city': city,
//         'state': state,
//         'postal_code': postalCode,
//         'first_name': firstName,
//         'last_name': lastName,
//         'address1': address1,
//         'address2': address2,
//       };

//   /// `dart:convert`
//   ///
//   /// Parses the string and returns the resulting Json object as [Profile].
//   factory Profile.fromJson(String data) {
//     return Profile.fromMap(json.decode(data) as Map<String, dynamic>);
//   }

//   /// `dart:convert`
//   ///
//   /// Converts [Profile] to a JSON string.
//   String toJson() => json.encode(toMap());

//   Profile copyWith({
//     String? country,
//     String? city,
//     String? state,
//     String? postalCode,
//     String? firstName,
//     String? lastName,
//     String? address1,
//     String? address2,
//   }) {
//     return Profile(
//       country: country ?? this.country,
//       city: city ?? this.city,
//       state: state ?? this.state,
//       postalCode: postalCode ?? this.postalCode,
//       firstName: firstName ?? this.firstName,
//       lastName: lastName ?? this.lastName,
//       address1: address1 ?? this.address1,
//       address2: address2 ?? this.address2,
//     );
//   }

//   @override
//   List<Object?> get props {
//     return [
//       country,
//       city,
//       state,
//       postalCode,
//       firstName,
//       lastName,
//       address1,
//       address2,
//     ];
//   }
// }
