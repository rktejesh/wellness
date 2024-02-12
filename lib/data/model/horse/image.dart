import 'dart:convert';

import 'package:equatable/equatable.dart';

class Image extends Equatable {
  final int? id;
  final String? url;

  const Image({this.id, this.url});

  factory Image.fromMap(Map<String, dynamic> data) => Image(
        id: data['id'] as int?,
        url: data['url'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'url': url,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Image].
  factory Image.fromJson(String data) {
    return Image.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Image] to a JSON string.
  String toJson() => json.encode(toMap());

  Image copyWith({
    int? id,
    String? url,
  }) {
    return Image(
      id: id ?? this.id,
      url: url ?? this.url,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, url];
}
