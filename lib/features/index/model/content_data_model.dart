// To parse this JSON data, do
//
//     final contentDataModel = contentDataModelFromJson(jsonString);

import 'dart:convert';

List<ContentDataModel> contentDataModelFromJson(String str) =>
    List<ContentDataModel>.from(
        json.decode(str).map((x) => ContentDataModel.fromJson(x)));

String contentDataModelToJson(List<ContentDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContentDataModel {
  int? id;
  AudioBook? audioBook;
  String? content;
  int startPage;
  int endPage;

  ContentDataModel({
    this.id,
    this.audioBook,
    this.content,
    this.startPage = 0,
    this.endPage = 0,
  });

  factory ContentDataModel.fromJson(Map<String, dynamic> json) =>
      ContentDataModel(
        id: json['id'],
        audioBook: json['audio_book'] == null
            ? null
            : AudioBook.fromJson(json['audio_book']),
        content: json['content'],
        startPage: json['start_page'],
        endPage: json['end_page'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'audio_book': audioBook?.toJson(),
        'content': content,
        'start_page': startPage,
        'end_page': endPage,
      };
}

class AudioBook {
  int? id;
  String? name;
  String? translatedName;
  String? coverImage;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? language;

  AudioBook({
    this.id,
    this.name,
    this.translatedName,
    this.coverImage,
    this.createdAt,
    this.updatedAt,
    this.language,
  });

  factory AudioBook.fromJson(Map<String, dynamic> json) => AudioBook(
        id: json['id'],
        name: json['name'],
        translatedName: json['translated_name'],
        coverImage: json['cover_image'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
        language: json['language'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'translated_name': translatedName,
        'cover_image': coverImage,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'language': language,
      };
}
