import 'dart:convert';

import 'package:equatable/equatable.dart';

class Thumbnail extends Equatable {
  final String? ext;
  final String? url;
  final String? hash;
  final String? mime;
  final String? name;
  final dynamic path;
  final double? size;
  final int? width;
  final int? height;

  const Thumbnail({
    this.ext,
    this.url,
    this.hash,
    this.mime,
    this.name,
    this.path,
    this.size,
    this.width,
    this.height,
  });

  factory Thumbnail.fromMap(Map<String, dynamic> data) => Thumbnail(
        ext: data['ext'] as String?,
        url: data['url'] as String?,
        hash: data['hash'] as String?,
        mime: data['mime'] as String?,
        name: data['name'] as String?,
        path: data['path'] as dynamic,
        size: (data['size'] as num?)?.toDouble(),
        width: data['width'] as int?,
        height: data['height'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'ext': ext,
        'url': url,
        'hash': hash,
        'mime': mime,
        'name': name,
        'path': path,
        'size': size,
        'width': width,
        'height': height,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Thumbnail].
  factory Thumbnail.fromJson(String data) {
    return Thumbnail.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Thumbnail] to a JSON string.
  String toJson() => json.encode(toMap());

  Thumbnail copyWith({
    String? ext,
    String? url,
    String? hash,
    String? mime,
    String? name,
    dynamic path,
    double? size,
    int? width,
    int? height,
  }) {
    return Thumbnail(
      ext: ext ?? this.ext,
      url: url ?? this.url,
      hash: hash ?? this.hash,
      mime: mime ?? this.mime,
      name: name ?? this.name,
      path: path ?? this.path,
      size: size ?? this.size,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      ext,
      url,
      hash,
      mime,
      name,
      path,
      size,
      width,
      height,
    ];
  }
}
