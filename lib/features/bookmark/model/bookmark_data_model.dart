// To parse this JSON data, do
//
//     final bookmarkDataModel = bookmarkDataModelFromJson(jsonString);

import 'dart:convert';

List<BookmarkDataModel> bookmarkDataModelFromJson(String str) =>
    List<BookmarkDataModel>.from(
        json.decode(str).map((x) => BookmarkDataModel.fromJson(x)));

String bookmarkDataModelToJson(List<BookmarkDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookmarkDataModel {
  int? id;
  User? user;
  LineSerial? lineSerial;
  DateTime? createdAt;
  DateTime? updatedAt;

  BookmarkDataModel({
    this.id,
    this.user,
    this.lineSerial,
    this.createdAt,
    this.updatedAt,
  });

  factory BookmarkDataModel.fromJson(Map<String, dynamic> json) =>
      BookmarkDataModel(
        id: json['id'],
        user: json['user'] == null ? null : User.fromJson(json['user']),
        lineSerial: json['line_serial'] == null
            ? null
            : LineSerial.fromJson(json['line_serial']),
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user?.toJson(),
        'line_serial': lineSerial?.toJson(),
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}

class LineSerial {
  int? id;
  int? lineSerial;
  dynamic paragraphCount;
  dynamic sentenceCount;
  dynamic wordCount;
  String? lineText;
  dynamic totalPage;
  String? startTime;
  String? endTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  PageNumber? pageNumber;

  LineSerial({
    this.id,
    this.lineSerial,
    this.paragraphCount,
    this.sentenceCount,
    this.wordCount,
    this.lineText,
    this.totalPage,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.updatedAt,
    this.pageNumber,
  });

  factory LineSerial.fromJson(Map<String, dynamic> json) => LineSerial(
        id: json['id'],
        lineSerial: json['line_serial'],
        paragraphCount: json['paragraph_count'],
        sentenceCount: json['sentence_count'],
        wordCount: json['word_count'],
        lineText: json['line_text'],
        totalPage: json['total_page'],
        startTime: json['start_time'],
        endTime: json['end_time'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
        pageNumber: json['page_number'] == null
            ? null
            : PageNumber.fromJson(json['page_number']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'line_serial': lineSerial,
        'paragraph_count': paragraphCount,
        'sentence_count': sentenceCount,
        'word_count': wordCount,
        'line_text': lineText,
        'total_page': totalPage,
        'start_time': startTime,
        'end_time': endTime,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'page_number': pageNumber?.toJson(),
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

class User {
  int? id;
  String? password;
  dynamic lastLogin;
  bool? isSuperuser;
  String? username;
  String? firstName;
  String? lastName;
  bool? isStaff;
  bool? isActive;
  DateTime? dateJoined;
  String? email;
  String? profilePic;
  DateTime? dateOfBirth;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic role;
  List<dynamic>? groups;
  List<dynamic>? userPermissions;

  User({
    this.id,
    this.password,
    this.lastLogin,
    this.isSuperuser,
    this.username,
    this.firstName,
    this.lastName,
    this.isStaff,
    this.isActive,
    this.dateJoined,
    this.email,
    this.profilePic,
    this.dateOfBirth,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.role,
    this.groups,
    this.userPermissions,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        password: json['password'],
        lastLogin: json['last_login'],
        isSuperuser: json['is_superuser'],
        username: json['username'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        isStaff: json['is_staff'],
        isActive: json['is_active'],
        dateJoined: json['date_joined'] == null
            ? null
            : DateTime.parse(json['date_joined']),
        email: json['email'],
        profilePic: json['profile_pic'],
        dateOfBirth: json['date_of_birth'] == null
            ? null
            : DateTime.parse(json['date_of_birth']),
        status: json['status'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
        role: json['role'],
        groups: json['groups'] == null
            ? []
            : List<dynamic>.from(json['groups']!.map((x) => x)),
        userPermissions: json['user_permissions'] == null
            ? []
            : List<dynamic>.from(json['user_permissions']!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'password': password,
        'last_login': lastLogin,
        'is_superuser': isSuperuser,
        'username': username,
        'first_name': firstName,
        'last_name': lastName,
        'is_staff': isStaff,
        'is_active': isActive,
        'date_joined': dateJoined?.toIso8601String(),
        'email': email,
        'profile_pic': profilePic,
        'date_of_birth': dateOfBirth?.toIso8601String(),
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'role': role,
        'groups':
            groups == null ? [] : List<dynamic>.from(groups!.map((x) => x)),
        'user_permissions': userPermissions == null
            ? []
            : List<dynamic>.from(userPermissions!.map((x) => x)),
      };
}
