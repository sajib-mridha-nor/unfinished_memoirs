import 'package:audioplayers/audioplayers.dart';
import 'package:bongobondhu_app/core/theme/colors.dart';
import 'package:bongobondhu_app/core/theme/view_model/theme_manager_view_model.dart';
import 'package:bongobondhu_app/core/utils/app_navigator.dart';
import 'package:bongobondhu_app/core/utils/exports.dart';
import 'package:bongobondhu_app/core/utils/language.dart';
import 'package:bongobondhu_app/core/utils/theme_type.dart';
import 'package:bongobondhu_app/core/utils/urls.dart';
import 'package:bongobondhu_app/core/widgets/exports.dart';
import 'package:bongobondhu_app/features/bookmark/view_model/bookmark_view_model.dart';
import 'package:bongobondhu_app/features/home/view_model/audio_player_view_model.dart';
import 'package:bongobondhu_app/features/home/view_model/home_view_model.dart';
import 'package:bongobondhu_app/features/index/model/content_data_model.dart';
import 'package:bongobondhu_app/features/index/view_model/index_view_model.dart';
import 'package:bongobondhu_app/features/language/view_model/language_view_model.dart';
import 'package:bongobondhu_app/features/login_screen/view_model/login_view_model.dart';
import 'package:bongobondhu_app/features/profile/view/profile_sreen.dart';
import 'package:bongobondhu_app/features/profile/view_model/profile_view_model.dart';
import 'package:bongobondhu_app/features/settings/view/settings_page.dart';
import 'package:bongobondhu_app/features/splash/view/splash_page.dart';
import 'package:bongobondhu_app/l10n/l10n.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final _homeVm = HomeViewModel.read(context);
    final _signVm = LoginViewModel.read(context);
    final _profileVm = ProfileViewModel.read(context);
    super.initState();
    Future.delayed(Duration.zero, () async {
      await LanguageViewModel.read(context).getTotalPage();

      await _homeVm.reloadPage().then(
        (value) async {
          return _homeVm.listenForPermissions();
        },
      );
      if (!_homeVm.speechEnabled) {
        await _homeVm.initSpeech();
      }

      if (await _signVm.isLoggedIn()) {
        await _profileVm.getProfileData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManagerViewModel>(
      builder: (context, themeVm, child) {
        return Scaffold(
          backgroundColor: themeVm.themeType == ThemeType.Dark
              ? Theme.of(context).colorScheme.background
              : Colors.white,
          appBar: _appBar(themeVm),
          body: _bodyWidget(),
          bottomNavigationBar: _bottomNavBarWidget(themeVm),
        );
      },
    );
  }

  PreferredSizeWidget _appBar(ThemeManagerViewModel themeVm) {
    return AppBar(
      backgroundColor: themeVm.themeType == ThemeType.Dark
          ? darkScaffoldColor
          : Colors.white,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
        child: Consumer<ProfileViewModel>(
          builder: (context, profileVm, _) {
            return InkWell(
              onTap: () async {
                final _signVm = LoginViewModel.read(context);
                if (await _signVm.isLoggedIn()) {
                  await AppNavigator.push(const ProfileScreen());
                } else {
                  BotToast.showText(text: Localize().l10n.loginRequired);
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CommonImageWidget(
                  imageUrl:
                      '${Urls.imageBaseUrl}${profileVm.profileModel?.profilePic}',
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
      title: Consumer<HomeViewModel>(
        builder: (context, homeVm, _) {
          return homeVm.isSearch
              ? SizedBox(
                  height: 35,
                  child: TextFormField(
                    style: GoogleFonts.openSans(
                      color: darkScaffoldColor,
                    ),
                    controller: homeVm.controller,
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: (v) {
                      homeVm.searchWord(v);
                    },
                    decoration: InputDecoration(
                      hintText: Localize().l10n.search,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: GoogleFonts.openSans(
                        color: darkScaffoldColor,
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: homeVm.speechToText.isNotListening
                                ? homeVm.startListening
                                : homeVm.stopListening,
                            child: const Icon(Icons.mic, color: kSecondColor),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              homeVm.searchWord(homeVm.controller.text);
                              FocusManager.instance.primaryFocus!.unfocus();
                            },
                            child:
                                const Icon(Icons.search, color: kSecondColor),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      filled: true,
                      fillColor: textFillColor,
                    ),
                  ),
                )
              : const SizedBox();
        },
      ),
      actions: [
        Consumer<LanguageViewModel>(
          builder: (context, languageVm, child) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 15,
                right: 12,
                bottom: 9,
              ),
              child: InkWell(
                onTap: () async {
                  await AppNavigator.pushAndRemoveUntil(const SplashPage());
                },
                child: Container(
                  height: 27.5,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color(0xffa4a4a4),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        languageVm.languageType == LanguageType.English
                            ? 'assets/usa_flag.png'
                            : 'assets/bd_flag.png',
                        height: 10,
                        width: 18,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        Localize().l10n.language,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        // Padding(
        //   padding: const EdgeInsets.only(right: 20),
        //   child: InkWell(
        //     onTap: () {
        //       Navigator.of(context).push(
        //         MaterialPageRoute(
        //           builder: (context) => const SideBarPage(),
        //         ),
        //       );
        //     },
        //     child: Image.asset(
        //       burgerMenuIconPath,
        //       height: 20,
        //       width: 22,
        //       color: themeVm.themeType == ThemeType.Dark
        //           ? primaryWhite
        //           : const Color(0xff1D1D1D),
        //     ),
        //   ),
        // )
      ],
    );
  }

  Widget _bodyWidget() {
    final themeVm = ThemeManagerViewModel.watch(context);

    final isDark = themeVm.themeType == ThemeType.Dark || false;
    return Consumer<HomeViewModel>(
      builder: (context, homeVm, _) {
        return homeVm.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width / 2.1,
                          height: 30,
                          child: Consumer<IndexViewModel>(
                            builder: (context, indexVm, _) {
                              return DropdownButtonFormField<ContentDataModel>(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: isDark
                                      ? kDarkPrimaryColor
                                      : kPrimaryColor,
                                  contentPadding: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    top: 5,
                                    bottom: 5,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(12),
                                value: homeVm.selectedContent,
                                isExpanded: true,
                                hint: Text(
                                  '',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 14,
                                    color: const Color(0xffD2D2D2),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: greyColor,
                                ),
                                // Array list of items
                                items: indexVm.contentList.map((items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: TextWidget('${items.content}'),
                                  );
                                }).toList(),

                                onChanged: (v) {
                                  if (v != homeVm.selectedContent) {
                                    _resetSearch(homeVm);
                                  }
                                  homeVm
                                    ..selectedContent = v
                                    ..selectedPage =
                                        homeVm.selectedContent!.startPage
                                    ..reloadPage();
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width / 3.5,
                          height: 30,
                          child: Consumer<IndexViewModel>(
                            builder: (context, indexVm, _) {
                              return Consumer<LanguageViewModel>(
                                builder: (context, lanVm, _) {
                                  return DropdownButtonFormField<int>(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: isDark
                                          ? kDarkPrimaryColor
                                          : kPrimaryColor,
                                      contentPadding: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 5,
                                        bottom: 5,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide.none,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide.none,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    value: homeVm.selectedPage,
                                    isExpanded: true,
                                    hint: Text(
                                      '',
                                      style: GoogleFonts.urbanist(
                                        fontSize: 14,
                                        color: const Color(0xffD2D2D2),
                                      ),
                                    ),
                                    elevation: 16,
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: greyColor,
                                    ),
                                    // Array list of items
                                    items: List.generate(
                                      int.parse(lanVm.totalPage ?? '0'),
                                      (index) => index + 1,
                                    ).map((items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Center(
                                          child: TextWidget(
                                            '$items/${lanVm.totalPage}',
                                          ),
                                        ),
                                      );
                                    }).toList(),

                                    onChanged: (v) {
                                      if (v != homeVm.selectedPage) {
                                        _resetSearch(homeVm);
                                      }
                                      homeVm
                                        ..selectedPage = v!
                                        ..selectedContent = indexVm.contentList
                                            .where((element) {
                                              return homeVm.selectedPage >=
                                                      element.startPage &&
                                                  homeVm.selectedPage <=
                                                      element.endPage;
                                            })
                                            .toList()
                                            .first
                                        ..reloadPage();
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (homeVm.pageData?.isImage == true)
                      CommonImageWidget(
                        imageUrl: '${Urls.baseUrl}${homeVm.pageData?.image}',
                        height: MediaQuery.sizeOf(context).height - 330,
                        width: MediaQuery.sizeOf(context).width,
                      )
                    else
                      Expanded(
                        child: Consumer<AudioPlayerViewModel>(
                          builder: (context, audioVm, _) {
                            return SingleChildScrollView(
                              controller: audioVm.controller,
                              child: Wrap(
                                textDirection: TextDirection.ltr,
                                //runAlignment: WrapAlignment.center,
                                alignment: WrapAlignment.spaceEvenly,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                   Directionality(
            
            textDirection: TextDirection.ltr,
            child: CustomPopupMenu(
              menuBuilder: _buildLongPressMenu,
              pressType: PressType.longPress,
              menuOnChange: (v) {
                
              },
              child: TextWidget(
               "গাবতলী উপজেলা বাংলাদেশের বগুড়া জেলার একটি প্রশাসনিক এলাকা। গাবতলীকে ১৯৮৩ সালে উপজেলায় উন্নিত করা হয়।",
                style: TextStyles.regular14.copyWith(
                  fontSize: 16,
                  color: 1 == homeVm.selectedLine
                      ? Colors.teal
                      : homeVm.searchIndexList.contains(1.toString())
                          ? Colors.amber
                          : 2 == 2
                              ? const Color(0xff67c012)
                              : Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              );
      },
    );
  }

  List<Widget> _wrapSentenceList(HomeViewModel homeVm) {
    final _sentences = <Widget>[];
    final _audioVm = AudioPlayerViewModel.watch(context);
    final len = homeVm.pageData?.pageLines?.length ?? 0;
    for (var index = 0; index < len; index++) {
      final _sentenceText = homeVm.pageData?.pageLines?[index].lineText;
      final _splitText = _sentenceText?.split(' ');

      for (var i = 0; i < _splitText!.length; i++) {
        _sentences.add(
          Directionality(
            key: i == 0 ? _audioVm.globalKeys[index] : null,
            textDirection: TextDirection.ltr,
            child: CustomPopupMenu(
              menuBuilder: _buildLongPressMenu,
              pressType: PressType.longPress,
              menuOnChange: (v) {
                if (v) {
                  homeVm.selectedLine = index;
                } else {
                  homeVm.selectedLine = -1;
                }
              },
              child: TextWidget(
                i == _splitText.length - 1
                    ? _splitText[i]
                    : '${_splitText[i]} ',
                style: TextStyles.regular14.copyWith(
                  fontSize: 16,
                  color: index == homeVm.selectedLine
                      ? Colors.teal
                      : homeVm.searchIndexList.contains(index.toString())
                          ? Colors.amber
                          : index == _audioVm.selectedIndex
                              ? const Color(0xff67c012)
                              : Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ),
        );
      }
    }
    return _sentences;
  }

  Widget _bottomNavBarWidget(ThemeManagerViewModel themeVm) {
    final _color =
        themeVm.themeType == ThemeType.Dark ? primaryWhite : kSecondColor;

    return Consumer<HomeViewModel>(
      builder: (context, homeVm, _) {
        return Container(
          color: themeVm.themeType == ThemeType.Dark
              ? darkScaffoldColor
              : kScaffoldColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<IndexViewModel>(
                    builder: (context, indexVm, _) {
                      return InkWell(
                        onTap: homeVm.selectedPage == 1
                            ? null
                            : () {
                                homeVm
                                  ..selectedPage -= 1
                                  ..selectedContent = indexVm.contentList
                                      .where((element) {
                                        return homeVm.selectedPage >=
                                                element.startPage &&
                                            homeVm.selectedPage <=
                                                element.endPage;
                                      })
                                      .toList()
                                      .first
                                  ..reloadPage();
                              },
                        child: Image.asset(
                          leftArrowIconPath,
                          height: 24,
                          width: 24,
                          color: _color,
                        ),
                      );
                    },
                  ),
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      _color,
                      BlendMode.modulate,
                    ),
                    child: Lottie.asset(
                      musicAnimationPath,
                      height: 60,
                      width: MediaQuery.of(context).size.width / 1.5,
                      fit: BoxFit.fill,
                      animate: homeVm.isPlay,
                    ),
                  ),
                  Consumer<IndexViewModel>(
                    builder: (context, indexVm, _) {
                      return Consumer<LanguageViewModel>(
                        builder: (context, lanVm, _) {
                          return InkWell(
                            onTap: homeVm.selectedPage.toString() ==
                                    lanVm.totalPage
                                ? null
                                : () {
                                    homeVm
                                      ..selectedPage += 1
                                      ..selectedContent = indexVm.contentList
                                          .where((element) {
                                            return homeVm.selectedPage >=
                                                    element.startPage &&
                                                homeVm.selectedPage <=
                                                    element.endPage;
                                          })
                                          .toList()
                                          .first
                                      ..reloadPage();
                                  },
                            child: Image.asset(
                              rightArrowIconPath,
                              height: 24,
                              width: 24,
                              color: _color,
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
              MoltenBottomNavigationBar(
                barHeight: 53,
                barColor: themeVm.themeType == ThemeType.Dark
                    ? kDarkPrimaryColor
                    : lightWhiteColor,
                selectedIndex: 2,
                onTabChange: (clickedIndex) {},
                domeCircleColor: _color,
                tabs: [
                  MoltenTab(
                    icon: InkWell(
                      onTap: () {
                        homeVm.isSearch = !homeVm.isSearch;
                      },
                      child: Image.asset(
                        searchIconPath,
                        color: _color,
                      ),
                    ),
                    unselectedColor: kSecondColor,
                  ),
                  MoltenTab(
                    icon: Consumer<AudioPlayerViewModel>(
                      builder: (context, audioVm, _) {
                        return InkWell(
                          onTap: () {
                            audioVm.isMute ? audioVm.unMute() : audioVm.mute();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              audioVm.isMute? muteIconPath : unmuteIconPath,
                              color: _color,
                            ),
                          ),
                        );
                      },
                    ),
                    unselectedColor: kSecondColor,
                  ),
                  MoltenTab(
                    icon: Consumer<AudioPlayerViewModel>(
                      builder: (context, audioVm, _) {
                        return InkWell(
                          onTap: () {
                            if (homeVm.pageData?.audio != null) {
                              homeVm.isPlay = !homeVm.isPlay;
                              homeVm.isPlay
                                  ? audioVm
                                      .playAudio(homeVm.pageData?.audio ?? '')
                                  : audioVm.pauseAudio();
                              if (homeVm.isPlay) {
                                if (audioVm.selectedIndex == -1) {
                                  audioVm.selectedIndex = 0;
                                }
                                audioVm.audioPlayer.onDurationChanged
                                    .listen((Duration d) {
                                  audioVm.playerDurationChange(d);
                                });

                                audioVm.audioPlayer.onPositionChanged
                                    .listen((Duration position) {
                                  audioVm.positionChange(
                                    position,
                                  );
                                });
                                audioVm.audioPlayer.onPlayerStateChanged
                                    .listen((PlayerState s) async {
                                  await audioVm.playerStateChange(
                                    s,
                                  );
                                });
                              }
                            } else {
                              BotToast.showText(text: 'No audio found');
                            }
                          },
                          child: Icon(
                            homeVm.isPlay ? Icons.pause : Icons.play_arrow,
                            color: themeVm.themeType == ThemeType.Dark
                                ? kDarkPrimaryColor
                                : lightWhiteColor,
                          ),
                        );
                      },
                    ),
                  ),
                  MoltenTab(
                    icon: Consumer<ThemeManagerViewModel>(
                        builder: (context, themeVm, _) {
                      return InkWell(
                        onTap: () {
                          themeVm.isDark = !themeVm.isDark;
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            themeIconPath,
                            color: _color,
                          ),
                        ),
                      );
                    }),
                    unselectedColor: kSecondColor,
                  ),
                  MoltenTab(
                    icon: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SettingPage(),
                          ),
                        );
                      },
                      child: Image.asset(
                        settingsIconPath,
                        color: _color,
                      ),
                    ),
                    unselectedColor: kSecondColor,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _resetSearch(HomeViewModel homeVm) {
    homeVm.searchIndexList = [];
    homeVm.controller.clear();
    FocusManager.instance.primaryFocus!.unfocus();
  }

  ///
  List<ItemModel> menuItems = [
    ItemModel('Copy', Icons.content_copy),
    ItemModel('Play', Icons.play_arrow),
    ItemModel('Add', Icons.bookmark_add),
  ];

  Widget _buildLongPressMenu() {
    final _homeVm = HomeViewModel.read(context);
    final _bookmarkVm = BookmarkViewModel.read(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: 140,
        height: 70,
        color: const Color(0xFF4C4C4C),
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () async {
                await Clipboard.setData(
                  ClipboardData(
                    text: _homeVm.pageData
                            ?.pageLines![_homeVm.selectedLine ?? 0].lineText ??
                        '',
                  ),
                ).then((value) {
                  BotToast.showText(text: Localize().l10n.textCopied);
                });
              },
              child: _popUpItem(menuItems[0].icon, menuItems[0].title),
            ),
            InkWell(
              onTap: () {
                AudioPlayerViewModel.read(context).onTapPlay(
                  homeVm: _homeVm,
                  lineIndex: _homeVm.selectedLine ?? 0,
                );
              },
              child: _popUpItem(menuItems[1].icon, menuItems[1].title),
            ),
            InkWell(
              onTap: () async {
                final _signVm = LoginViewModel.read(context);
                if (await _signVm.isLoggedIn()) {
                  await _bookmarkVm.addBookmark(
                    lineId: _homeVm
                            .pageData?.pageLines?[_homeVm.selectedLine ?? 0].id
                            .toString() ??
                        '',
                  );
                } else {
                  BotToast.showText(text: 'Login required');
                }
              },
              child: _popUpItem(menuItems[2].icon, menuItems[2].title),
            ),
          ],
        ),
        // child: GridView.count(
        //   padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        //   crossAxisCount: 3,
        //   mainAxisSpacing: 10,
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   children: menuItems
        //       .map((item) => Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: <Widget>[
        //               Icon(
        //                 item.icon,
        //                 size: 20,
        //                 color: Colors.white,
        //               ),
        //               Container(
        //                 margin: const EdgeInsets.only(top: 2),
        //                 child: Text(
        //                   item.title,
        //                   style: const TextStyle(
        //                     color: Colors.white,
        //                     fontSize: 12,
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ))
        //       .toList(),
        // ),
      ),
    );
  }

  Widget _popUpItem(IconData icon, String title) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          icon,
          size: 30,
          color: Colors.white,
        ),
        Container(
          margin: const EdgeInsets.only(top: 2),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

class ItemModel {
  String title;
  IconData icon;

  ItemModel(this.title, this.icon);
}
