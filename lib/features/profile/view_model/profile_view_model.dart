import 'package:bongobondhu_app/features/profile/model/profile_model.dart';
import 'package:bongobondhu_app/features/profile/repository/get_profile_data_repository.dart';
import 'package:bongobondhu_app/features/profile/repository/update_profile_data_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileViewModel with ChangeNotifier {
  static ProfileViewModel read(BuildContext context) =>
      context.read<ProfileViewModel>();

  static ProfileViewModel watch(BuildContext context) =>
      context.watch<ProfileViewModel>();
  bool _isEdit = false;
  DateTime? dob;
  TextEditingController firstNameTextController = TextEditingController();
  TextEditingController lastNameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController userTextController = TextEditingController();
  TextEditingController dobTextController = TextEditingController();

  set isEdit(bool v) {
    _isEdit = v;
    notifyListeners();
  }

  bool _isLoading = false;
  ProfileModel? _profileModel;
  XFile? selectedImage;

  set isLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  Future<void> getProfileData() async {
    isLoading = true;

    final res = await ProfileGetRepository().getData();
    res.fold((l) {
      isLoading = false;
      _profileModel = null;
      notifyListeners();
    }, (r) {
      _profileModel = r;
      if (_profileModel != null) {
        firstNameTextController.text = r.firstName ?? '';
        lastNameTextController.text = r.lastName ?? '';
        dobTextController.text = r.dateOfBirth ?? '';
        userTextController.text = r.username ?? '';
        emailTextController.text = r.email ?? '';
      }
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> updateProfileData() async {
    isLoading = true;
    final body = {
      'first_name': firstNameTextController.text,
      'last_name': lastNameTextController.text,
      'username': userTextController.text,
      'email': emailTextController.text,
      'date_of_birth': dob.toString(),
    };
    final res = await ProfileUpdateRepository().updateData(
      body: body,
      filePath: selectedImage?.path,
    );
    res.fold((l) {
      isLoading = false;
      _profileModel = null;
      notifyListeners();
    }, (r) {
      isLoading = false;
      isEdit = false;
      getProfileData();
      notifyListeners();
    });
  }

  bool get isEdit => _isEdit;
  bool get isLoading => _isLoading;
  ProfileModel? get profileModel => _profileModel;
}
