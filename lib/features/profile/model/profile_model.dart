import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  String? firstName;
  String? lastName;
  dynamic dateOfBirth;
  dynamic profilePic;
  String? username;
  String? email;

  ProfileModel({
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.profilePic,
    this.username,
    this.email,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        firstName: json['first_name'],
        lastName: json['last_name'],
        dateOfBirth: json['date_of_birth'],
        profilePic: json['profile_pic'],
        username: json['username'],
        email: json['email'],
      );

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'date_of_birth': dateOfBirth,
        'profile_pic': profilePic,
        'username': username,
        'email': email,
      };
}
