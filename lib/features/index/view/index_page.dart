import 'package:bongobondhu_app/core/theme/colors.dart';
import 'package:bongobondhu_app/core/theme/view_model/theme_manager_view_model.dart';
import 'package:bongobondhu_app/core/utils/app_navigator.dart';
import 'package:bongobondhu_app/core/utils/exports.dart';
import 'package:bongobondhu_app/core/utils/theme_type.dart';
import 'package:bongobondhu_app/core/widgets/exports.dart';
import 'package:bongobondhu_app/features/home/view/home_page.dart';
import 'package:bongobondhu_app/features/home/view_model/home_view_model.dart';
import 'package:bongobondhu_app/features/index/view_model/index_view_model.dart';
import 'package:bongobondhu_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await IndexViewModel.read(context).getContentData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    final l10n = Localize().l10n;
    const _height10 = SizedBox(
      height: 10,
    );

    return Consumer<IndexViewModel>(
      builder: (context, indexVm, _) {
        return indexVm.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: allPadding20,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        height: 185,
                        width: 185,
                      ),
                      _height10,
                      _height10,

                      _indexButton(
                        buttonTitle: l10n.indexTextKey,
                        width: 160,
                      ),
                      _height10,

                      TextWidget(
                        l10n.contentsTextKey,
                        style: TextStyles.title20,
                      ),
                      _height10,

                      _indexListWidget(),
                      _height10,

                      // _arrowButton(),
                      // _height10,
                    ],
                  ),
                ),
              );
      },
    );
  }

  Widget _indexListWidget() {
    final l10n = Localize().l10n;
    final _width = MediaQuery.of(context).size.width;
    const _height10 = SizedBox(
      height: 10,
    );
    return Consumer<IndexViewModel>(
      builder: (context, indexVm, _) {
        return ListView.builder(
          itemCount: indexVm.contentList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                _indexButton(
                  buttonTitle: indexVm.contentList[index].content ?? '',
                  width: _width - 40,
                  onTap: () {
                    final homeVm = HomeViewModel.read(context);
                    homeVm
                      ..selectedContent = indexVm.contentList[index]
                      ..selectedPage = homeVm.selectedContent!.startPage
                      ..reloadPage();
                    AppNavigator.push(const HomePage());
                  },
                ),
                _height10,
              ],
            );
          },
        );
      },
    );
  }

  Widget _indexButton({
    required String buttonTitle,
    required double width,
    VoidCallback? onTap,
  }) {
    final themeVm = ThemeManagerViewModel.watch(context);
    final isDark = themeVm.themeType == ThemeType.Dark || false;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isDark ? kDarkPrimaryColor : kPrimaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextWidget(
          buttonTitle,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyles.regular14.copyWith(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _arrowButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () async {
            HomeViewModel.read(context).selectedContent = null;
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all<Size?>(
              const Size(102, 40),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Image.asset(
              arrowIconPath,
              width: 34,
              height: 17,
            ),
          ),
        ),
      ],
    );
  }
}
