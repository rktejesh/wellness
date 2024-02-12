import 'dart:convert';

import 'package:equatable/equatable.dart';

class MediaAttributes extends Equatable {
  final String? name;
  final dynamic alternativeText;
  final dynamic caption;
  final dynamic width;
  final dynamic height;
  final dynamic formats;
  final String? hash;
  final String? ext;
  final String? mime;
  final double? size;
  final String? url;
  final dynamic previewUrl;
  final String? provider;
  final dynamic providerMetadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const MediaAttributes({
    this.name,
    this.alternativeText,
    this.caption,
    this.width,
    this.height,
    this.formats,
    this.hash,
    this.ext,
    this.mime,
    this.size,
    this.url,
    this.previewUrl,
    this.provider,
    this.providerMetadata,
    this.createdAt,
    this.updatedAt,
  });

  factory MediaAttributes.fromMap(Map<String, dynamic> data) {
    return MediaAttributes(
      name: data['name'] as String?,
      alternativeText: data['alternativeText'] as dynamic,
      caption: data['caption'] as dynamic,
      width: data['width'] as dynamic,
      height: data['height'] as dynamic,
      formats: data['formats'] as dynamic,
      hash: data['hash'] as String?,
      ext: data['ext'] as String?,
      mime: data['mime'] as String?,
      size: (data['size'] as num?)?.toDouble(),
      url: data['url'] as String?,
      previewUrl: data['previewUrl'] as dynamic,
      provider: data['provider'] as String?,
      providerMetadata: data['provider_metadata'] as dynamic,
      createdAt: data['createdAt'] == null
          ? null
          : DateTime.parse(data['createdAt'] as String),
      updatedAt: data['updatedAt'] == null
          ? null
          : DateTime.parse(data['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'alternativeText': alternativeText,
        'caption': caption,
        'width': width,
        'height': height,
        'formats': formats,
        'hash': hash,
        'ext': ext,
        'mime': mime,
        'size': size,
        'url': url,
        'previewUrl': previewUrl,
        'provider': provider,
        'provider_metadata': providerMetadata,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MediaAttributes].
  factory MediaAttributes.fromJson(String data) {
    return MediaAttributes.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MediaAttributes] to a JSON string.
  String toJson() => json.encode(toMap());

  MediaAttributes copyWith({
    String? name,
    dynamic alternativeText,
    dynamic caption,
    dynamic width,
    dynamic height,
    dynamic formats,
    String? hash,
    String? ext,
    String? mime,
    double? size,
    String? url,
    dynamic previewUrl,
    String? provider,
    dynamic providerMetadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MediaAttributes(
      name: name ?? this.name,
      alternativeText: alternativeText ?? this.alternativeText,
      caption: caption ?? this.caption,
      width: width ?? this.width,
      height: height ?? this.height,
      formats: formats ?? this.formats,
      hash: hash ?? this.hash,
      ext: ext ?? this.ext,
      mime: mime ?? this.mime,
      size: size ?? this.size,
      url: url ?? this.url,
      previewUrl: previewUrl ?? this.previewUrl,
      provider: provider ?? this.provider,
      providerMetadata: providerMetadata ?? this.providerMetadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      name,
      alternativeText,
      caption,
      width,
      height,
      formats,
      hash,
      ext,
      mime,
      size,
      url,
      previewUrl,
      provider,
      providerMetadata,
      createdAt,
      updatedAt,
    ];
  }
}
