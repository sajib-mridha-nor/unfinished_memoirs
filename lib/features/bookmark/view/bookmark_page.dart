import 'package:bongobondhu_app/core/theme/colors.dart';
import 'package:bongobondhu_app/core/theme/view_model/theme_manager_view_model.dart';
import 'package:bongobondhu_app/core/utils/app_navigator.dart';
import 'package:bongobondhu_app/core/utils/exports.dart';
import 'package:bongobondhu_app/core/utils/theme_type.dart';
import 'package:bongobondhu_app/core/widgets/text_widget.dart';
import 'package:bongobondhu_app/features/bookmark/view_model/bookmark_view_model.dart';
import 'package:bongobondhu_app/features/home/view_model/audio_player_view_model.dart';
import 'package:bongobondhu_app/features/home/view_model/home_view_model.dart';
import 'package:bongobondhu_app/features/index/view_model/index_view_model.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final bookmarkVm = BookmarkViewModel.read(context);
      await bookmarkVm.getBookmarkData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeVm = ThemeManagerViewModel.watch(context);
    final isDark = themeVm.themeType == ThemeType.Dark || false;
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          'Bookmark',
          style: TextStyles.title20,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: allPadding20,
        child: Consumer<IndexViewModel>(
          builder: (context, indexVm, _) {
            return Consumer<BookmarkViewModel>(
              builder: (context, bookmarkVm, child) {
                return bookmarkVm.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: bookmarkVm.bookmarkList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  BotToast.showLoading(allowClick: true);
                                  final _homeVm = HomeViewModel.read(context);
                                  _homeVm
                                    ..selectedPage = bookmarkVm
                                            .bookmarkList[index]
                                            .lineSerial
                                            ?.pageNumber
                                            ?.number ??
                                        1
                                    ..selectedContent = indexVm.contentList
                                        .where((element) {
                                          return _homeVm.selectedPage >=
                                                  element.startPage &&
                                              _homeVm.selectedPage <=
                                                  element.endPage;
                                        })
                                        .toList()
                                        .first;
                                  await _homeVm.reloadPage().then((value) {
                                    AudioPlayerViewModel.read(context)
                                      ..selectedIndex = _homeVm
                                          .pageData!.pageLines!
                                          .indexWhere(
                                        (element) =>
                                            element.lineText ==
                                            (bookmarkVm.bookmarkList[index]
                                                    .lineSerial?.lineText ??
                                                ''),
                                      )
                                      ..onTapPlay(
                                        homeVm: _homeVm,
                                        lineIndex:
                                            AudioPlayerViewModel.read(context)
                                                .selectedIndex,
                                      );
                                    BotToast.closeAllLoading();
                                    AppNavigator.pop();
                                    AppNavigator.pop();
                                  });
                                },
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? kDarkPrimaryColor
                                        : kPrimaryColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: TextWidget(
                                    bookmarkVm.bookmarkList[index].lineSerial
                                            ?.lineText ??
                                        '',
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    style: TextStyles.regular14.copyWith(
                                      fontSize: 16,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        },
                      );
              },
            );
          },
        ),
      ),
    );
  }
}
