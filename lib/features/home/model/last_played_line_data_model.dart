import 'dart:convert';

LastPlayedLineDataModel lastPlayedLineDataModelFromJson(String str) =>
    LastPlayedLineDataModel.fromJson(json.decode(str));

String lastPlayedLineDataModelToJson(LastPlayedLineDataModel data) =>
    json.encode(data.toJson());

class LastPlayedLineDataModel {
  int id;
  User user;
  LineSerial lineSerial;
  DateTime createdAt;
  DateTime updatedAt;
  int lang;

  LastPlayedLineDataModel({
    required this.id,
    required this.user,
    required this.lineSerial,
    required this.createdAt,
    required this.updatedAt,
    required this.lang,
  });

  factory LastPlayedLineDataModel.fromJson(Map<String, dynamic> json) =>
      LastPlayedLineDataModel(
        id: json['id'],
        user: User.fromJson(json['user']),
        lineSerial: LineSerial.fromJson(json['line_serial']),
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        lang: json['lang'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user.toJson(),
        'line_serial': lineSerial.toJson(),
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'lang': lang,
      };
}

class LineSerial {
  int id;
  int lineSerial;
  dynamic paragraphCount;
  dynamic sentenceCount;
  dynamic wordCount;
  String lineText;
  dynamic totalPage;
  String startTime;
  String endTime;
  DateTime createdAt;
  DateTime updatedAt;
  int pageNumber;

  LineSerial({
    required this.id,
    required this.lineSerial,
    required this.paragraphCount,
    required this.sentenceCount,
    required this.wordCount,
    required this.lineText,
    required this.totalPage,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
    required this.pageNumber,
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
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        pageNumber: json['page_number'],
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
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'page_number': pageNumber,
      };
}

class User {
  int id;
  String password;
  dynamic lastLogin;
  bool isSuperuser;
  String username;
  String firstName;
  String lastName;
  bool isStaff;
  bool isActive;
  DateTime dateJoined;
  String email;
  dynamic profilePic;
  dynamic dateOfBirth;
  dynamic status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic role;
  List<dynamic> groups;
  List<dynamic> userPermissions;

  User({
    required this.id,
    required this.password,
    required this.lastLogin,
    required this.isSuperuser,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.isStaff,
    required this.isActive,
    required this.dateJoined,
    required this.email,
    required this.profilePic,
    required this.dateOfBirth,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.groups,
    required this.userPermissions,
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
        dateJoined: DateTime.parse(json['date_joined']),
        email: json['email'],
        profilePic: json['profile_pic'],
        dateOfBirth: json['date_of_birth'],
        status: json['status'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        role: json['role'],
        groups: List<dynamic>.from(json['groups'].map((x) => x)),
        userPermissions:
            List<dynamic>.from(json['user_permissions'].map((x) => x)),
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
        'date_joined': dateJoined.toIso8601String(),
        'email': email,
        'profile_pic': profilePic,
        'date_of_birth': dateOfBirth,
        'status': status,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'role': role,
        'groups': List<dynamic>.from(groups.map((x) => x)),
        'user_permissions': List<dynamic>.from(userPermissions.map((x) => x)),
      };
}
