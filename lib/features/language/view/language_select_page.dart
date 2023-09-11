import 'package:bongobondhu_app/core/theme/colors.dart';
import 'package:bongobondhu_app/core/utils/app_navigator.dart';
import 'package:bongobondhu_app/core/utils/language_preference.dart';
import 'package:bongobondhu_app/core/utils/padding.dart';
import 'package:bongobondhu_app/core/widgets/common_image_widget.dart';
import 'package:bongobondhu_app/features/index/view/index_page.dart';
import 'package:bongobondhu_app/features/language/model/language_model.dart';
import 'package:bongobondhu_app/features/language/view_model/language_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSelectPage extends StatefulWidget {
  const LanguageSelectPage({super.key});

  @override
  State<LanguageSelectPage> createState() => _LanguageSelectPageState();
}

class _LanguageSelectPageState extends State<LanguageSelectPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [lightWhiteColor, Color(0xffead9b4)],
            ),
          ),
          child: Padding(
            padding: commonScaffoldPadding,
            child: Consumer<LanguageViewModel>(
              builder: (context, languageVm, _) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 20),
                  child: languageVm.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: languageVm.languages.length,
                          itemBuilder: (context, index) {
                            return _languageCard(languageVm.languages[index]);
                          },
                        ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _languageCard(LanguageModel languageModel) {
    return Consumer<LanguageViewModel>(
      builder: (context, lanVm, _) {
        return InkWell(
          onTap: () async {
            await lanVm.setLanguageID('${languageModel.language?.id}');
            await lanVm.setTotalPage('${languageModel.totalPages}');
            if (languageModel.language?.name == 'English') {
              await LanguagePreference().setLanguage('en');
            } else {
              await LanguagePreference().setLanguage('bn');
            }
            await lanVm.getLanguage();
            await AppNavigator.push(
              const IndexPage(),
            );
          },
          child: Column(
            children: [
              CommonImageWidget(
                imageUrl: languageModel.coverImage ?? '',
                height: MediaQuery.sizeOf(context).height / 2 - 140,
                width: 210,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 38,
                width: 122,
                decoration: BoxDecoration(
                  color: const Color(0xffEAD9B4),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: const Color(0xffA3A3A3),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonImageWidget(
                      imageUrl: languageModel.language?.icon ?? '',
                      height: 15,
                      width: 26,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      languageModel.language?.name ?? '',
                      style: const TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
