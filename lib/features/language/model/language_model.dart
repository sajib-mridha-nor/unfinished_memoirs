// To parse this JSON data, do
//
//     final languageModel = languageModelFromJson(jsonString);

import 'dart:convert';

List<LanguageModel> languageModelFromJson(String str) =>
    List<LanguageModel>.from(
        json.decode(str).map((x) => LanguageModel.fromJson(x)));

String languageModelToJson(List<LanguageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LanguageModel {
  int? id;
  String? name;
  Language? language;
  String? totalPages;
  String? coverImage;
  String? translatedName;
  DateTime? createdAt;
  DateTime? updatedAt;

  LanguageModel({
    this.id,
    this.name,
    this.language,
    this.totalPages,
    this.coverImage,
    this.translatedName,
    this.createdAt,
    this.updatedAt,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        id: json['id'],
        name: json['name'],
        language: json['language'] == null
            ? null
            : Language.fromJson(json['language']),
        totalPages: json['total_pages'],
        coverImage: json['cover_image'],
        translatedName: json['translated_name'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'language': language?.toJson(),
        'total_pages': totalPages,
        'cover_image': coverImage,
        'translated_name': translatedName,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}

class Language {
  int? id;
  String? name;
  String? icon;

  Language({
    this.id,
    this.name,
    this.icon,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json['id'],
        name: json['name'],
        icon: json['icon'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'icon': icon,
      };
}
