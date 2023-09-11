// To parse this JSON data, do
//
//     final pageDataModel = pageDataModelFromJson(jsonString);

import 'dart:convert';

PageDataModel pageDataModelFromJson(String str) =>
    PageDataModel.fromJson(json.decode(str));

String pageDataModelToJson(PageDataModel data) => json.encode(data.toJson());

class PageDataModel {
  int? id;
  int? pageNumber;
  dynamic voice;
  dynamic speed;
  dynamic audioPath;
  String? audio;
  dynamic audioLength;
  dynamic lineBreakSleep;
  bool isImage;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<PageLine>? pageLines;

  PageDataModel({
    this.id,
    this.pageNumber,
    this.voice,
    this.speed,
    this.audioPath,
    this.audio,
    this.audioLength,
    this.lineBreakSleep,
    this.isImage = false,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.pageLines,
  });

  factory PageDataModel.fromJson(Map<String, dynamic> json) => PageDataModel(
        id: json['id'],
        pageNumber: json['page_number'],
        voice: json['voice'],
        speed: json['speed'],
        audioPath: json['audio_path'],
        audio: json['audio'],
        audioLength: json['audio_length'],
        lineBreakSleep: json['line_break_sleep'],
        isImage: json['is_image'],
        image: json['image'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
        pageLines: json['page_lines'] == null
            ? []
            : List<PageLine>.from(
                json['page_lines']!.map((x) => PageLine.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'page_number': pageNumber,
        'voice': voice,
        'speed': speed,
        'audio_path': audioPath,
        'audio': audio,
        'audio_length': audioLength,
        'line_break_sleep': lineBreakSleep,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'page_lines': pageLines == null
            ? []
            : List<dynamic>.from(pageLines!.map((x) => x.toJson())),
      };
}

class PageLine {
  int? id;
  PageNumber? pageNumber;
  int? lineSerial;
  dynamic paragraphCount;
  dynamic sentenceCount;
  dynamic wordCount;
  String? lineText;
  bool? isImage;
  dynamic totalPage;
  String? startTime;
  String? endTime;
  DateTime? createdAt;
  DateTime? updatedAt;

  PageLine({
    this.id,
    this.pageNumber,
    this.lineSerial,
    this.paragraphCount,
    this.sentenceCount,
    this.wordCount,
    this.lineText,
    this.isImage,
    this.totalPage,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.updatedAt,
  });

  factory PageLine.fromJson(Map<String, dynamic> json) => PageLine(
        id: json['id'],
        pageNumber: json['page_number'] == null
            ? null
            : PageNumber.fromJson(json['page_number']),
        lineSerial: json['line_serial'],
        paragraphCount: json['paragraph_count'],
        sentenceCount: json['sentence_count'],
        wordCount: json['word_count'],
        lineText: json['line_text'],
        isImage: json['is_image'],
        totalPage: json['total_page'],
        startTime: json['start_time'],
        endTime: json['end_time'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'page_number': pageNumber?.toJson(),
        'line_serial': lineSerial,
        'paragraph_count': paragraphCount,
        'sentence_count': sentenceCount,
        'word_count': wordCount,
        'line_text': lineText,
        'is_image': isImage,
        'total_page': totalPage,
        'start_time': startTime,
        'end_time': endTime,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}

class PageNumber {
  int? id;
  int? number;
  int? audioBook;
  int? chapter;

  PageNumber({
    this.id,
    this.number,
    this.audioBook,
    this.chapter,
  });

  factory PageNumber.fromJson(Map<String, dynamic> json) => PageNumber(
        id: json['id'],
        number: json['number'],
        audioBook: json['audio_book'],
        chapter: json['chapter'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'number': number,
        'audio_book': audioBook,
        'chapter': chapter,
      };
}
