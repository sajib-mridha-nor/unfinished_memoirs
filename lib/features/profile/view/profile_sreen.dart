import 'dart:io';

import 'package:bongobondhu_app/core/theme/colors.dart';
import 'package:bongobondhu_app/core/theme/view_model/theme_manager_view_model.dart';
import 'package:bongobondhu_app/core/utils/exports.dart';
import 'package:bongobondhu_app/core/utils/theme_type.dart';
import 'package:bongobondhu_app/core/utils/urls.dart';
import 'package:bongobondhu_app/core/widgets/exports.dart';
import 'package:bongobondhu_app/core/widgets/profile_text_field.dart';
import 'package:bongobondhu_app/features/profile/view_model/profile_view_model.dart';
import 'package:bongobondhu_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    ProfileViewModel.read(context).getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    final themeVm = ThemeManagerViewModel.watch(context);
    final isDark = themeVm.themeType == ThemeType.Dark || false;
    final l10n = Localize().l10n;
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: Consumer<ProfileViewModel>(
        builder: (context, profileVm, _) {
          return Padding(
            padding: allPadding20,
            child: CommonButton(
              buttonColor: isDark ? kDarkPrimaryColor : kPrimaryColor,
              buttonTitle: profileVm.isEdit
                  ? l10n.updateTextKey
                  : l10n.editProfileTextKey,
              onTap: () {
                profileVm.isEdit = !profileVm.isEdit;
                if (!profileVm.isEdit) {
                  profileVm.updateProfileData();
                }
              },
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    final themeVm = ThemeManagerViewModel.watch(context);
    return AppBar(
      elevation: 0,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: themeVm.isDark ? primaryWhite : primaryBlack,
        ),
      ),
    );
  }

  Widget _body() {
    final themeVm = ThemeManagerViewModel.watch(context);
    final isDark = themeVm.themeType == ThemeType.Dark || false;
    final l10n = Localize().l10n;
    return Consumer<ProfileViewModel>(
      builder: (context, profileVm, _) {
        return Padding(
          padding: allPadding20,
          child: profileVm.isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  color: isDark ? kDarkPrimaryColor : kPrimaryColor,
                  onRefresh: () async {
                    await profileVm.getProfileData();
                  },
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            if (profileVm.selectedImage != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                  File(
                                    profileVm.selectedImage!.path,
                                  ),
                                  height: 160,
                                  width: 160,
                                  fit: BoxFit.fill,
                                ),
                              )
                            else
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CommonImageWidget(
                                  imageUrl:
                                      '${Urls.imageBaseUrl}${profileVm.profileModel?.profilePic}',
                                  height: 160,
                                  width: 160,
                                ),
                              ),
                            if (profileVm.isEdit)
                              GestureDetector(
                                onTap: selectImages,
                                child: Container(
                                  height: 80,
                                  width: 160,
                                  decoration: const BoxDecoration(
                                    color: textFillColor,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(150),
                                      bottomRight: Radius.circular(150),
                                    ),
                                  ),
                                  child: Center(
                                    child: TextWidget(
                                      'Edit',
                                      style: TextStyles.title20
                                          .copyWith(color: Colors.black),
                                    ),
                                  ),
                                ),
                              )
                            else
                              const SizedBox(),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextWidget(
                          profileVm.profileModel?.username ?? '-',
                          style: TextStyles.title20.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        ProfileTextField(
                          isFilled: true,
                          labelText: Localize().l10n.firstName,
                          readOnly: !profileVm.isEdit,
                          controller: profileVm.firstNameTextController,
                        ),
                        ProfileTextField(
                          isFilled: true,
                          labelText: Localize().l10n.lastName,
                          readOnly: !profileVm.isEdit,
                          controller: profileVm.lastNameTextController,
                        ),
                        ProfileTextField(
                          isFilled: true,
                          labelText: Localize().l10n.email,
                          readOnly: true,
                          controller: profileVm.emailTextController,
                        ),
                        ProfileTextField(
                          isFilled: true,
                          labelText: Localize().l10n.userName,
                          readOnly: true,
                          controller: profileVm.userTextController,
                        ),
                        ProfileTextField(
                          isFilled: true,
                          labelText: Localize().l10n.dateOfBirth,
                          readOnly: true,
                          controller: profileVm.dobTextController,
                          onTap: !profileVm.isEdit
                              ? null
                              : () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2999, 12, 31),
                                  ).then((date) {
                                    profileVm.dob = date;
                                    profileVm.dobTextController.text =
                                        DateFormat('yyyy-MM-dd').format(
                                            profileVm.dob ?? DateTime.now());
                                  });
                                },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  Future<void> selectImages({bool isCamera = false}) async {
    final profileVm = ProfileViewModel.read(context);
    if (isCamera) {
      final selectedImage =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 30);
      if (selectedImage != null) {
        profileVm.selectedImage = selectedImage;
      }
    } else {
      final selectedImage = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 30);
      if (selectedImage != null) {
        profileVm.selectedImage = selectedImage;
      }
    }
    setState(() {});
  }
}
